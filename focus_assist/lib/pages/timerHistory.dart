import 'package:flutter/material.dart';

class timerHistory extends StatefulWidget {
  @override
  _timerHistoryState createState() => _timerHistoryState();
}

class _timerHistoryState extends State<timerHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: ListView(  
          children: <Widget>[  
            ListTile(  
              leading: Text('1', style: TextStyle(fontSize: 25),),  
              title: Text('6/6/2020  09:16:00 '),  
            ),  
            ListTile(  
              leading: Text('2', style: TextStyle(fontSize: 25),),   
              title: Text('7/6/2020  09:16:00 '),   
            ),  
            ListTile(  
              leading: Text('3', style: TextStyle(fontSize: 25),),   
              title: Text('8/6/2020  09:16:00 '), 
            ),  
            ListTile(  
              leading: Text('4', style: TextStyle(fontSize: 25),),   
              title: Text('6/6/2020  09:16:00 '),   
            ),  
            ListTile(  
              leading: Text('5', style: TextStyle(fontSize: 25),),   
              title: Text('6/6/2020  09:16:00 '), 
            ),  
          ],  
        ),  
    );
  }
}