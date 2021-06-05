import 'package:flutter/material.dart';

class ListAchivement extends StatefulWidget {
  const ListAchivement({Key key}) : super(key: key);

  @override
  _ListAchivementState createState() => _ListAchivementState();
}
//Đây sẽ list các thành tựu các kiếu sau

class _ListAchivementState extends State<ListAchivement> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
            child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text("FUCK")],
          ),
        )));
  }
}
