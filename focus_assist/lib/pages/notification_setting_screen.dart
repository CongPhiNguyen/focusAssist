import 'package:flutter/material.dart';

class NotificationSettingScreen extends StatefulWidget {
  @override
  _NotificationSettingScreenState createState() => _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  bool isNotificationOn = true;
  bool isMorningNotification = true;
  bool isEveningNotification = true;

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
            onTap: () {
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
            },
            title: Text(
              '      Notification',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            trailing: Switch(
                value: isNotificationOn,
                onChanged: (value) {
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
            onTap: () {
              setState(() {
                isMorningNotification = !isMorningNotification;
              });
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
                onChanged: (value) {
                  setState(() {
                    isMorningNotification = value;
                  });
                }
            ),
          ),
          Divider(height:0, thickness: 1, color: Colors.grey[400]),
          ListTile(
            enabled: isMorningNotification,
            tileColor: Colors.white,
            onTap: () {},
            title: Text(
              '              Send Notification At',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '7:00 AM',
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
            onTap: () {
              setState(() {
                isEveningNotification = !isEveningNotification;
              });
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
                onChanged: (value) {
                  setState(() {
                    isEveningNotification = value;
                  });
                }
            ),
          ),
          Divider(height:0, thickness: 1, color: Colors.grey[400]),
          ListTile(
            enabled: isEveningNotification,
            tileColor: Colors.white,
            onTap: () {},
            title: Text(
              '              Send Notification At',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '9:00 PM',
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
        ],
      ),
    );
  }
}
