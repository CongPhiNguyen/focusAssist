import 'package:flutter/material.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:sqflite/sqflite.dart';

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
            TextButton(
              onPressed: () async {
                Map<String, dynamic> row = {'USERID': 2, 'USERNAME': 'Henry'};
                int i = await DbProvider.instance.insert(
                  'USER', row);
                print('value of insert: $i');
              },
              child: Text(
                'Insert',
              ),
            ),
            TextButton(
              onPressed: () async {
                List<Map<String, dynamic>> queryRows = await DbProvider.instance.query('USER');
                print(queryRows);
              },
              child: Text(
                'Query',
              ),
            ),
            TextButton(
              onPressed: () async {
                Database db = await DbProvider.instance.database;
                db.execute(
                  '''
                  UPDATE USER
                  SET USERNAME = 'Walt'
                  WHERE USERID = 3;
                  '''
                );
              },
              child: Text(
                'Update',
              ),
            ),
            TextButton(
              onPressed: () async {
                Database db = await DbProvider.instance.database;
                db.execute(
                  '''
                  DELETE FROM USER;
                  '''
                );
              },
              child: Text(
                'Delete',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
