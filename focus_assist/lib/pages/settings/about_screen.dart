import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 1,
        title: Text(
          'About',
          style: TextStyle(
            //fontSize: 18.0,
            //fontWeight: FontWeight.bold,
            color: Theme.of(context).appBarTheme.titleTextStyle.color,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Text(
                'Focus Assist',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 25,),
            Text(
              'Version:                  1.0',
            ),
            SizedBox(height: 10,),
            Text(
              'Email:                      hoangdanquang@gmail.com',
            ),
            SizedBox(height: 10,),
            Text(
              'Developed by:        CyberNinja - Born to code',
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(115, 5, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  Text('Hoàng Dận Quang',),
                  SizedBox(height: 5,),
                  Text('Nguyễn Công Phi',),
                  SizedBox(height: 5,),
                  Text('Lương Thiện Phước',),
                  SizedBox(height: 5,),
                  Text('Bùi Như Phước',),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
