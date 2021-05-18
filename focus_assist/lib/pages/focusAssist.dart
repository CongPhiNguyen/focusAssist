import 'package:flutter/material.dart';
import 'package:focus_assist/pages/achievenment/screen/achievenment_screen.dart';
import 'package:focus_assist/pages/progress_screen.dart';
import 'package:focus_assist/pages/journal_screen.dart';
import 'package:focus_assist/pages/setting_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:focus_assist/classes/LocalNotificationManager.dart';
import 'package:flutter_config/flutter_config.dart';

/*
class FocusAssist extends StatefulWidget {
  @override
  _FocusAssistState createState() => _FocusAssistState();
}

class _FocusAssistState extends State<FocusAssist> {
<<<<<<< HEAD
  int selectedIndex = 3;
  final List<Widget> widgetOptions = <Widget> [
=======
  int selectedIndex = 0;
  final List<Widget> widgetOptions = <Widget>[
>>>>>>> statistic-phi
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

    AchievenmentScreen(),
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
*/

class focus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome',
      home: FocusAssist(),
    );
  }
}

class FocusAssist extends StatefulWidget {
  @override
  _FocusAssistState createState() => _FocusAssistState();
}

class _FocusAssistState extends State<FocusAssist> {
  int _page = 0;
  // GlobalKey _bottomNavigationKey = GlobalKey();

  Widget _showPage = new SettingScreen();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return Center(
          child: Text('Foscus Time'),
        );
        break;
      case 1:
        return JournalScreen();
        break;
      case 2:
        return AchievenmentScreen();
        break;
      case 3:
        return ProgressScreen();
        break;
      case 4:
        return SettingScreen();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        // key: _bottomNavigationKey,
        index: _page,
        items: <Widget>[
          Icon(Icons.timer, size: 30),
          Icon(Icons.wysiwyg_rounded, size: 30),
          Icon(Icons.star, size: 30),
          Icon(Icons.waterfall_chart, size: 30),
          Icon(Icons.settings, size: 30),
        ],
        color: Colors.amber[200],
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (int tappedIndex) {
          setState(() {
            _showPage = _pageChooser(tappedIndex);
          });
        },
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: _showPage,
        ),
      ),
    );
  }
}
