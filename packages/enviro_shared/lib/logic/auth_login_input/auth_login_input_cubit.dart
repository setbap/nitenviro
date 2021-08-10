import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:enviro_shared/logic/logic.dart';
import 'package:enviro_shared/repo/repo.dart';
import 'package:enviro_shared/utils/utils.dart';

part 'auth_login_input_state.dart';

class AuthLoginInputCubit extends Cubit<AuthLoginInputState> {
  final UserInfoCubit _userInfoCubit;
  final SharedPreferences keyValueStorage;
  final RubbishCollectorsApi _rubbishCollectorsApi;
  final int userType;
  AuthLoginInputCubit({
    this.userType = 0,
    required RubbishCollectorsApi rubbishCollectorsApi,
    required UserInfoCubit userInfoCubit,
    required this.keyValueStorage,
  })  : _rubbishCollectorsApi = rubbishCollectorsApi,
        _userInfoCubit = userInfoCubit,
        super(AuthLoginInputInitial());

  Future login(String phoneNumber, int loginCode) async {
    emit(AuthLoginInputLoading());

    try {
      final loginInfo = await _rubbishCollectorsApi.authLogin(
        phoneNumber: phoneNumber,
        loginCode: loginCode,
      );

      if (loginInfo.isSuccess &&
          ((loginInfo.value?.user.type ?? 0) >= userType)) {
        final authCode = loginInfo.value!.tokens;
        keyValueStorage.setString(kAccessTokenKey, authCode.accesstoken);
        keyValueStorage.setString(
          kRefreshTokenKey,
          authCode.refreshToken,
        );
        keyValueStorage.setBool(
          kIsLoggedIn,
          true,
        );
        _userInfoCubit.setUserInfo(loginInfo.value!.user);
        emit(AuthLoginInputSuccess());
      }
      if (loginInfo.isSuccess) {
        emit(
          const AuthLoginInputError(
            message: "شما اجازه دسترسی به برنامه ندارید",
          ),
        );
      } else {
        final message = loginInfo.errors[0].message ?? "ارور در ورود";
        emit(AuthLoginInputError(message: message));
      }
    } catch (e) {
      emit(
        const AuthLoginInputError(
          message: "مشکلی در ارتباط با سرور به وجود امده است",
        ),
      );
    }
  }
}
