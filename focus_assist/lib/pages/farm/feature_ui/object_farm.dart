import 'dart:math';

import 'package:flutter/material.dart';

class BlueSnail extends StatelessWidget {

  final int snailSpriteCount;
  final String snailDirection;
  final String name;

  const BlueSnail({Key key, this.snailSpriteCount, this.snailDirection, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snailDirection == 'left') {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 75,
        width: 75,
        child: Image.asset('assets/achievenment/move/'+name+ snailSpriteCount.toString()+'.png'),
      );
    } else if (snailDirection == 'up'){
      return Container(
        alignment: Alignment.bottomCenter,
        height: 75,
        width: 75,
        child: Image.asset('assets/achievenment/move/'+name+'Up'+ snailSpriteCount.toString()+'.png'),
      );
    } else if (snailDirection == 'down'){
      return Container(
        alignment: Alignment.bottomCenter,
        height: 75,
        width: 75,
        child: Image.asset('assets/achievenment/move/'+name+'Down'+ snailSpriteCount.toString()+'.png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 75,
          width: 75,
          child: Image.asset('assets/achievenment/move/'+name+snailSpriteCount.toString()+'.png'),
        ),
      );
    }
  }
}
