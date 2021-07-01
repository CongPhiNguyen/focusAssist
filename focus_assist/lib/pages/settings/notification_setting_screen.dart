import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/LocalNotificationManager.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:sqflite/sqflite.dart';


class NotificationSettingScreen extends StatefulWidget {
  @override
  _NotificationSettingScreenState createState() => _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  //FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool isNotificationOn = true;
  bool isMorningNotification = true;
  bool isEveningNotification = true;
  TimeOfDay selectedMorningTime = TimeOfDay(hour: 7, minute: 0);
  TimeOfDay selectedEveningTime = TimeOfDay(hour: 21, minute: 0);

  //String maNguoiDung = 'ND001';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadNotificationSetting();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
  }

  Future<void> LoadNotificationSetting() async {
    Database db = await DbProvider.instance.database;
    List<dynamic> whereArguments = ['${StaticData.userID}'];
    List<Map<String, dynamic>> queryRows = await db.query('THONGTINNGUOIDUNG', where: 'MANGUOIDUNG = ?', whereArgs: whereArguments);
    if (queryRows.first == null) {
      print('Null query');
      return;
    }
    try {
      setState(() {
        isNotificationOn = queryRows.first['THONGBAO'] == 1;
        isMorningNotification = queryRows.first['THONGBAOSANG'] == 1;
        isEveningNotification = queryRows.first['THONGBAOTOI'] == 1;
        selectedMorningTime = StringToTimeOfDay(queryRows.first['THOIGIANTHONGBAOSANG']);
        selectedEveningTime = StringToTimeOfDay(queryRows.first['THOIGIANTHONGBAOTOI']);
      });
    }
    catch (e) {
      print('Error setting notification: $e');
    }
  }

  TimeOfDay StringToTimeOfDay(String timeString) {
    List<String> splitString = timeString.split(':');
    TimeOfDay time = TimeOfDay(hour: int.parse(splitString[0]), minute: int.parse(splitString[1]));
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      backgroundColor: (!StaticData.isDarkMode)?Colors.grey[50]:Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        // elevation: 1,
        title: Text(
          'Notification',
          style: TextStyle(
            //fontSize: 18.0,
            //fontWeight: FontWeight.bold,
            color: Theme.of(context).appBarTheme.titleTextStyle.color,
            letterSpacing: 0.5,
          ),
        ),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(
        //     Icons.arrow_back,
        //     // color: Colors.black,
        //   ),
        // ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 0, 15.0),
            child: Text(
              'GENERAL',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                letterSpacing: 0.5,
              ),
            ),
          ),
          ListTile (
            // tileColor: Theme.of(context).scaffoldBackgroundColor,
            tileColor: (!StaticData.isDarkMode)?Colors.white:Theme.of(context).backgroundColor,
            onTap: () async {
              setState(() {
                isNotificationOn = !isNotificationOn;
                if (isNotificationOn) {
                  isMorningNotification = true;
                  isEveningNotification = true;
                }
                else {
                  isMorningNotification = false;
                  isEveningNotification = false;
                }
              });
              await UpdateNotificationSetting();
              if (isNotificationOn) {
                Time time = new Time(selectedMorningTime.hour, selectedMorningTime.minute);
                await showDailyMorningAtTimeNotification(time);
                time = new Time(selectedEveningTime.hour, selectedEveningTime.minute);
                await showDailyEveningAtTimeNotification(time);
              }
              else {
                await cancelAllNotification();
              }
            },
            title: Text(
              '      Notification',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            trailing: Switch(
                value: isNotificationOn,
                onChanged: (value) async {
                  setState(() {
                    isNotificationOn = value;
                    if (isNotificationOn) {
                      isMorningNotification = true;
                      isEveningNotification = true;
                    }
                    else {
                      isMorningNotification = false;
                      isEveningNotification = false;
                    }
                  });
                  await UpdateNotificationSetting();
                  if (isNotificationOn) {
                    Time time = new Time(selectedMorningTime.hour, selectedMorningTime.minute);
                    await showDailyMorningAtTimeNotification(time);
                    time = new Time(selectedEveningTime.hour, selectedEveningTime.minute);
                    await showDailyEveningAtTimeNotification(time);
                  }
                  else {
                    await cancelAllNotification();
                  }
                }
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 0, 15.0),
            child: Text(
              'DAILY BRIEFING',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                letterSpacing: 0.5,
              ),
            ),
          ),
          ListTile (
            enabled: isNotificationOn,
            minVerticalPadding: 30.0,
            // tileColor: Theme.of(context).scaffoldBackgroundColor,
            tileColor: (!StaticData.isDarkMode)?Colors.white:Theme.of(context).backgroundColor,
            onTap: () async {
              setState(() {
                isMorningNotification = !isMorningNotification;
              });
              await UpdateNotificationSetting();
              if (isMorningNotification) {
                Time time = new Time(selectedMorningTime.hour, selectedMorningTime.minute);
                await showDailyMorningAtTimeNotification(time);
              }
              else {
                await cancelIdNotification(1);
              }
            },
            leading: Icon(
              Icons.wb_twighlight,
              size: 32.0,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'Morning',
            ),
            trailing: Switch(
              value: isMorningNotification,
              onChanged: (value) async {
                setState(() {
                  isMorningNotification = value;
                });
                await UpdateNotificationSetting();
                if (isMorningNotification) {
                  Time time = new Time(selectedMorningTime.hour, selectedMorningTime.minute);
                  await showDailyMorningAtTimeNotification(time);
                }
                else {
                  await cancelIdNotification(1);
                }
              },
            ),
          ),
          Divider(height:0, thickness: 1,),
          ListTile(
            enabled: isMorningNotification,
            // tileColor: Theme.of(context).scaffoldBackgroundColor,
            tileColor: (!StaticData.isDarkMode)?Colors.white:Theme.of(context).backgroundColor,
            onTap: () {
              selectMorningTime(context);
            },
            title: Text(
              '         Send Notification At',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '${(selectedMorningTime.hour < 12)?selectedMorningTime.hour:(selectedMorningTime.hour - 12)}'
                      ':${(selectedMorningTime.minute < 10)?'0${selectedMorningTime.minute}':selectedMorningTime.minute}'
                      ' ${(selectedMorningTime.hour < 12)?'AM':'PM'}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[500],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.navigate_next),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          ListTile (
            enabled: isNotificationOn,
            minVerticalPadding: 30.0,
            // tileColor: Theme.of(context).scaffoldBackgroundColor,
            tileColor: (!StaticData.isDarkMode)?Colors.white:Theme.of(context).backgroundColor,
            onTap: () async {
              setState(() {
                isEveningNotification = !isEveningNotification;
              });
              await UpdateNotificationSetting();
              if (isEveningNotification) {
                Time time = new Time(selectedEveningTime.hour, selectedEveningTime.minute);
                await showDailyEveningAtTimeNotification(time);
              }
              else {
                await cancelIdNotification(2);
              }
            },
            leading: Icon(
              Icons.nightlight_round,
              size: 32.0,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'Evening',
            ),
            trailing: Switch(
              value: isEveningNotification,
              onChanged: (value) async {
                setState(() {
                  isEveningNotification = value;
                });
                await UpdateNotificationSetting();
                if (isEveningNotification) {
                  Time time = new Time(selectedEveningTime.hour, selectedEveningTime.minute);
                  await showDailyEveningAtTimeNotification(time);
                }
                else {
                  await cancelIdNotification(2);
                }
              }
            ),
          ),
          Divider(height:0, thickness: 1,),
          ListTile(
            enabled: isEveningNotification,
            // tileColor: Theme.of(context).scaffoldBackgroundColor,
            tileColor: (!StaticData.isDarkMode)?Colors.white:Theme.of(context).backgroundColor,
            onTap: () {
              selectEveningTime(context);
            },
            title: Text(
              '         Send Notification At',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '${(selectedEveningTime.hour < 12)?selectedEveningTime.hour:(selectedEveningTime.hour - 12)}'
                      ':${(selectedEveningTime.minute < 10)?'0${selectedEveningTime.minute}':selectedEveningTime.minute}'
                      ' ${(selectedEveningTime.hour < 12)?'AM':'PM'}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[500],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.navigate_next),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // TextButton(
          //   onPressed: () async {
          //     Time time = new Time(selectedMorningTime.hour, selectedMorningTime.minute);
          //     await showNotification();
          //     //await LocalNotificationManager.showNotification();
          //   },
          //   child: Text('Send Notification'),
          // ),
          // TextButton(
          //   onPressed: () async {
          //     var list = await getListPendingNotification();
          //     print(list.length);
          //     for (int i = 0; i < list.length; i++) {
          //       print('${list[i].id}  /  ${list[i].body}');
          //     }
          //   },
          //   child: Text('List Notification'),
          // ),
          // TextButton(
          //   onPressed: () async {
          //     await cancelAllNotification();
          //   },
          //   child: Text('Cancel All Notification'),
          // ),
        ],
      ),
    );
  }

  Future<void> selectMorningTime(BuildContext context) async {
    TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedMorningTime, builder: (BuildContext context, Widget child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child,
      );});

    if (picked_s != null && picked_s != selectedMorningTime ) {
      setState(() {
        selectedMorningTime = picked_s;
      });
      await UpdateNotificationSetting();
      if (isMorningNotification) {
        await cancelIdNotification(1);
        Time time = new Time(selectedMorningTime.hour, selectedMorningTime.minute);
        await showDailyMorningAtTimeNotification(time);
      }
    }
  }

  Future<void> selectEveningTime(BuildContext context) async {
    TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedEveningTime, builder: (BuildContext context, Widget child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child,
      );});

    if (picked_s != null && picked_s != selectedEveningTime ) {
      setState(() {
        selectedEveningTime = picked_s;
      });
      await UpdateNotificationSetting();
      if (isEveningNotification) {
        await cancelIdNotification(1);
        Time time = new Time(selectedEveningTime.hour, selectedEveningTime.minute);
        await showDailyEveningAtTimeNotification(time);
      }
    }
  }

  Future UpdateNotificationSetting() async {
    Database db = await DbProvider.instance.database;
    await db.execute(
        '''
        UPDATE THONGTINNGUOIDUNG
        SET THONGBAO = ${isNotificationOn?1:0},
            THONGBAOSANG = ${isMorningNotification?1:0},
            THONGBAOTOI = ${isEveningNotification?1:0},
            THOIGIANTHONGBAOSANG = '${(selectedMorningTime.hour < 10)?'0${selectedMorningTime.hour}':selectedMorningTime.hour}:${(selectedMorningTime.minute < 10)?'0${selectedMorningTime.minute}':selectedMorningTime.minute}:00',
            THOIGIANTHONGBAOTOI = '${(selectedEveningTime.hour < 10)?'0${selectedEveningTime.hour}':selectedEveningTime.hour}:${(selectedEveningTime.minute < 10)?'0${selectedEveningTime.minute}':selectedEveningTime.minute}:00'
        WHERE MANGUOIDUNG = '${StaticData.userID}';
        '''
    );
    print('Update Notification setting completed');
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

  cancelAllNotification() async {
    await StaticData.flutterLocalNotificationsPlugin.cancelAll();
  }

  cancelIdNotification(int id) async {
    await StaticData.flutterLocalNotificationsPlugin.cancel(id);
  }

  showNotification() async {
    const androidChannel = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      'CHANNEL_DESCRIPTION',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(''),
    );
    var iOSChannel = IOSNotificationDetails();
    var platformChannel = NotificationDetails(android: androidChannel, iOS: iOSChannel);
    await StaticData.flutterLocalNotificationsPlugin.show(
      0,
      'Notification title',
      'Notification body',
      platformChannel,
      payload: 'New payload',
    );
  }


  Future <List<ActiveNotification>> getListActiveNotification() async {
    final List<ActiveNotification> activeNotifications =
        await StaticData.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.getActiveNotifications();
    print(activeNotifications.length);
    return activeNotifications;
  }

  Future <List<PendingNotificationRequest>> getListPendingNotification() async {
    final List<PendingNotificationRequest> pendingNotifications =
    await StaticData.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.pendingNotificationRequests();
    print(pendingNotifications.length);
    return pendingNotifications;
  }

}
