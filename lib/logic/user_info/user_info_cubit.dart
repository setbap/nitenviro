import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';

import 'package:nitenviro/repo/repo.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  final RubbishCollectorsApi _rubbishCollectorsApi;
  UserInfoCubit({
    required RubbishCollectorsApi rubbishCollectorsApi,
  })  : _rubbishCollectorsApi = rubbishCollectorsApi,
        super(UserInfoInitial(
            user: UserInfoResult(
          createdAt: "",
          id: -1,
          phone: "",
        )));

  Future<bool?> getUserInfo() async {
    emit(UserInfoLoading(user: state.user));
    try {
      final userInfo = await _rubbishCollectorsApi.getUserInfo();
      if (userInfo.isSuccess) {
        emit(UserInfoSuccess(user: userInfo.value!));
        return true;
      } else {
        emit(UserInfoError(
            user: state.user, message: userInfo.errors[0].message));
      }
    } catch (e) {
      emit(UserInfoError(
          user: state.user, message: "مشکلی در ارتباط با اینترنت"));
    }
  }

  Future<bool?> updateUserInfo({
    String? name,
    String? email,
    File? avatar,
  }) async {
    if (state is UserInfoSuccess) {
      print("update user");
      emit(UserInfoLoading(user: (state as UserInfoSuccess).user));
      try {
        final userInfo = await _rubbishCollectorsApi.updateUserInfo(
          avatar: avatar,
          email: email,
          name: name,
        );
        if (userInfo.isSuccess) {
          emit(UserInfoSuccess(user: userInfo.value!));
          return true;
        } else {
          emit(UserInfoError(
            user: state.user,
            message: userInfo.errors[0].message,
          ));
        }
      } catch (e) {
        emit(UserInfoError(
            user: state.user, message: "مشکلی در ارتباط با اینترنت"));
      }
    }
  }

  void setUserInfo(UserInfoResult userInfo) {
    emit(UserInfoSuccess(user: userInfo));
  }
}
