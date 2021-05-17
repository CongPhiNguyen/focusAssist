import 'package:flutter/material.dart';
import 'package:focus_assist/pages/progress_screen.dart';
import 'package:focus_assist/pages/setting_screen.dart';
import 'package:focus_assist/classes/LocalNotificationManager.dart';
import 'package:flutter_config/flutter_config.dart';

class FocusAssist extends StatefulWidget {
  @override
  _FocusAssistState createState() => _FocusAssistState();
}

class _FocusAssistState extends State<FocusAssist> {
  int selectedIndex = 3;
  final List<Widget> widgetOptions = <Widget> [
    Center(
      child: Text(
        'Focus Timer',
      ),
    ),
    Center(
      child: Text(
        'Journal',
      ),
    ),
    Center(
      child: Text(
        'Reward',
      ),
    ),
    /*Center(
      child: Text(
        'Progress',
      ),
    ),*/
    ProgressScreen(),
    SettingScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localNotificationManager.setOnNotificationReceive(onNotificationReceive);
    localNotificationManager.setOnNotificationClick(onNotificationClick);
  }

  onNotificationReceive(ReceiveNotification notification) {
    print('Notification Received: ${notification.id}');
  }

  onNotificationClick(String payload) {
    print('Payload: $payload');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
