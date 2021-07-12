import 'package:enviro_shared/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:enviro_driver/pages/index/index.dart';

class LoginPhoneNumberValidate extends StatelessWidget {
  final String phoneNumber;
  static const String path = "/login";
  const LoginPhoneNumberValidate({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginPhoneNumberValidatePage(
      onSuccess: () => Navigator.pushNamedAndRemoveUntil(
        context,
        Index.path,
        (route) => false,
      ),
      phoneNumber: phoneNumber,
    );
  }
}
