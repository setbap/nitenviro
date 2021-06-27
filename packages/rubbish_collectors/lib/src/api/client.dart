import 'package:dio/dio.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';

class RubbishCollectorsClient {
  final Dio dio;

  RubbishCollectorsClient({
    required Interceptor interceptor,
    required BaseOptions options,
  }) : dio = Dio(options) {
    dio.interceptors.add(interceptor);
  }

  Future<GenericResult<SendCodeResult>> authSendCode({
    required String phone,
  }) async {
    var sendCodeRawResponse = await dio.post(
      Endpoints.authSendCodePath(),
      data: {
        "phone": phone,
      },
    );
    final sendCodeResult = GenericResult<SendCodeResult>.fromJson(
      sendCodeRawResponse.data,
      (dynamic json) => SendCodeResult.fromJson(json),
    );
    return sendCodeResult;
  }

  Future<GenericResult<AuthTokenResult>> authLogin({
    required String phone,
    required int loginCode,
  }) async {
    var loginRawResponse = await dio.post(
      Endpoints.authLoginPath(),
      data: {"phone": phone, "loginCode": loginCode},
    );
    final loginResult = GenericResult<AuthTokenResult>.fromJson(
      loginRawResponse.data,
      (dynamic json) => AuthTokenResult.fromJson(json),
    );
    return loginResult;
  }

  Future<GenericResult<AuthTokenResult>> authRefresh({
    required String refreshToken,
  }) async {
    var refreshRawResponse = await dio.post(
      Endpoints.authRefreshPath(),
      data: {"refreshToken": refreshToken},
    );
    final refreshResult = GenericResult<AuthTokenResult>.fromJson(
      refreshRawResponse.data,
      (dynamic json) => AuthTokenResult.fromJson(json),
    );
    return refreshResult;
  }

  Future<GenericResult<UserInfoResult>> userGetInfo() async {
    var refreshRawResponse = await dio.get(
      Endpoints.userGetInfoPath(),
    );
    final refreshResult = GenericResult<UserInfoResult>.fromJson(
      refreshRawResponse.data,
      (dynamic json) => UserInfoResult.fromJson(json),
    );
    return refreshResult;
  }
}
