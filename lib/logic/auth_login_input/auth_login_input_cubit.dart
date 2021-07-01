import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nitenviro/logic/logic.dart';
import 'package:nitenviro/repo/repo.dart';
import 'package:nitenviro/utils/utils.dart';

part 'auth_login_input_state.dart';

class AuthLoginInputCubit extends Cubit<AuthLoginInputState> {
  final UserInfoCubit _userInfoCubit;
  final SharedPreferences keyValueStorage;
  final RubbishCollectorsApi _rubbishCollectorsApi;
  AuthLoginInputCubit({
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

      if (loginInfo.isSuccess) {
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
