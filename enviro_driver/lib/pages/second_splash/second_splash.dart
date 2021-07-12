import 'package:enviro_shared/pages/pages.dart' show MyHomePageSplash;
import 'package:flutter/material.dart';
import 'package:enviro_driver/pages/pages.dart';

class MyHomePage extends StatelessWidget {
  static const String path = "/";
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyHomePageSplash(
      authPage: () => const Index(),
      notAuthPage: () => const Intro(),
    );
  }
}
