import 'package:enviro_shared/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:enviro_driver/pages/pages.dart';

class LoginPhoneNumber extends StatelessWidget {
  static const String path = "/auth";
  const LoginPhoneNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginPhoneNumberPage(
      onSuccess: (phoneNumber) => Navigator.pushNamed(
        context,
        LoginPhoneNumberValidate.path,
        arguments: phoneNumber,
      ),
    );
  }
}
