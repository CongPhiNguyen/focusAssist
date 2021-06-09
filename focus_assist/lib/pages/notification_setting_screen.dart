import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:focus_assist/classes/LocalNotificationManager.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:sqflite/sqflite.dart';

class NotificationSettingScreen extends StatefulWidget {
  @override
  _NotificationSettingScreenState createState() => _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  bool isNotificationOn = true;
  bool isMorningNotification = true;
  bool isEveningNotification = true;
  TimeOfDay selectedMorningTime = TimeOfDay(hour: 7, minute: 0);
  TimeOfDay selectedEveningTime = TimeOfDay(hour: 21, minute: 0);

  String maNguoiDung = 'ND001';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadNotificationSetting();
  }

  Future<void> LoadNotificationSetting() async {
    Database db = await DbProvider.instance.database;
    List<dynamic> whereArguments = ['$maNguoiDung'];
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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Notification',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: 0.5,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
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
            tileColor: Colors.white,
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
                await localNotificationManager.showDailyMorningAtTimeNotification(time);
                time = new Time(selectedEveningTime.hour, selectedEveningTime.minute);
                await localNotificationManager.showDailyEveningAtTimeNotification(time);
              }
              else {
                await localNotificationManager.cancelAllNotification();
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
            tileColor: Colors.white,
            onTap: () async {
              setState(() {
                isMorningNotification = !isMorningNotification;
              });
              await UpdateNotificationSetting();
              if (isMorningNotification) {
                Time time = new Time(selectedMorningTime.hour, selectedMorningTime.minute);
                await localNotificationManager.showDailyMorningAtTimeNotification(time);
              }
              else {
                await localNotificationManager.cancelIdNotification(1);
              }
            },
            leading: Icon(
              Icons.wb_twighlight,
              size: 32.0,
              color: Colors.blue,
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
                  await localNotificationManager.showDailyMorningAtTimeNotification(time);
                }
                else {
                  await localNotificationManager.cancelIdNotification(1);
                }
              },
            ),
          ),
          Divider(height:0, thickness: 1, color: Colors.grey[400]),
          ListTile(
            enabled: isMorningNotification,
            tileColor: Colors.white,
            onTap: () {
              selectMorningTime(context);
            },
            title: Text(
              '              Send Notification At',
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
            tileColor: Colors.white,
            onTap: () async {
              setState(() {
                isEveningNotification = !isEveningNotification;
              });
              await UpdateNotificationSetting();
              if (isEveningNotification) {
                Time time = new Time(selectedEveningTime.hour, selectedEveningTime.minute);
                await localNotificationManager.showDailyEveningAtTimeNotification(time);
              }
              else {
                await localNotificationManager.cancelIdNotification(2);
              }
            },
            leading: Icon(
              Icons.nightlight_round,
              size: 32.0,
              color: Colors.blue,
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
                  await localNotificationManager.showDailyEveningAtTimeNotification(time);
                }
                else {
                  await localNotificationManager.cancelIdNotification(2);
                }
              }
            ),
          ),
          Divider(height:0, thickness: 1, color: Colors.grey[400]),
          ListTile(
            enabled: isEveningNotification,
            tileColor: Colors.white,
            onTap: () {
              selectEveningTime(context);
            },
            title: Text(
              '              Send Notification At',
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
          TextButton(
            onPressed: () async {
              Time time = new Time(selectedMorningTime.hour, selectedMorningTime.minute);
              await localNotificationManager.showDailyMorningAtTimeNotification(time);
            },
            child: Text('Send Notification'),
          ),
          TextButton(
            onPressed: () async {
              var list = await localNotificationManager.getListNotification();
              print(list);
            },
            child: Text('List Notification'),
          ),
          TextButton(
            onPressed: () async {
              await localNotificationManager.cancelAllNotification();
            },
            child: Text('Cancel All Notification'),
          ),
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
        await localNotificationManager.cancelIdNotification(1);
        Time time = new Time(selectedMorningTime.hour, selectedMorningTime.minute);
        await localNotificationManager.showDailyMorningAtTimeNotification(time);
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
        await localNotificationManager.cancelIdNotification(1);
        Time time = new Time(selectedEveningTime.hour, selectedEveningTime.minute);
        await localNotificationManager.showDailyEveningAtTimeNotification(time);
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
        WHERE MANGUOIDUNG = '$maNguoiDung';
        '''
    );
    print('Update Notification setting completed');
  }
}
