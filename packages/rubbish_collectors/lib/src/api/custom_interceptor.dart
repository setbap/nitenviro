import 'package:dio/dio.dart';

class CustomInterceptors extends Interceptor {
  final Future<String?> Function() getAccessToken;
  final Future<String?> Function() getRefreshToken;

  final Future Function(String token) setAccessToken;
  final Future Function(String token) setRefreshToken;
  final VoidCallback onAuthError;

  CustomInterceptors({
    required this.getAccessToken,
    required this.getRefreshToken,
    required this.setAccessToken,
    required this.setRefreshToken,
    required this.onAuthError,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accesstoken = await getAccessToken();
    options.headers['Authorization'] = 'Bearer ${accesstoken}';
    print(
      'REQUEST[${options.method}] => PATH: ${options.path}',
    );
    print(
      'REQUEST[header] => PATH: ${options.headers}',
    );
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.data}',
    );
    super.onResponse(response, handler);
  }

  @override
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.error}',
    );

    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.response}',
    );

    if (err.response?.statusCode == 401) {
      print("send again");
      await refreshTokenFn();
      try {
        final retryAnswer = await _retry(err.requestOptions);
        return handler.resolve(retryAnswer);
      } catch (e) {
        return handler.reject(err);
      }
    }
    if (err.response?.statusCode == 400) {
      print("400 error");
      return handler.resolve(err.response!);
    }

    return super.onError(err, handler);
  }

  Future<void> refreshTokenFn() async {
    final refreshToken = await getAccessToken();
    final response = await Dio().post(
      'http://217.219.165.22:5005/Auth/Refresh',
      data: {'refreshToken': refreshToken},
    );

    if (response.statusCode == 200) {
      setAccessToken(response.data["value"]['accesstoken']);
      setRefreshToken(response.data["value"]['refreshToken']);
      print("get token yeeyeyey");
    } else {
      onAuthError();
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final accesstoken = await getAccessToken();
    requestOptions.headers["Authorization"] = 'Bearer ${accesstoken}';
    final options = new Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    final response = await Dio().request(
      requestOptions.baseUrl + requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
    return response;
  }
}
