import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:focus_assist/pages/focusAssist.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:sqflite/sqflite.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:focus_assist/classes/Data.dart';
import 'classes/DbProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp();
  await initAppSetting();
  await initializeNotification();
  runApp(FocusAssist());
}

Future<void> initAppSetting() async {
  Database db = await DbProvider.instance.database;
  List<Map<String, dynamic>> queryRows = await db.query('THAMSO');
  StaticData.isSignedIn = (queryRows.first['DADANGNHAP'] == 1);
  StaticData.userID = queryRows.first['MANGUOIDUNG'];
}

void initializeNotification() async {
  StaticData.flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS);
  await StaticData.flutterLocalNotificationsPlugin.initialize(initializationSettings,);
}


// class FocusAssist extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Welcome',
//       home: WelcomeScreen(),
//     );
//   }
// }

