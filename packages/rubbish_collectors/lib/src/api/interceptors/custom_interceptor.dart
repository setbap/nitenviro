import 'dart:developer' as dev;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';
import 'package:rubbish_collectors/src/api/interceptors/dio_connectivity_request_retrier.dart';

class CustomInterceptors extends Interceptor {
  final Future<String?> Function() getAccessToken;
  final DioConnectivityRequestRetrier requestRetrier;
  final Future<String?> Function() getRefreshToken;
  final Dio dioClient;
  final Future Function(String token) setAccessToken;
  final Future Function(String token) setRefreshToken;
  final VoidCallback onAuthError;

  CustomInterceptors({
    required this.getAccessToken,
    required this.dioClient,
    required this.getRefreshToken,
    required this.setAccessToken,
    required this.setRefreshToken,
    required this.onAuthError,
    required this.requestRetrier,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accesstoken = await getAccessToken();
    options.headers['Authorization'] = 'Bearer $accesstoken';
    dev.log(
      'REQUEST[${options.method}] => PATH: ${options.path}',
    );
    dev.log(
      'REQUEST[header] => PATH: ${options.headers}',
    );
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    dev.log(
      'RESPONSE[${response.statusCode}] => PATH: ${response.data}',
    );
    super.onResponse(response, handler);
  }

  @override
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    dev.log(
      'ERROR[${err.response?.statusCode}] => ERROR: ${err.error}',
    );

    dev.log(
      'ERROR[${err.response?.statusCode}] => RES: ${err.response}',
    );

    if (err.response?.statusCode == 401) {
      dev.log("send again");
      try {
        await refreshTokenFn();
        dev.log("get refresh token");
        final retryAnswer = await _retry(err.requestOptions);
        return handler.resolve(retryAnswer);
      } catch (e) {
        dev.log("error in send again");
        return handler.reject(err);
      }
    }
    if (err.response?.statusCode == 400) {
      dev.log("400 error");
      return handler.resolve(err.response!);
    }
    if (err.response?.statusCode == 404 || err.response?.statusCode == 404) {
      return super.onError(err, handler);
    }
    if (_shouldRetry(err)) {
      dev.log("should retry");
      try {
        final res =
            await requestRetrier.scheduleRequestRetry(err.requestOptions);
        return handler.resolve(res);
      } catch (e) {
        dev.log("$e");
      }
    }

    return super.onError(err, handler);
  }

  bool _shouldRetry(DioError err) {
    return err.type != DioErrorType.response &&
        err.error != null &&
        err.error is SocketException;
  }

  Future refreshTokenFn() async {
    final refreshToken = await getRefreshToken();
    try {
      final response = await dioClient.post(
        Endpoints.authRefreshPath(),
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        setAccessToken(response.data["value"]['accesstoken']);
        setRefreshToken(response.data["value"]['refreshToken']);
        dev.log("get token yeeyeyey");
      } else {
        onAuthError();
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        onAuthError();
        rethrow;
      }
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final accesstoken = await getAccessToken();
    requestOptions.headers["Authorization"] = 'Bearer $accesstoken';
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    final response = await dioClient.request(
      requestOptions.path,
      cancelToken: requestOptions.cancelToken,
      data: requestOptions.data,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
    return response;
  }
}
