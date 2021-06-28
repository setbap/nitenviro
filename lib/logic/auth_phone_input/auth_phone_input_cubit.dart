import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_phone_input_state.dart';

class AuthPhoneInputCubit extends Cubit<AuthPhoneInputState> {
  AuthPhoneInputCubit() : super(AuthPhoneInputInitial());
}
