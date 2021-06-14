import 'dart:math';

import 'package:flutter/material.dart';

/*class Pokemon extends StatefulWidget {
  final int snailSpriteCount;
  final String snailDirection;
  final String name;
  final Color rareColor;
  final int level;

  const Pokemon({Key key, this.snailSpriteCount, this.snailDirection, this.name, this.rareColor, this.level}) : super(key: key);
  @override
  _PokemonState createState() => _PokemonState(snailSpriteCount,snailDirection,name,rareColor,level);
}

class _PokemonState extends State<Pokemon> {
  final int snailSpriteCount;
  final String snailDirection;
  final String name;
  final Color rareColor;
  int level;

  _PokemonState(this.snailSpriteCount, this.snailDirection, this.name, this.rareColor, this.level);
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
}*/


class Pokemon extends StatelessWidget {

  final int snailSpriteCount;
  final String snailDirection;
  final String name;
  final Color rareColor;
  final int level;
  final Function press;

  const Pokemon({Key key, this.snailSpriteCount, this.snailDirection, this.name, this.rareColor, this.level, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snailDirection == 'left') {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 120,
        width: 120,
        child:GestureDetector(
          onTap: press,
          child: Column(
            children: [
              Text(
                name,
                style: TextStyle(color: rareColor,fontSize: 15,fontWeight: FontWeight.bold),
              ),
              Text('Level : '+ level.toString(),),
              Image.asset('assets/achievenment/move/'+name+ snailSpriteCount.toString()+'.png'),
            ],
          ),
        ),
      );
    } else if (snailDirection == 'up'){
      return Container(
        alignment: Alignment.bottomCenter,
        height: 120,
        width: 120,
        child: GestureDetector(
          onTap: press,
          child: Column(
            children: [
              Text(
                name,
                style: TextStyle(color: rareColor,fontSize: 15,fontWeight: FontWeight.bold),
              ),
              Text('Level : '+ level.toString(),),
              Image.asset('assets/achievenment/move/'+name+'Up'+ snailSpriteCount.toString()+'.png'),
            ],
          ),
        ),
      );
    } else if (snailDirection == 'down'){
      return Container(
        alignment: Alignment.bottomCenter,
        height: 120,
        width: 120,
        child: GestureDetector(
          onTap: press,
          child: Column(
            children: [
              Text(
                name,
                style: TextStyle(color: rareColor,fontSize: 15,fontWeight: FontWeight.bold),
              ),
              Text('Level : '+ level.toString(),),
              Image.asset('assets/achievenment/move/'+name+'Down'+ snailSpriteCount.toString()+'.png'),
            ],
          ),
        ),
       // Image.asset('assets/achievenment/move/'+name+'Down'+ snailSpriteCount.toString()+'.png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: GestureDetector(
          onTap: press,
          child: Container(
            alignment: Alignment.bottomCenter,
            height: 120,
            width: 120,
            child: Column(
              children: [
                Text(
                  name,
                  style: TextStyle(color: rareColor,fontSize: 15,fontWeight: FontWeight.bold),
                ),
                Text('Level : '+ level.toString(),),
                Image.asset('assets/achievenment/move/'+name+snailSpriteCount.toString()+'.png'),
              ],
            ),
            //Image.asset('assets/achievenment/move/'+name+snailSpriteCount.toString()+'.png'),
          ),
        ),
      );
    }
  }
}
