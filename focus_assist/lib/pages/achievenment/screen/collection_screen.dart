import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_assist/pages/achievenment/feature/CardCollection.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CollectionScreen extends StatefulWidget {
  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Collection'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(

            height: size.height*0.1,

          ),
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.amber[200],
            ),
            height: size.height*0.7,
            child: DetailCardCollection(size: size),
          ),
        ],
      ),
    );
  }
}


