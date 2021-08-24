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
