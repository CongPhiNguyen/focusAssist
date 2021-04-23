import 'package:flutter/material.dart';

class MyBottonNavigationBar extends StatelessWidget {
  final int selectedIndex;
  MyBottonNavigationBar({ this.selectedIndex });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey[600],
      iconSize: 28.0,
      backgroundColor: Colors.grey[300],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.timer,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wysiwyg_rounded),
          label: 'Journal',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Farm',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.waterfall_chart),
          label: 'Progress',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }

  void onItemTapped(int index) {
    return;
  }
}
