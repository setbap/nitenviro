import 'package:enviro_shared/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:enviro_driver/pages/pages.dart';

class Intro extends StatelessWidget {
  static const String path = "/intro";
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroPage(
      onNextPage: () => Navigator.pushNamed(
        context,
        LoginPhoneNumber.path,
      ),
    );
  }
}
