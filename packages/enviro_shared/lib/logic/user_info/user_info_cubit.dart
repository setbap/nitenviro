import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';

import 'package:enviro_shared/repo/repo.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  final RubbishCollectorsApi _rubbishCollectorsApi;
  UserInfoCubit({
    required RubbishCollectorsApi rubbishCollectorsApi,
  })  : _rubbishCollectorsApi = rubbishCollectorsApi,
        super(
          UserInfoInitial(
            user: UserInfoResult(
              createdAt: "",
              id: "",
              phone: "",
              buildings: [],
            ),
          ),
        );

  Future<bool?> getUserInfo() async {
    emit(UserInfoLoading(user: state.user));
    try {
      log("getUserInfo");
      final userInfo = await _rubbishCollectorsApi.getUserInfo();
      if (userInfo.isSuccess) {
        log("getUserInfo:isSuccess");
        emit(UserInfoSuccess(user: userInfo.value!));
        return true;
      } else {
        log("getUserInfo:isSuccess:false");
        emit(UserInfoError(
            user: state.user, message: userInfo.errors[0].message));
      }
    } on ServerException catch (_) {
      rethrow;
    } catch (e) {
      log("getUserInfo:isSuccess:err");
      emit(UserInfoError(
        user: state.user,
        message: "مشکلی در ارتباط با اینترنت",
      ));
    }
  }

  Future<bool?> updateUserInfo({
    String? name,
    String? email,
    File? avatar,
  }) async {
    log("start");

    log("start2");
    emit(UserInfoLoading(user: state.user));
    try {
      final userInfo = await _rubbishCollectorsApi.updateUserInfo(
        avatar: avatar,
        email: email,
        name: name,
      );
      if (userInfo.isSuccess) {
        final UserInfoResult user = state.user;
        final newUser = userInfo.value;
        final updatedUser = user.copyWith(
          avatarUrl: newUser?.avatarUrl,
          name: newUser?.name,
          phone: newUser?.phone,
          email: newUser?.email,
        );
        emit(UserInfoSuccess(user: updatedUser));
        return true;
      } else {
        emit(UserInfoError(
          user: state.user,
          message: userInfo.errors[0].message,
        ));
        log("message");
      }
      log("test");
    } catch (e) {
      log(e.toString());
      emit(
        UserInfoError(
          user: state.user,
          message: "مشکلی در ارتباط با اینترنت",
        ),
      );
    }
  }

  void setUserInfo(UserInfoResult userInfo) {
    emit(UserInfoSuccess(user: userInfo));
  }

  Future<void> addUserBuilding({
    required BuildingCreateModel buildingCreateModel,
  }) async {
    emit(UserInfoLoading(user: state.user));
    try {
      log("add User Builing");
      final newBuilding = await _rubbishCollectorsApi.createNewBuildin(
        buildingCreateModel: buildingCreateModel,
      );
      if (newBuilding.isSuccess) {
        log("add User Builing:isSuccess");
        final building = newBuilding.value!;
        state.user.buildings.add(building);
        emit(UserInfoSuccess(user: state.user));
      } else {
        log("add User Builing:isSuccess:false");
        emit(UserInfoError(
          user: state.user,
          message: newBuilding.errors[0].message,
        ));
      }
    } on ServerException catch (_) {
      rethrow;
    } catch (e) {
      log("getUserInfo:isSuccess:err");
      emit(UserInfoError(
        user: state.user,
        message: "مشکلی در ارتباط با اینترنت",
      ));
    }
  }

  Future<void> updateUserBuilding({
    required BuildingCreateModel buildingCreateModel,
  }) async {
    emit(UserInfoLoading(user: state.user));
    try {
      log("update user Builing");
      final updatedBuilding = await _rubbishCollectorsApi.updateNewBuildin(
        buildingCreateModel: buildingCreateModel,
      );
      if (updatedBuilding.isSuccess) {
        log("update user Builing:isSuccess");
        final building = updatedBuilding.value!;
        final buildingIndex = state.user.buildings
            .indexWhere((element) => element.id == building.id);
        if (buildingIndex > -1) {
          state.user.buildings[buildingIndex] = building;
          emit(UserInfoSuccess(user: state.user));
          return;
        }
      } else {
        log("update user Builing:false");
        emit(UserInfoError(
          user: state.user,
          message: updatedBuilding.errors[0].message,
        ));
        return;
      }
    } on ServerException catch (_) {
      rethrow;
    } catch (e) {
      log("update user Builing:isSuccess:err");
      emit(UserInfoError(
        user: state.user,
        message: "مشکلی در ارتباط با اینترنت",
      ));
    }
  }

  Future<bool> deleteUserBuilding({
    required String buildingId,
  }) async {
    emit(UserInfoLoading(user: state.user));
    try {
      log("update user Builing");
      final deleteBuilding = await _rubbishCollectorsApi.deleteBuilding(
        buildingId: buildingId,
      );
      if (deleteBuilding.isSuccess) {
        log("update user Builing:isSuccess");

        final buildingIndex = state.user.buildings
            .indexWhere((element) => element.id == buildingId);
        if (buildingIndex > -1) {
          state.user.buildings.removeAt(buildingIndex);
          emit(UserInfoSuccess(user: state.user));

          return true;
        }
      } else {
        log("update user Builing:false");
        emit(UserInfoError(
          user: state.user,
          message: deleteBuilding.errors[0].message,
        ));
      }
      return false;
    } on ServerException catch (_) {
      rethrow;
    } catch (e) {
      log("update user Builing:isSuccess:err");
      emit(UserInfoError(
        user: state.user,
        message: "مشکلی در ارتباط با اینترنت",
      ));
      return false;
    }
  }
}
