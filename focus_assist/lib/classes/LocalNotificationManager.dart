// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'dart:io' show Platform;
// import 'package:rxdart/subjects.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:focus_assist/classes/Data.dart';
//
//
// class LocalNotificationManager {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   var initSetting;
//
//   BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject => BehaviorSubject<ReceiveNotification>();
//
//   LocalNotificationManager.init() {
//     print('init');
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     if (Platform.isIOS) {
//       requestIOSPermission();
//     }
//     initializePlatform();
//     tz.initializeTimeZones();
//     tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
//     //final String timezone = await FlutterNativeTimezone.getLocalTimezone();
//     //print(timezone);
//   }
//
//   requestIOSPermission() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation
//         <IOSFlutterLocalNotificationsPlugin>().requestPermissions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
//
//   initializePlatform() {
//     try {
//       var initSettingAndroid = AndroidInitializationSettings("@mipmap/ic_launcher");
//       var initSettingIOS = IOSInitializationSettings(
//           requestSoundPermission: true,
//           requestBadgePermission: true,
//           requestAlertPermission: true,
//           onDidReceiveLocalNotification: (id, title, body, payload) async {
//             ReceiveNotification notification = ReceiveNotification(id: id, title: title, body: body, payload: payload);
//             didReceiveLocalNotificationSubject.add(notification);
//           }
//       );
//       initSetting = InitializationSettings(android: initSettingAndroid, iOS: initSettingIOS);
//       flutterLocalNotificationsPlugin.initialize(initSetting);
//     } catch(e) {
//       print('Local Notification Error: ${e.toString()}');
//     }
//
//   }
//
//   setOnNotificationReceive(Function onNotificationReceive) {
//     didReceiveLocalNotificationSubject.listen((notification) {
//       onNotificationReceive(notification);
//     });
//   }
//
//   setOnNotificationClick(Function onNotificationClick) async {
//     await flutterLocalNotificationsPlugin.initialize(initSetting,
//       onSelectNotification: (String payload) async {
//         onNotificationClick(payload);
//       });
//   }
//
//   tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//     tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }
//
//   Future<void> showNotification() async {
//     var androidChannel = AndroidNotificationDetails(
//       'CHANNEL_ID',
//       'CHANNEL_NAME',
//       'CHANNEL_DESCRIPTION',
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//     );
//     var iOSChannel = IOSNotificationDetails();
//     var platformChannel = NotificationDetails(android: androidChannel, iOS: iOSChannel);
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Notification title',
//       'Notification body',
//       platformChannel,
//       payload: 'New payload',
//     );
//   }
//
//   Future<void> showDailyMorningAtTimeNotification(Time time) async {
//     var androidChannel = AndroidNotificationDetails(
//       'CHANNEL_ID 1',
//       'CHANNEL_NAME 1',
//       'CHANNEL_DESCRIPTION 1',
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//     );
//     var iOSChannel = IOSNotificationDetails();
//     var platformChannel = NotificationDetails(android: androidChannel, iOS: iOSChannel);
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       1,
//       'Focus Assist',
//       'Morning Quote Notification',
//       _nextInstanceOfTime(time.hour, time.minute),
//       platformChannel,
//       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//       androidAllowWhileIdle: true,
//       payload: 'New payload',
//       matchDateTimeComponents: DateTimeComponents.time,
//     );
//   }
//
//   Future<void> showDailyEveningAtTimeNotification(Time time) async {
//     var androidChannel = AndroidNotificationDetails(
//       'CHANNEL_ID 1',
//       'CHANNEL_NAME 1',
//       'CHANNEL_DESCRIPTION 1',
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//     );
//     var iOSChannel = IOSNotificationDetails();
//     var platformChannel = NotificationDetails(android: androidChannel, iOS: iOSChannel);
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       2,
//       'Focus Assist',
//       'Remember to check in all your today activities',
//       _nextInstanceOfTime(time.hour, time.minute),
//       platformChannel,
//       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//       androidAllowWhileIdle: true,
//       payload: 'New payload',
//       matchDateTimeComponents: DateTimeComponents.time,
//     );
//   }
//
//   Future <List<ActiveNotification>> getListNotification() async {
//     final List<ActiveNotification> activeNotifications =
//         await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.getActiveNotifications();
//     print(activeNotifications.length);
//     return activeNotifications;
//   }
//
//   Future<void> cancelIdNotification(int id) async {
//     await flutterLocalNotificationsPlugin.cancel(id);
//   }
//
//   Future<void> cancelAllNotification() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }
// }
//
// // LocalNotificationManager localNotificationManager = LocalNotificationManager.init();
//
// class ReceiveNotification {
//   final int id;
//   final String title;
//   final String body;
//   final String payload;
//   ReceiveNotification({@required this.id, @required this.title, @required this.body, @required this.payload});
// }


// class LocalNotificationManager {
//   static showNotification() async {
//     const androidChannel = AndroidNotificationDetails(
//       'CHANNEL_ID',
//       'CHANNEL_NAME',
//       'CHANNEL_DESCRIPTION',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     var iOSChannel = IOSNotificationDetails();
//     var platformChannel = NotificationDetails(android: androidChannel, iOS: iOSChannel);
//     await StaticData.flutterLocalNotificationsPlugin.show(
//       0,
//       'Notification title',
//       'Notification body',
//       platformChannel,
//       payload: 'New payload',
//     );
//   }
//
// }