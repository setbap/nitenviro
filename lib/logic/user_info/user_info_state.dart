part of 'user_info_cubit.dart';

@immutable
abstract class UserInfoState {
  final UserInfoResult user;
  const UserInfoState({required this.user});
}

class UserInfoInitial extends UserInfoState {
  const UserInfoInitial({required UserInfoResult user}) : super(user: user);
}

class UserInfoLoading extends UserInfoState {
  const UserInfoLoading({required UserInfoResult user}) : super(user: user);
}

class UserInfoSuccess extends UserInfoState {
  const UserInfoSuccess({required UserInfoResult user}) : super(user: user);
}

class UserInfoError extends UserInfoState {
  final String? message;
  const UserInfoError({this.message, required UserInfoResult user})
      : super(user: user);
}
