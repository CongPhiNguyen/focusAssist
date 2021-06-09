import 'package:flutter/material.dart';

import 'color.dart';




class button_login extends StatelessWidget {
  final String text;
  final Function press;
  final Color color,textColor;
  const button_login({
    Key key,
    this.text,
    this.press,
    this.color = mainColor,
    this.textColor= Colors.white,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: MaterialButton(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
          onPressed: press,
          color: color,
          child: Text(
            text,
            style: TextStyle(color: textColor,fontWeight: FontWeight.bold,letterSpacing: 2.0),
          ),
        ),
      ),
    );
  }
}
