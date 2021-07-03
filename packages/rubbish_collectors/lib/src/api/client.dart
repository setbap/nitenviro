import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';
import 'package:rubbish_collectors/src/api/interceptors/dio_connectivity_request_retrier.dart';

class RubbishCollectorsClient {
  final Dio dio;
  final Future<String?> Function() getAccessToken;
  final Future<String?> Function() getRefreshToken;

  final Future Function(String token) setAccessToken;
  final Future Function(String token) setRefreshToken;
  final VoidCallback onAuthError;

  RubbishCollectorsClient({
    required this.getAccessToken,
    required this.getRefreshToken,
    required this.setAccessToken,
    required this.setRefreshToken,
    required this.onAuthError,
  }) : dio = Dio(BaseOptions(baseUrl: Endpoints.baseUrl())) {
    final CustomInterceptors ci = CustomInterceptors(
      getAccessToken: getAccessToken,
      getRefreshToken: getRefreshToken,
      setAccessToken: setAccessToken,
      setRefreshToken: setRefreshToken,
      dioClient: dio,
      onAuthError: onAuthError,
      requestRetrier: DioConnectivityRequestRetrier(
        dio: Dio(),
        connectivity: Connectivity(),
      ),
    );
    // final retrier = RetryOnConnectionChangeInterceptor(
    // );
    dio.interceptors.add(ci);
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

  Future<GenericResult<UserWithToken>> authLogin({
    required String phone,
    required int loginCode,
  }) async {
    var loginRawResponse = await dio.post(
      Endpoints.authLoginPath(),
      data: {"phone": phone, "loginCode": loginCode},
    );
    final loginResult = GenericResult<UserWithToken>.fromJson(
      loginRawResponse.data,
      (dynamic json) => UserWithToken.fromJson(json),
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
    try {
      var refreshRawResponse = await dio.get(
        Endpoints.userGetInfoPath(),
      );
      final refreshResult = GenericResult<UserInfoResult>.fromJson(
        refreshRawResponse.data,
        (dynamic json) => UserInfoResult.fromJson(json),
      );
      return refreshResult;
    } catch (e) {
      throw ServerException();
    }
  }

  Future<GenericResult<UserInfoResult>> userSetInfo({
    String? name,
    String? email,
    File? avatar,
  }) async {
    var formData = FormData.fromMap({
      'AvatarUrl':
          avatar == null ? null : await MultipartFile.fromFile(avatar.path)
    });
    var userRawResponse = await dio.post(
      Endpoints.userSetInfoPath(),
      queryParameters: {
        'Name': name,
        'Email': email,
      },
      data: formData,
    );
    final userResult = GenericResult<UserInfoResult>.fromJson(
      userRawResponse.data,
      (dynamic json) => UserInfoResult.fromJson(json),
    );
    return userResult;
  }
}
