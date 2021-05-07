import 'package:flutter/material.dart';

class ViewAllActivity extends StatefulWidget {
  @override
  _ViewAllActivityState createState() => _ViewAllActivityState();
}

class _ViewAllActivityState extends State<ViewAllActivity> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          actions: [FlatButton(onPressed: () {}, child: Text("Back"))],
          title: Text("View Activity"),
        ),
      ),
    );
  }
}
