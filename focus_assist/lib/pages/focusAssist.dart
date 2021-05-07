import 'package:flutter/material.dart';
import 'package:focus_assist/pages/journal_screen.dart';
import 'package:focus_assist/pages/setting_screen.dart';

class FocusAssist extends StatefulWidget {
  @override
  _FocusAssistState createState() => _FocusAssistState();
}

class _FocusAssistState extends State<FocusAssist> {
  int selectedIndex = 0;
  final List<Widget> widgetOptions = <Widget>[
    Center(
      child: Text(
        'Focus Timer',
      ),
    ),
    Center(child: JournalScreen()),
    Center(
      child: Text(
        'Reward',
      ),
    ),
    Center(
      child: Text(
        'Progress',
      ),
    ),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: widgetOptions.elementAt(selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
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
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
