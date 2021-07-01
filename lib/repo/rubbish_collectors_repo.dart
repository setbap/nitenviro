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
}
