import 'package:enviro_shared/pages/index/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:enviro_driver/pages/pages.dart';
import 'package:tuple/tuple.dart';

const List<Tuple3<String, Widget, BottomNavigationBarItem>> pageList =
    <Tuple3<String, Widget, BottomNavigationBarItem>>[
  Tuple3<String, Widget, BottomNavigationBarItem>(
    "آموزش",
    Tutorials(),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.house),
      label: 'آموزش',
      tooltip: 'آموزش',
    ),
  ),
  Tuple3<String, Widget, BottomNavigationBarItem>(
      "شناسایی پسماند بازیافتی",
      RecycleFinder(),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        label: 'شناسایی پسماند بازیافتی',
        tooltip: 'شناسایی پسماند بازیافتی',
      )),
  Tuple3<String, Widget, BottomNavigationBarItem>(
      "درخواست ها",
      Requests(),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.arrow_up_bin),
        label: 'درخواست ها',
        tooltip: 'درخواست ها',
      )),
  Tuple3<String, Widget, BottomNavigationBarItem>(
      "تاریخچه",
      History(),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.calendar),
        label: 'تاریخچه',
        tooltip: 'تاریخچه',
      )),
  Tuple3<String, Widget, BottomNavigationBarItem>(
    "پروفایل",
    Profile(),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.person_2_square_stack),
      label: 'پروفایل',
      tooltip: 'پروفایل',
    ),
  ),
];

class Index extends StatelessWidget {
  static const String path = "/index";
  const Index({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IndexPage(
      pages: pageList,
      goSettingPage: () => Navigator.pushNamed(context, Settings.path),
    );
  }
}
