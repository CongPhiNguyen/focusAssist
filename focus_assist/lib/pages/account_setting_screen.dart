import 'package:flutter/material.dart';

class AccountSettingScreen extends StatefulWidget {
  @override
  _AccountSettingScreenState createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  String username = 'Username';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
        child: Column(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/default.png'),
                    backgroundColor: Colors.grey,
                    radius: 50.0,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '$username',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 40.0, thickness: 1.5,),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
              child: ListTile(
                onTap: () {},
                title: Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blue[700],
                  ),
                ),
                tileColor: Colors.lightBlue[50],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
              child: ListTile(
                onTap: () {},
                title: Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blue[700],
                  ),
                ),
                tileColor: Colors.lightBlue[50],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
