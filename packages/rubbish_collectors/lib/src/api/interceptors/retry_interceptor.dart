import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rubbish_collectors/src/api/interceptors/dio_connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  @override
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    if (_shouldRetry(err)) {
      try {
        final res =
            await requestRetrier.scheduleRequestRetry(err.requestOptions);
        handler.resolve(res);
      } catch (e) {
        return e;
      }
    }
    handler.reject(err);
  }

  bool _shouldRetry(DioError err) {
    return err.type != DioErrorType.response &&
        err.error != null &&
        err.error is SocketException;
  }
}
