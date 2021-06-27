import 'package:dio/dio.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';

void main() async {
  var client = RubbishCollectorsClient(
    interceptor: CustomInterceptors(),
    options: BaseOptions(
      baseUrl: "http://217.219.165.22:5005",
    ),
  );

  try {
    final data = await client.authSendCode(phone: "09116887239");
    print(data.value.toString());
  } catch (e) {
    print(e);
  }
}

class CustomInterceptors extends Interceptor {
  var accesstoken = "";
  var refreshToken =
      "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjUiLCJuYmYiOjE2MjQ3OTYxMDcsImV4cCI6MTYyNDgxNzcwNywiaWF0IjoxNjI0Nzk2MTA3fQ.F7TqXGWhNxK5eEBcAqJC4z3JsjvOoDcL7JYQZMslobURb8HqGKMCcS3LiF3e633m7WR-TfI_VqaOR8XPV6Tkiw";

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
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

    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      print("send again");
      await refreshTokenFn();
      try {
        final retryAnswer = await _retry(err.requestOptions);
        return handler.resolve(retryAnswer);
      } catch (e) {
        return handler.reject(err);
      }
    }

    return super.onError(err, handler);
  }

  Future<void> refreshTokenFn() async {
    final response = await Dio().post('http://217.219.165.22:5005/Auth/Refresh',
        data: {'refreshToken': refreshToken});

    if (response.statusCode == 200) {
      this.accesstoken = response.data["value"]['accesstoken'];
      this.refreshToken = response.data["value"]['refreshToken'];
      print("accesstoken");
      print(this.accesstoken);
      print("refreshToken");
      print(this.refreshToken);
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
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
