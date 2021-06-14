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
          icon: Icon(Icons.notifications),
          label: 'tickets',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.arrow_3_trianglepath),
          label: 'شناسایی پسماند بازیافتی',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          label: 'اضافه کردن درخواست جدید',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.language),
          label: 'آموزش',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.profile_circled),
          label: 'پروفایل',
        )
      ],
    );
  }
}
