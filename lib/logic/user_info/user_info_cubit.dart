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
        super(UserInfoInitial());

  Future<bool?> getUserInfo() async {
    emit(UserInfoLoading());
    try {
      final userInfo = await _rubbishCollectorsApi.getUserInfo();
      if (userInfo.isSuccess) {
        emit(UserInfoSuccess(user: userInfo.value!));
        return true;
      } else {
        emit(UserInfoError(message: userInfo.errors[0].message));
      }
    } catch (e) {
      emit(const UserInfoError(message: "مشکلی در ارتباط با اینترنت"));
    }
  }
}
