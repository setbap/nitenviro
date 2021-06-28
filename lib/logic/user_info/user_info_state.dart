part of 'user_info_cubit.dart';

@immutable
abstract class UserInfoState {
  const UserInfoState();
}

class UserInfoInitial extends UserInfoState {}

class UserInfoLoading extends UserInfoState {}

class UserInfoSuccess extends UserInfoState {
  final UserInfoResult user;

  const UserInfoSuccess({required this.user});
}

class UserInfoError extends UserInfoState {
  final String? message;
  const UserInfoError({this.message});
}
