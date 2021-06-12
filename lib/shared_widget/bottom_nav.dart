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
      backgroundColor: lightYellow.withOpacity(0.8),
      snakeViewColor: yellowDarken,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.blueGrey,
      snakeShape: SnakeShape.rectangle,
      padding: EdgeInsets.all(16),
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
            icon: Icon(Icons.notifications), label: 'tickets'),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: 'calendar'),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.podcasts), label: 'microphone'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search')
      ],
    );
  }
}
