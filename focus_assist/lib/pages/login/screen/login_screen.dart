import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:focus_assist/classes/theme_provider.dart';
import 'package:focus_assist/pages/focusAssist.dart';
import 'package:focus_assist/pages/login/feature_ui/FadeAnimation.dart';
import 'package:focus_assist/pages/login/feature_ui/button_login.dart';
import 'package:focus_assist/pages/login/feature_ui/dontyouhaveaccount.dart';
import 'package:focus_assist/pages/login/feature_ui/edit_text_login.dart';
import 'package:focus_assist/pages/login/feature_ui/edit_text_password_login.dart';
import 'package:focus_assist/pages/login/feature_ui/forget_password.dart';
import 'package:focus_assist/pages/login/screen/sign_up_screen.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/pages/main_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../classes/DbProvider.dart';

class LoginScreen extends StatelessWidget {

  String _taiKhoan, _matKhau;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [
                Colors.purple[900],
                Colors.purple[800],
                Colors.purple[400],
              ], // Colors
            )
        ),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: size.height*0.2,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Container(
                      height: size.height*0.2,
                      width: size.width*0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FadeAnimation(1.2,Text('Login', style: TextStyle(color: Colors.white, fontSize: size.height*0.05,fontWeight: FontWeight.bold,),)),
                          SizedBox(height: size.height*0.01,),
                          FadeAnimation(1.2,  Text('Welcome back',style: TextStyle(color: Colors.white,fontSize: size.height*0.025),)),
                          SizedBox(height: size.height*0.01,),
                        ],
                      ),
                    ),
                    FadeAnimation(2,Container(
                      height: size.height*0.2,
                      width: size.width*0.3,
                      child: Image.asset('assets/achievenment/ui/ui_light.PNG'),
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height*0.01,),
            Container(
              height: size.height*0.9,
              decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: size.height*0.03,),
                      FadeAnimation(1.4,edit_text_login(
                        icon: Icons.person,
                        hintText: "Username",
                        onChanged: (value){
                            _taiKhoan = value;
                        },
                      )),
                      SizedBox(height: size.height*0.03,),
                      FadeAnimation(1.4,edit_text_password_login(
                        onChanged: (value){
                          _matKhau = value;
                        },
                      )),
                      SizedBox(height: size.height*0.07,),
                      // FadeAnimation(1.4, forgot_password(
                      //
                      // )),
                      FadeAnimation(1.6,button_login(
                        text: 'LOGIN',
                        press: () async {
                            _queryCheckUser(_taiKhoan, _matKhau, context);
                        },
                      )),
                       FadeAnimation(1.6, Donthaveanaccount(
                        login: true,
                        press: () {Navigator.push(context, MaterialPageRoute(builder: (context){return SignUpScreen();}));},
                      )),
                       SizedBox(height: size.height*0.04,),
                       FadeAnimation(2, Container(
                            height: size.height*0.2,
                            child: Image.asset(
                              'assets/achievenment/ui/ui_signup.PNG',
                        )),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }


  void _queryCheckUser(String tk, String mk,context) async
  {

    if (tk == null || mk == null)
    {
      //print('Điền đầy đủ thông tin');
      Fluttertoast.showToast(msg: 'Please enter all information needed', textColor: Colors.red[300], backgroundColor: Colors.grey[100] ,toastLength: Toast.LENGTH_LONG);
      //_show(context, 'Điền đầy đủ thông tin!');
      return;
    }

    //Check tài khoản
    final checkTK = await DbProvider.instance.rawQuery('''
  select * from NGUOIDUNG where TENTAIKHOAN = '$tk'
  ''');

    if (checkTK.length == 0)
    {
      //_show(context,"Tài khoản không tồn tại");
      Fluttertoast.showToast(msg: 'Incorrect username or password', textColor: Colors.red[300], backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
      return;
    }

    if (checkTK[0]['MATKHAU'] != mk)
    {
      //_show(context, "Sai mật khẩu");
      Fluttertoast.showToast(msg: 'Incorrect username or password', textColor: Colors.red[300], backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
      return;
    }

    StaticData.userID = checkTK[0]['MANGUOIDUNG'];
    //_showSuccess(context, "Đăng nhập thành công!");
    StaticData.isSignedIn = true;
    Database db = await DbProvider.instance.database;
    await db.execute(
        '''
      UPDATE THAMSO
      SET DADANGNHAP = 1,
          MANGUOIDUNG = '${StaticData.userID}';
      ''');
    List<Map<String, dynamic>> queryRows = await DbProvider.instance.rawQuery('''
                    select * from THONGTINNGUOIDUNG where MANGUOIDUNG = '${StaticData.userID}'
                    ''');
    StaticData.isDarkMode = (queryRows.first['DARKMODE'] == 1);
    StaticData.isPrivacyLockOn = queryRows.first['PRIVACYLOCK'] == 1;
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    provider.toggleTheme(StaticData.isDarkMode);
    InitUserNotification();
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
    Fluttertoast.showToast(msg: 'Sign in successfully', textColor: Colors.black54, backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_SHORT);
  }



//TODO Show thông báo
  void _show(context, String message){
    Alert(
      context: context,
      title: 'Thông báo',
      type: AlertType.warning,
      closeIcon: Icon(Icons.error),
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
          color: Colors.red,
        )
      ],
    ).show();
  }


  void _showSuccess(context, String message){
    Alert(
      context: context,
      type: AlertType.success,
      title: "Thông báo",
      closeIcon: Icon(Icons.error),
      desc: message,
      buttons: [
        DialogButton(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text(
                "ACCEPT",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
          onPressed: () async {
            StaticData.isSignedIn = true;
            Database db = await DbProvider.instance.database;
            await db.execute(
                '''
              UPDATE THAMSO
              SET DADANGNHAP = 1,
                  MANGUOIDUNG = '${StaticData.userID}';
              ''');
            InitUserNotification();
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          },
          width: 120,
          color: Colors.green[400],
        )
      ],
    ).show();
  }

  InitUserNotification() async {
    List<Map<String, dynamic>> queryList = await DbProvider.instance.rawQuery('''
                    SELECT * from THONGTINNGUOIDUNG where MANGUOIDUNG = '${StaticData.userID}'
                    ''');
    if (queryList.first['THONGBAOSANG'] == 1) {
      TimeOfDay morningNotificationTime = StringToTimeOfDay(queryList.first['THOIGIANTHONGBAOSANG']);
      showDailyMorningAtTimeNotification(Time(morningNotificationTime.hour, morningNotificationTime.minute));
    }
    if (queryList.first['THONGBAOTOI'] == 1) {
      TimeOfDay eveningNotificationTime = StringToTimeOfDay(queryList.first['THOIGIANTHONGBAOTOI']);
      showDailyEveningAtTimeNotification(Time(eveningNotificationTime.hour, eveningNotificationTime.minute));
    }
  }

  showDailyMorningAtTimeNotification(Time time) async {
    try {
      Database db = await DbProvider.instance.database;
      List<Map<String, dynamic>> queryRows = await db.rawQuery('SELECT * FROM TRICHDAN ORDER BY RANDOM() LIMIT 1');
      var androidChannel = AndroidNotificationDetails(
        'CHANNEL_ID 1',
        'CHANNEL_NAME 1',
        'CHANNEL_DESCRIPTION 1',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      );
      var iOSChannel = IOSNotificationDetails();
      var platformChannel = NotificationDetails(android: androidChannel, iOS: iOSChannel);
      await StaticData.flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        'Focus Assist',
        '${queryRows.first['TRICHDAN']} - ${queryRows.first['TACGIA']}',
        _nextInstanceOfTime(time.hour, time.minute),
        platformChannel,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: 'New payload',
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
    catch (e) {
      print('Morning notification error: ${e.toString()}');
    }

  }

  showDailyEveningAtTimeNotification(Time time) async {
    var androidChannel = AndroidNotificationDetails(
      'CHANNEL_ID 1',
      'CHANNEL_NAME 1',
      'CHANNEL_DESCRIPTION 1',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    var iOSChannel = IOSNotificationDetails();
    var platformChannel = NotificationDetails(android: androidChannel, iOS: iOSChannel);
    await StaticData.flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      'Focus Assist',
      'Remember to check in all your today activities',
      _nextInstanceOfTime(time.hour, time.minute),
      platformChannel,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: 'New payload',
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  TimeOfDay StringToTimeOfDay(String timeString) {
    List<String> splitString = timeString.split(':');
    TimeOfDay time = TimeOfDay(hour: int.parse(splitString[0]), minute: int.parse(splitString[1]));
    return time;
  }
}


