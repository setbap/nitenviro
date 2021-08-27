import 'package:enviro_shared/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:nitenviro/repo/repo.dart';

class History extends StatelessWidget {
  static const String path = "/history";
  const History({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: yellowDarken,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "تاریخچه",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: const HistoryPage());
  }
}
