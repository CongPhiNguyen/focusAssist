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
          style: TextStyle(color: Colors.amber[900]),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up": "Sign In",
            style: TextStyle(
              fontSize: 15,
              color: Colors.blue[300],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}