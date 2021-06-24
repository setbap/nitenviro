import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:nitenviro/utils/colors.dart';

class NEBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final void Function(int index) onTap;

  const NEBottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.color(
      behaviour: SnakeBarBehaviour.floating,
      backgroundColor: lightYellow.withOpacity(0.9),
      snakeViewColor: yellowDarken,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.blueGrey,
      snakeShape: SnakeShape.rectangle,
      padding: const EdgeInsets.all(16),
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
          bottom: Radius.circular(16),
        ),
      ),
      showUnselectedLabels: false,
      showSelectedLabels: false,
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.chrome_reader_mode),
          label: 'آموزش',
          tooltip: 'آموزش',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search),
          label: 'شناسایی پسماند بازیافتی',
          tooltip: 'شناسایی پسماند بازیافتی',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.plus),
          label: 'اضافه کردن درخواست جدید',
          tooltip: 'اضافه کردن درخواست جدید',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.house),
          label: 'آموزش',
          tooltip: 'آموزش',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person_2_square_stack),
          label: 'پروفایل',
          tooltip: 'پروفایل',
        )
      ],
    );
  }
}
