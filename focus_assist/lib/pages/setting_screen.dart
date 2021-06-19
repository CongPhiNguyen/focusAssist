import 'package:flutter/material.dart';
import 'package:focus_assist/pages/account_setting_screen.dart';
import 'package:focus_assist/pages/farm/screen/about_us_screen.dart';
import 'package:focus_assist/pages/notification_setting_screen.dart';
import 'package:focus_assist/pages/privacy_lock_setting_screen.dart';


class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 20.0, 00.0, 0),
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                child: Text(
                  'ACCOUNT',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              SizedBox(height: 5.0,),
              ListTile (
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountSettingScreen()),
                  );
                },
                title: Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                leading: Icon(
                  Icons.account_circle_outlined,
                  size: 36.0,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.navigate_next),
              ),
              Divider(height: 10.0, thickness: 2.0, indent: 65.0,),
              SizedBox(height: 15.0,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                child: Text(
                  'APP BEHAVIOR',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              SizedBox(height: 5.0,),
              ListTile (
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationSettingScreen()),
                  );
                },
                title: Text(
                  'Notifications',
                ),
                leading: Icon(
                  Icons.notifications,
                  size: 36.0,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.navigate_next),
              ),
              Divider(height: 10.0, thickness: 2.0, indent: 65.0,),
              ListTile (
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PrivacyLockSettingScreen()),
                  );
                },
                title: Text(
                  'Privacy Lock',
                ),
                leading: Icon(
                  Icons.lock_outline_rounded,
                  size: 36.0,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.navigate_next),
              ),
              Divider(height: 10.0, thickness: 2.0, indent: 65.0,),
              ListTile (
                onTap: () {
                  setState(() {
                    isDarkMode = !isDarkMode;
                  });
                },
                title: Text(
                  'Dark Mode',
                ),
                leading: Icon(
                  Icons.nights_stay_rounded,
                  size: 36.0,
                  color: Colors.blue,
                ),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  }
                ),
              ),
              Divider(height: 10.0, thickness: 2.0, indent: 65.0,),
              SizedBox(height: 15.0,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                child: Text(
                  'SUPPORT',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              SizedBox(height: 5.0,),
              ListTile (
                onTap: () {},
                title: Text(
                  'Chat with Our Support Team',
                ),
                leading: Icon(
                  Icons.chat_rounded,
                  size: 36.0,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.navigate_next),
              ),
              Divider(height: 10.0, thickness: 2.0, indent: 65.0,),
              SizedBox(height: 15.0,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                child: Text(
                  'ABOUT',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              SizedBox(height: 5.0,),
              ListTile (
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context){
                        return AboutUsScreen();
                      },
                    ),
                  );
                },
                title: Text(
                  'About',
                ),
                leading: Icon(
                  Icons.info_rounded,
                  size: 36.0,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.navigate_next),
              ),
              //Divider(height: 10.0, thickness: 2.0, indent: 65.0,),
            ],
          ),
        ),
      ),
    );
  }
}
