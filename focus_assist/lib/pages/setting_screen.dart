import 'package:flutter/material.dart';
import 'package:focus_assist/classes/my_bottom_navigation_bar.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(00.0, 20.0, 00.0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
              child: Text(
                'ACCOUNT',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16.0,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            SizedBox(height: 5.0,),
            Card(
              child: ListTile (
                onTap: () {},
                title: Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                leading: Icon(
                  Icons.account_circle_outlined,
                  size: 36.0,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.navigate_next),
              ),
            ),
            Divider(height: 30.0, thickness: 2.0, indent: 65.0,),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
              child: Text(
                'APP BEHAVIOR',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16.0,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            SizedBox(height: 5.0,),
            Card(
              child: ListTile (
                onTap: () {},
                title: Text(
                  'Notifications',
                ),
                leading: Icon(
                  Icons.notifications,
                  size: 36.0,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.navigate_next),
              ),
            ),
            //Divider(height: 20.0, thickness: 2.0, indent: 65.0,),
            Card(
              child: ListTile (
                onTap: () {},
                title: Text(
                  'Privacy Lock',
                ),
                leading: Icon(
                  Icons.lock_outline_rounded,
                  size: 36.0,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.navigate_next),
              ),
            ),
            Divider(height: 30.0, thickness: 2.0, indent: 65.0,),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
              child: Text(
                'SUPPORT',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16.0,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            SizedBox(height: 5.0,),
            Card(
              child: ListTile (
                onTap: () {},
                title: Text(
                  'Chat with Our Support Team',
                ),
                leading: Icon(
                  Icons.chat_rounded,
                  size: 36.0,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.navigate_next),
              ),
            ),
            Divider(height: 30.0, thickness: 2.0, indent: 65.0,),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
              child: Text(
                'ABOUT',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16.0,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            SizedBox(height: 5.0,),
            Card(
              child: ListTile (
                onTap: () {},
                title: Text(
                  'About',
                ),
                leading: Icon(
                  Icons.info_rounded,
                  size: 36.0,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.navigate_next),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottonNavigationBar(selectedIndex: 4,),
    );
  }
}
