import 'package:flutter/material.dart';

import 'color.dart';



class Donthaveanaccount extends StatelessWidget {
  final bool login;
  final Function press;
  const Donthaveanaccount({
    Key key, this.login = true, this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don't have an Account ? " : "Already have an Account ? ",
          style: TextStyle(color: mainColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up": "Sign In",
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}