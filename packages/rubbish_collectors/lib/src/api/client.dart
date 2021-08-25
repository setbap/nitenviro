import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';
import 'package:rubbish_collectors/src/api/interceptors/dio_connectivity_request_retrier.dart';
import 'package:rubbish_collectors/src/models/spacial_request.dart';

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
  }) : dio = Dio(
          BaseOptions(
            baseUrl: Endpoints.baseUrl(),
            headers: {"Access-Control-Allow-Origin": "*"},
          ),
        ) {
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
    try {
      var loginRawResponse = await dio.post(
        Endpoints.authLoginPath(),
        data: {"phone": phone, "loginCode": loginCode},
      );
      // log(loginRawResponse.data.toString());
      final loginResult = GenericResult<UserWithToken>.fromJson(
        loginRawResponse.data,
        (dynamic json) {
          return UserWithToken.fromJson(json);
        },
      );

      return loginResult;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
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

  Future<GenericResult<Building>> craeteBuilding({
    required BuildingCreateModel buildingCreateModel,
  }) async {
    try {
      var refreshRawResponse = await dio.post(
        Endpoints.buildingCreatePath(),
        data: buildingCreateModel.toMap(),
      );
      final createBuildingResult = GenericResult<Building>.fromJson(
        refreshRawResponse.data,
        (dynamic json) => Building.fromMap(json),
      );
      return createBuildingResult;
    } catch (e) {
      log(e.toString());
      throw ServerException();
    }
  }

  Future<GenericResult<Building>> updateBuilding({
    required BuildingCreateModel buildingCreateModel,
  }) async {
    try {
      var refreshRawResponse = await dio.patch(
        Endpoints.buildingCreatePath(),
        data: buildingCreateModel.toMap(),
      );
      final createBuildingResult = GenericResult<Building>.fromJson(
        refreshRawResponse.data,
        (dynamic json) => Building.fromMap(json),
      );
      return createBuildingResult;
    } catch (e) {
      log(e.toString());
      throw ServerException();
    }
  }

  Future<GenericResult<bool>> deleteBuilding({
    required String buildingId,
  }) async {
    try {
      var deleteBuildingResponse = await dio.delete(
        Endpoints.buildingCreatePath(),
        data: {"buildingId": buildingId},
      );
      final createBuildingResult = GenericResult<bool>.fromJson(
        deleteBuildingResponse.data,
        (dynamic json) => json == true,
      );
      return createBuildingResult;
    } catch (e) {
      log(e.toString());
      throw ServerException();
    }
  }

  Future<GenericResult<UserInfoResult>> userSetInfo({
    String? name,
    String? email,
    File? avatar,
  }) async {
    var formData = FormData.fromMap({
      'Avatar':
          avatar == null ? null : await MultipartFile.fromFile(avatar.path),
      'Name': name,
      'Email': email,
    });
    var userRawResponse = await dio.patch(
      Endpoints.userPatchInfoPath(),
      data: formData,
    );
    final userResult = GenericResult<UserInfoResult>.fromJson(
      userRawResponse.data,
      (dynamic json) => UserInfoResult.fromJson(json),
    );
    return userResult;
  }

  Future<GenericResult<List<ProvinceModel>>> getProvince() async {
    var provinceReponse = await dio.get(
      Endpoints.provincePath(),
    );

    final provinceResult = GenericResult<List<ProvinceModel>>.fromJson(
      provinceReponse.data,
      (dynamic json) {
        final list = <ProvinceModel>[];
        for (var i = 0; i < json.length; i++) {
          list.add(ProvinceModel.fromJson(json[i]));
        }
        return list;
      },
    );
    return provinceResult;
  }

  Future<GenericResult<List<CityModel>>> getCitiesOfProvince(
      {required String provinceId}) async {
    log(provinceId);
    var citiesOfProvinceReponse = await dio.get(
      Endpoints.citiesPath(),
      queryParameters: {"ProvinceId": provinceId},
    );

    final provinceResult = GenericResult<List<CityModel>>.fromJson(
      citiesOfProvinceReponse.data,
      (dynamic json) {
        final list = <CityModel>[];
        for (var i = 0; i < json.length; i++) {
          list.add(CityModel.fromJson(json[i]));
        }
        return list;
      },
    );
    return provinceResult;
  }

  Future<GenericResult<int>> createPickUpSpecial({
    required String buildingId,
    String? specialDescription,
    File? specialImageUrl,
    required int specialWeekDay,
  }) async {
    var formData = FormData.fromMap({
      'BuildingId': buildingId,
      'SpecialDescription': specialDescription,
      'SpecialImageUrl': specialImageUrl,
      'SpecialWeekDay': specialWeekDay,
    });
    var citiesOfProvinceReponse = await dio.post(
      Endpoints.pickUpCreateSpecial(),
      data: formData,
    );

    final provinceResult = GenericResult<int>.fromJson(
      citiesOfProvinceReponse.data,
      (_) => 1,
    );
    return provinceResult;
  }

  Future<GenericResult<List<Building>>> todayBuilding({
    required double? sourceLatitude,
    required double? sourceLongitude,
  }) async {
    try {
      var refreshRawResponse = await dio.get(
        Endpoints.todayBuildingsPath(),
        queryParameters: {
          "SourceLatitude": sourceLatitude,
          "SourceLongitude": sourceLongitude,
        },
      );
      final todayBuildingResults = GenericResult<List<Building>>.fromJson(
        refreshRawResponse.data,
        (dynamic json) => (json['data'] as List<dynamic>).map<Building>((b) {
          return Building.fromMap(b);
        }).toList(),
      );
      return todayBuildingResults;
    } catch (e) {
      log(e.toString());
      throw ServerException();
    }
  }

  Future<GenericResult<List<SpacialRequest>>> todaySpacialBuilding({
    required double? sourceLatitude,
    required double? sourceLongitude,
  }) async {
    try {
      var spacialRawResponse = await dio.get(
        Endpoints.todaySpacialBuildingsPath(),
        queryParameters: {
          "SourceLatitude": sourceLatitude,
          "SourceLongitude": sourceLongitude,
          "Status": 0,
        },
      );
      final todayBuildingResults = GenericResult<List<SpacialRequest>>.fromJson(
        spacialRawResponse.data,
        (dynamic json) =>
            (json['data'] as List<dynamic>).map<SpacialRequest>((b) {
          return SpacialRequest.fromMap(b);
        }).toList(),
      );
      return todayBuildingResults;
    } catch (e) {
      log(e.toString());
      throw ServerException();
    }
  }

  Future<GenericResult<SpacialRequest>> acceptBuilding({
    required String id,
    required bool isSpacial,
    required String? driverMessage,
  }) async {
    final endpoint = isSpacial
        ? Endpoints.acceptSpacialBuildingPath()
        : Endpoints.acceptBuildingPath();

    final idName = isSpacial ? "pickUpId" : "buildingId";
    try {
      var spacialAcceptRawResponse = await dio.post(
        endpoint,
        data: {
          idName: id,
          "driverMessage": driverMessage,
        },
      );
      final todayBuildingResults = GenericResult<SpacialRequest>.fromJson(
        spacialAcceptRawResponse.data,
        (dynamic json) => SpacialRequest.fromMap(json),
      );

      return todayBuildingResults;
    } catch (e) {
      log(e.toString());
      throw ServerException();
    }
  }

  Future<GenericResult<SpacialRequest>> recevieRequest({
    required String id,
    double? glassWeight,
    double? metalWeight,
    double? paperWeight,
    double? plasticWeight,
    double? mixedWeight,
    required String? driverDescription,
    required File? image,
  }) async {
    final formData = FormData.fromMap({
      "id": id,
      "GlassWeight": glassWeight,
      "MetalWeight": metalWeight,
      "PaperWeight": paperWeight,
      "PlasticWeight": plasticWeight,
      "MixedWeight": mixedWeight,
      "DriverDescription": driverDescription,
      "ImageUrl": image,
    });
    try {
      var recevieRawResponse = await dio.post(
        Endpoints.completeRequestPath(),
        data: formData,
      );
      final recevieResponse = GenericResult<SpacialRequest>.fromJson(
        recevieRawResponse.data,
        (dynamic json) => SpacialRequest.fromMap(json),
      );
      return recevieResponse;
    } catch (e) {
      log(e.toString());
      throw ServerException();
    }
  }
}
