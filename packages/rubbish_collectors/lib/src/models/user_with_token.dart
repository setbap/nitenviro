import 'package:rubbish_collectors/rubbish_collectors.dart';

class UserWithToken {
  final AuthTokenResult tokens;
  final UserInfoResult user;

  const UserWithToken({
    required this.tokens,
    required this.user,
  });

  factory UserWithToken.fromJson(Map<String, dynamic> map) {
    return UserWithToken(
      tokens: AuthTokenResult.fromJson(map['tokens']),
      user: UserInfoResult.fromJson(map['user']),
    );
  }
}
