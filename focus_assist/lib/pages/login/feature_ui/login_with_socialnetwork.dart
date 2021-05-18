import 'package:flutter/material.dart';

import 'color.dart';



class login_with_socialnetwork extends StatelessWidget {
  final String iconImage;
  final Function press;
  const login_with_socialnetwork({
    Key key, this.iconImage, this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: mainColor,
          ),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          iconImage,
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}
