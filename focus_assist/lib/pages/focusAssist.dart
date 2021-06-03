import 'package:flutter/material.dart';
import 'package:focus_assist/pages/achievenment/screen/achievenment_screen.dart';
import 'package:focus_assist/pages/farm/screen/farm_screen.dart';
import 'package:focus_assist/pages/progress_screen.dart';
import 'package:focus_assist/pages/setting_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


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

  Widget _pageChooser(int page){
    switch(page){
      case 0:
        return Center(
          child: Text('Foscus Time'),
        );
        break;
      case 1:
        return Center(
          child: Text('Journal'),
        );
        break;
      case 2:
        return AchievenmentScreen();
        break;
      case 3:
        return  FarmScreen();
        break;
      case 4:
        return ProgressScreen();
        break;
      case 5:
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
          Icon(Icons.style,size:30),
          Icon(Icons.waterfall_chart, size: 30),
          Icon(Icons.settings, size: 30),
        ],
        color: Colors.amber[200],
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (int tappedIndex) {
          setState(() {
            _showPage  = _pageChooser(tappedIndex);
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


void _show(context, String message){
  Alert(
    context: context,
    type: AlertType.success,
    title: 'Thông báo',
    closeIcon: Icon(Icons.error),
    desc: message,
    buttons: [
      DialogButton(
        child: Text(
          "ACCEPT",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

