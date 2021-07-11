import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:enviro_shared/repo/rubbish_collectors_repo.dart';

part 'auth_phone_input_state.dart';

class AuthPhoneInputCubit extends Cubit<AuthPhoneInputState> {
  final RubbishCollectorsApi _rubbishCollectorsApi;
  AuthPhoneInputCubit({required RubbishCollectorsApi rubbishCollectorsApi})
      : _rubbishCollectorsApi = rubbishCollectorsApi,
        super(AuthPhoneInputInitial());

  Future sendCode(String phoneNumber) async {
    emit(AuthPhoneInputLoading());

    try {
      final authCode =
          await _rubbishCollectorsApi.authSendCode(phoneNumber: phoneNumber);
      if (authCode.isSuccess) {
        emit(AuthPhoneInputSuccess());
      } else {
        final message = authCode.errors[0].message ?? "ارور در شماره ارسالی";
        emit(AuthPhoneInputError(message: message));
      }
    } catch (e) {
      emit(
        const AuthPhoneInputError(
            message: "مشکلی در ارتباط با سرور به وجود امده است"),
      );
    }
  }
}
