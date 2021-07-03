import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:focus_assist/pages/focusAssist.dart';
import 'package:focus_assist/pages/login/feature_ui/FadeAnimation.dart';
import 'package:focus_assist/pages/login/feature_ui/button_login.dart';
import 'package:focus_assist/pages/login/feature_ui/dontyouhaveaccount.dart';
import 'package:focus_assist/pages/login/feature_ui/edit_text_login.dart';
import 'package:focus_assist/pages/login/feature_ui/edit_text_password_login.dart';
import 'package:focus_assist/pages/login/feature_ui/login_with_socialnetwork.dart';
import 'package:focus_assist/pages/login/feature_ui/or_ui.dart';
import 'package:sqflite/sqflite.dart';
import 'login_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:focus_assist/pages/main_screen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class SignUpScreen extends StatelessWidget {
  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String _taiKhoan, _matKhau, _maUser, _ten;
  final validCharacters = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');


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
                Colors.amber[800],
                Colors.amber[600],
                Colors.amber[400],
                Colors.amber[200],
              ], // Colors
            )
        ),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: size.height*0.2,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Container(
                      width: size.width*0.6,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FadeAnimation(1.2,  Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 40.0,fontWeight: FontWeight.bold,),)),
                            SizedBox(height: size.height*0.01,),
                            FadeAnimation(1.2,  Text('Welcome to Focus Assist',style: TextStyle(color: Colors.white,fontSize: size.height*0.02),)),
                            SizedBox(height: size.height*0.01,),
                          ],
                        ),
                    ),
                    FadeAnimation(2,Container(
                      width: size.width*0.3,
                      height: size.height*0.15,
                      child: Image.asset('assets/achievenment/ui/ui_light.PNG'),
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height*0.01,),
            Container(
              height: size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child:  Column(
                    children: <Widget>[
                      FadeAnimation(1.2,edit_text_login(
                        icon: Icons.drive_file_rename_outline,
                        hintText: "Your name",
                        onChanged: (value){
                          _ten = value;
                        },
                      )),
                      SizedBox(height: size.height*0.0015,),
                      FadeAnimation(1.2,edit_text_login(
                        icon: Icons.person,
                        hintText: "Username",
                        onChanged: (value){
                          _taiKhoan = value;
                        },
                      )),
                      SizedBox(height: size.height*0.0015,),
                      FadeAnimation(1.4,edit_text_password_login(
                        onChanged: (value){
                          _matKhau = value;
                        },
                      )),
                      SizedBox(height: size.height*0.03,),
                      FadeAnimation(1.4, button_login(
                        color: Colors.amber[600],
                        text: 'SIGN UP',
                        press: () async {

                           if (_matKhau == null || _taiKhoan== null || _ten == null)
                            {
                              //_show(context, "Điền đầy đủ thông tin!");
                              Fluttertoast.showToast(msg: 'Please enter all information needed', textColor: Colors.red[300], backgroundColor: Colors.grey[100], gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG,timeInSecForIosWeb: 1 );
                            }
                           else if (validCharacters.hasMatch(_taiKhoan) ==false || validCharacters.hasMatch(_matKhau)== false){
                             Fluttertoast.showToast(msg: "Invalid username or password", textColor: Colors.red[300], backgroundColor: Colors.grey[100], gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG);
                           }
                          else
                            {
                              _maUser = getRandomString(10);
                              _queryCheckUser(_taiKhoan, _matKhau, _maUser, _ten ,context);
                            }
                        },
                      )),
                      SizedBox(height: size.height*0.02,),
                      FadeAnimation(1.4, Donthaveanaccount(
                        login: false,
                        press: (){Navigator.push(context, MaterialPageRoute(builder: (context){return LoginScreen();}));},
                      )),
                      SizedBox(height: size.height*0.02,),
                      //FadeAnimation(1.6,Or()),
                      //  SizedBox(height: size.height*0.03,),
                      // FadeAnimation(1.6,  Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //     login_with_socialnetwork(
                      //       iconImage: "assets/login/icon/facebook.png",
                      //       press: (){},
                      //     ),
                      //     login_with_socialnetwork(
                      //       iconImage: "assets/login/icon/google.png",
                      //       press: (){},
                      //     ),
                      //     login_with_socialnetwork(
                      //       iconImage: "assets/login/icon/twitter.png",
                      //       press: (){},
                      //     ),
                      //   ],
                      // )),
                      FadeAnimation(2.5,Container(
                        height: size.height*0.15,
                        width: size.width*0.6,
                        child: Image.asset('assets/achievenment/ui/ui_signin.PNG'),
                      )),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }


  //ramdom ma nguoi dung
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


  //Dung SHA-512224 băm mk
  String maHoaPassWord(String PassWord){

    var bytes = utf8.encode(PassWord);
    var has = sha512224.convert(bytes);

    String matKhauMaHoa = has.toString();

    return matKhauMaHoa;
  }

// Check tài khoản có tồn tại hay không
  void _queryCheckUser(String tk,String mk, String maUser, String name ,context) async {
    final checkTK = await DbProvider.instance.rawQuery('''
  select * from NGUOIDUNG where TENTAIKHOAN = '$tk'
  ''');

    if (checkTK.length >= 1) {
      //_show(context, 'Tài khoản đã tồn tại');
      Fluttertoast.showToast(msg: 'Username already exists', textColor: Colors.red[300], backgroundColor: Colors.grey[100],gravity: ToastGravity.CENTER, toastLength: Toast.LENGTH_LONG);
      return;
    } else {
      Map<String, dynamic> row = {'MANGUOIDUNG': maUser, 'TENTAIKHOAN': tk,'MATKHAU': maHoaPassWord(mk)};
      int i = await DbProvider.instance.insert('NGUOIDUNG', row);

      row = {'MANGUOIDUNG': maUser ,
        'HOTEN': name,
        'ANH':  '',
        'VANG': 1000,
        'THONGBAO': 1,
        'THONGBAOSANG': 1,
        'THONGBAOTOI' : 1,
        'THOIGIANTHONGBAOSANG': '07:00:00',
        'THOIGIANTHONGBAOTOI': '22:00:00',
        'DARKMODE': 0,
        'PRIVACYLOCK': 0,
        'LOCKPASSCODE': ''};
      await DbProvider.instance.insert('THONGTINNGUOIDUNG', row);

      print('value of insert: $i');
      StaticData.userID = maUser;
      //_showSuccess(context, "Đăng ký thành công!");
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
      Fluttertoast.showToast(msg: 'Sign in successfully', textColor: Colors.black54, backgroundColor: Colors.grey[100],gravity: ToastGravity.CENTER, toastLength: Toast.LENGTH_SHORT);
    }
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
        styleInformation: BigTextStyleInformation(''),
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
      styleInformation: BigTextStyleInformation(''),
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



// // Báo lỗi
// void _show(context, String message){
//   Alert(
//     context: context,
//     title: 'Thông báo',
//     type: AlertType.warning,
//     closeIcon: Icon(Icons.error),
//     desc: message,
//     buttons: [
//       DialogButton(
//         child: Text(
//           "CANCEL",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         onPressed: () => Navigator.pop(context),
//         width: 120,
//         color: Colors.red,
//       )
//     ],
//   ).show();
// }
//
// // // Thông báo thành công
// void _showSuccess(context, String message){
//   Alert(
//     context: context,
//     type: AlertType.success,
//     title: "Thông báo",
//     closeIcon: Icon(Icons.error),
//     desc: message,
//     buttons: [
//       DialogButton(
//         child: Text(
//           "ACCEPT",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         onPressed: () async {
//           StaticData.isSignedIn = true;
//           Database db = await DbProvider.instance.database;
//           await db.execute(
//               '''
//               UPDATE THAMSO
//               SET DADANGNHAP = 1,
//                   MANGUOIDUNG = '${StaticData.userID}';
//               ''');
//           Navigator.pop(context);
//           Navigator.pop(context);
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => MainScreen()),
//           );
//         },
//         width: 120,
//         color: Colors.green[400],
//       )
//     ],
//   ).show();
// }

