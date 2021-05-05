import 'package:flutter/material.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:sqflite/sqflite.dart';

class AccountSettingScreen extends StatefulWidget {
  @override
  _AccountSettingScreenState createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  String username = 'Username';
  String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(00.0, 20.0, 00.0, 0),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Container(
                        alignment: Alignment.topLeft,
                        width: 100.0,
                        child: BackButton(),
                      ),
                      Container(
                        width: 100.0,
                        child: Center(
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/default.png'),
                            backgroundColor: Colors.blue,
                            radius: 40.0,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        width: 100.0,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      '$username',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: 40.0, thickness: 1.5,),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                      child: Text(
                        'CONNECT',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Card(
                      shape: RoundedRectangleBorder(),
                      elevation: 0.0,
                      child: ListTile(
                        onTap: () {},
                        title: Text(
                          'Sign Out',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[500],
                          ),
                        ),
                        tileColor: Colors.blue[50],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                      elevation: 0.0,
                      child: ListTile(
                        onTap: () {},
                        title: Text(
                          'Change Password',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[500],
                          ),
                        ),
                        tileColor: Colors.blue[50],
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.warning_rounded,
                            color: Colors.amber,
                          ),
                          Text(
                            '  CAUTION ZONE',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                      elevation: 0.0,
                      child: ListTile(
                        onTap: () {},
                        title: Text(
                          'Delete Data',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[500],
                          ),
                        ),
                        tileColor: Colors.red[50],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      elevation: 0.0,
                      child: ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        onTap: () {},
                        title: Text(
                          'Delete Account',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[500],
                          ),
                        ),
                        tileColor: Colors.red[50],
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  Map<String, dynamic> row = {'USERID': 1, 'USERNAME': 'Steve'};
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
                    DELETE TABLE USER;
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
      ),
    );
  }
}
