part of 'auth_phone_input_cubit.dart';

@immutable
abstract class AuthPhoneInputState {
  const AuthPhoneInputState();
}

class AuthPhoneInputInitial extends AuthPhoneInputState {}

class AuthPhoneInputLoading extends AuthPhoneInputState {}

class AuthPhoneInputSuccess extends AuthPhoneInputState {}

class AuthPhoneInputError extends AuthPhoneInputState {
  final String message;
  const AuthPhoneInputError({required this.message});
}
