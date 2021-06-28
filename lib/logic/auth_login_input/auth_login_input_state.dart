part of 'auth_login_input_cubit.dart';

@immutable
abstract class AuthLoginInputState {
  const AuthLoginInputState();
}

class AuthLoginInputInitial extends AuthLoginInputState {}

class AuthLoginInputLoading extends AuthLoginInputState {}

class AuthLoginInputSuccess extends AuthLoginInputState {}

class AuthLoginInputError extends AuthLoginInputState {
  final String message;
  const AuthLoginInputError({required this.message});
}
