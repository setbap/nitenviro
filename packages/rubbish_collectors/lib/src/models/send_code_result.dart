class SendCodeResult {
  final int? code;
  final bool? isNewUser;

  const SendCodeResult({this.code, this.isNewUser});

  factory SendCodeResult.fromJson(Map<String, dynamic> json) => SendCodeResult(
        code: json['code'] as int?,
        isNewUser: json['isNewUser'] as bool?,
      );
}
