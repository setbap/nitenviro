import 'dart:io';

import 'package:rubbish_collectors/rubbish_collectors.dart';

class RubbishCollectorsApi {
  final RubbishCollectorsClient _rubbishCollectorsClient;

  const RubbishCollectorsApi(
      {required RubbishCollectorsClient rubbishCollectorsClient})
      : _rubbishCollectorsClient = rubbishCollectorsClient;

  Future<GenericResult<SendCodeResult>> authSendCode(
      {required String phoneNumber}) async {
    final items =
        await _rubbishCollectorsClient.authSendCode(phone: phoneNumber);
    return items;
  }

  Future<GenericResult<UserWithToken>> authLogin({
    required String phoneNumber,
    required int loginCode,
  }) async {
    final items = await _rubbishCollectorsClient.authLogin(
      phone: phoneNumber,
      loginCode: loginCode,
    );
    return items;
  }

  Future<GenericResult<UserInfoResult>> getUserInfo() async {
    final items = await _rubbishCollectorsClient.userGetInfo();
    return items;
  }

  Future<GenericResult<Building>> createNewBuildin({
    required BuildingCreateModel buildingCreateModel,
  }) async {
    final items = await _rubbishCollectorsClient.craeteBuilding(
      buildingCreateModel: buildingCreateModel,
    );
    return items;
  }

  Future<GenericResult<Building>> updateNewBuildin({
    required BuildingCreateModel buildingCreateModel,
  }) async {
    final items = await _rubbishCollectorsClient.updateBuilding(
      buildingCreateModel: buildingCreateModel,
    );
    return items;
  }

  Future<GenericResult<List<Building>>> getTodayBuilding({
    required double? sourceLatitude,
    required double? sourceLongitude,
  }) async {
    final items = await _rubbishCollectorsClient.todayBuilding(
      sourceLatitude: sourceLatitude,
      sourceLongitude: sourceLongitude,
    );
    return items;
  }

  Future<GenericResult<List<SpacialRequest>>> getTodaySpacialBuilding({
    required double? sourceLatitude,
    required double? sourceLongitude,
  }) async {
    final items = await _rubbishCollectorsClient.todaySpacialBuilding(
      sourceLatitude: sourceLatitude,
      sourceLongitude: sourceLongitude,
    );
    return items;
  }

  Future<GenericResult<List<SpacialRequest>>> getTodayOngoingRequests({
    required double? sourceLatitude,
    required double? sourceLongitude,
  }) async {
    final items = await _rubbishCollectorsClient.todaySpacialBuilding(
      sourceLatitude: sourceLatitude,
      sourceLongitude: sourceLongitude,
      isAccepted: true,
    );
    return items;
  }

  Future<GenericResult<List<SpacialRequest>>> getHistoryWithDay({
    required int days,
    required bool isDriver,
  }) async {
    final items = await _rubbishCollectorsClient.getHistory(
      days: days,
      isDriver: isDriver,
    );
    return items;
  }

  Future<GenericResult<SpacialRequest>> acceptTodayBuilding({
    required String id,
    required bool isSpacial,
    String? driverMessage,
  }) async {
    final items = await _rubbishCollectorsClient.acceptBuilding(
      id: id,
      isSpacial: isSpacial,
      driverMessage: "",
    );
    return items;
  }

  Future<GenericResult<SpacialRequest>> receiveRequest({
    required String id,
    double? glassWeight,
    double? metalWeight,
    double? paperWeight,
    double? plasticWeight,
    double? mixedWeight,
    required String? driverDescription,
    required File? image,
  }) async {
    final items = await _rubbishCollectorsClient.recevieRequest(
      id: id,
      glassWeight: glassWeight,
      metalWeight: metalWeight,
      paperWeight: paperWeight,
      plasticWeight: plasticWeight,
      mixedWeight: mixedWeight,
      driverDescription: driverDescription,
      image: image,
    );
    return items;
  }

  Future<GenericResult<bool>> deleteBuilding({
    required String buildingId,
  }) async {
    final items = await _rubbishCollectorsClient.deleteBuilding(
      buildingId: buildingId,
    );
    return items;
  }

  Future<GenericResult<UserInfoResult>> updateUserInfo({
    String? name,
    String? email,
    File? avatar,
  }) async {
    final items = await _rubbishCollectorsClient.userSetInfo(
      avatar: avatar,
      email: email,
      name: name,
    );
    return items;
  }

  Future<GenericResult<int>> createPickUpSpecial({
    required String buildingId,
    String? specialDescription,
    File? specialImageUrl,
    required int specialWeekDay,
  }) async {
    final items = await _rubbishCollectorsClient.createPickUpSpecial(
      buildingId: buildingId,
      specialWeekDay: specialWeekDay,
      specialDescription: specialDescription,
      specialImageUrl: specialImageUrl,
    );
    return items;
  }

  Future<GenericResult<List<ProvinceModel>>> getAllProvince() async {
    final items = await _rubbishCollectorsClient.getProvince();
    return items;
  }

  Future<GenericResult<List<CityModel>>> getCitiesOfProvince(
      {required String provinceId}) async {
    final items = await _rubbishCollectorsClient.getCitiesOfProvince(
        provinceId: provinceId);
    return items;
  }
}
