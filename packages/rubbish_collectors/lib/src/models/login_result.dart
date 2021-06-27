class AuthTokenResult {
  final String accesstoken;
  final String refreshToken;
  final String refreshTokenExpirationDate;

  const AuthTokenResult({
    required this.accesstoken,
    required this.refreshToken,
    required this.refreshTokenExpirationDate,
  });

  factory AuthTokenResult.fromJson(Map<String, dynamic> json) =>
      AuthTokenResult(
        accesstoken: json['accesstoken'] as String,
        refreshToken: json['refreshToken'] as String,
        refreshTokenExpirationDate:
            json['refreshTokenExpirationDate'] as String,
      );
}
