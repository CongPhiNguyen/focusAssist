import 'package:flutter/material.dart';

import 'color.dart';



class Or extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              color: mainColor,
              height: 1.5,
            ),
          ),
          Text(
            ' OR ',
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Divider(
              color: mainColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}