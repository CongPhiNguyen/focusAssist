import 'package:flutter/material.dart';

class PrivacyLockSettingScreen extends StatefulWidget {
  @override
  _PrivacyLockSettingScreenState createState() => _PrivacyLockSettingScreenState();
}

class _PrivacyLockSettingScreenState extends State<PrivacyLockSettingScreen> {
  bool isPrivacyLockEnable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Privacy Lock',
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
          SizedBox(height: 5.0),
          ListTile(
            onTap: () {
              setState(() {
                isPrivacyLockEnable = !isPrivacyLockEnable;
              });
            },
            title: Text(
              'Privacy Lock Enabled',
            ),
            trailing: Switch(
              value: isPrivacyLockEnable,
              onChanged: (value) {
                setState(() {
                  isPrivacyLockEnable = value;
                });
              },
            ),
          ),
          ListTile(
            enabled: isPrivacyLockEnable,
            onTap: () {},
            title: Text(
              'Change Passcode',
            ),
          ),
        ],
      ),
    );
  }
}
