import 'package:flutter/material.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:focus_assist/classes/theme_provider.dart';
import 'package:focus_assist/pages/settings/account_setting_screen.dart';
import 'package:focus_assist/pages/settings/chat_login_screen.dart';
import 'package:focus_assist/pages/settings/notification_setting_screen.dart';
import 'package:focus_assist/pages/settings/privacy_lock_setting_screen.dart';
import 'package:focus_assist/pages/settings/change_theme_switch_widget.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:focus_assist/pages/settings//about_us_screen.dart';


class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDarkMode = StaticData.isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                  color: Theme.of(context).iconTheme.color,
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
                  color: Theme.of(context).iconTheme.color,
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
                  color: Theme.of(context).iconTheme.color,
                ),
                trailing: Icon(Icons.navigate_next),
              ),
              Divider(height: 10.0, thickness: 2.0, indent: 65.0,),
              ListTile (
                onTap: () async {
                  final provider = Provider.of<ThemeProvider>(context, listen: false);
                  provider.toggleTheme(!isDarkMode);
                  setState(() {
                    isDarkMode = !isDarkMode;
                  });
                  StaticData.isDarkMode = isDarkMode;
                  Database db = await DbProvider.instance.database;
                  await db.execute('''
                      UPDATE THONGTINNGUOIDUNG
                      SET DARKMODE = ${(StaticData.isDarkMode)?1:0}
                      WHERE MANGUOIDUNG = '${StaticData.userID}'
                      ''');
                },
                title: Text(
                  'Dark Mode',
                ),
                leading: Icon(
                  Icons.nights_stay_rounded,
                  size: 36.0,
                  color: Theme.of(context).iconTheme.color,
                ),
                trailing: ChangeThemeSwitchWidget(),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatLoginScreen()),
                  );
                },
                title: Text(
                  'Chat with Our Support Team',
                ),
                leading: Icon(
                  Icons.chat_rounded,
                  size: 36.0,
                  color: Theme.of(context).iconTheme.color,
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
                  color: Theme.of(context).iconTheme.color,
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
