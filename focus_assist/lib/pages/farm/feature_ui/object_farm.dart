import 'dart:math';

import 'package:flutter/material.dart';


class Pokemon extends StatelessWidget {

  final int snailSpriteCount;
  final String snailDirection;
  final String name;
  final Color rareColor;
  final int level;
  final Function press;
  final Function longPress;

  const Pokemon({Key key, this.snailSpriteCount, this.snailDirection, this.name, this.rareColor, this.level, this.press, this.longPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(rareColor == Colors.redAccent)
    {
      if(level >= 1 && level < 25)
      {
        if (snailDirection == 'left') {
          return Container(
            alignment: Alignment.bottomCenter,
            height: 120,
            width: 120,
            child:GestureDetector(
              onLongPress: longPress,
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
              onLongPress: longPress,
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
              onLongPress: longPress,
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
              onLongPress: longPress,
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
      else if(level < 50)
        {
          if (snailDirection == 'left') {
            return Container(
              alignment: Alignment.bottomCenter,
              height: 120,
              width: 120,
              child:GestureDetector(
                onLongPress: longPress,
                onTap: press,
                child: Column(
                  children: [
                    Text(
                      name,
                      style: TextStyle(color: rareColor,fontSize: 15,fontWeight: FontWeight.bold),
                    ),
                    Text('Level : '+ level.toString(),),
                    Image.asset('assets/achievenment/move/'+"Blue"+snailSpriteCount.toString()+'.png'),
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
                onLongPress: longPress,
                onTap: press,
                child: Column(
                  children: [
                    Text(
                      name,
                      style: TextStyle(color: rareColor,fontSize: 15,fontWeight: FontWeight.bold),
                    ),
                    Text('Level : '+ level.toString(),),
                    Image.asset('assets/achievenment/move/'+"Blue"+'Up'+ snailSpriteCount.toString()+'.png'),
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
                onLongPress: longPress,
                onTap: press,
                child: Column(
                  children: [
                    Text(
                      name,
                      style: TextStyle(color: rareColor,fontSize: 15,fontWeight: FontWeight.bold),
                    ),
                    Text('Level : '+ level.toString(),),
                    Image.asset('assets/achievenment/move/'+"Blue"+'Down'+ snailSpriteCount.toString()+'.png'),
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
                onLongPress: longPress,
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
                      Image.asset('assets/achievenment/move/'+"Blue"+snailSpriteCount.toString()+'.png'),
                    ],
                  ),
                  //Image.asset('assets/achievenment/move/'+name+snailSpriteCount.toString()+'.png'),
                ),
              ),
            );
          }
        }
      else if ( level == 50)
        {
          if (snailDirection == 'left') {
            return Container(
              alignment: Alignment.bottomCenter,
              height: 120,
              width: 120,
              child:GestureDetector(
                onLongPress: longPress,
                onTap: press,
                child: Column(
                  children: [
                    Text(
                      name,
                      style: TextStyle(color: rareColor,fontSize: 15,fontWeight: FontWeight.bold),
                    ),
                    Text('Level : '+ level.toString(),),
                    Image.asset('assets/achievenment/move/'+"Carpentry"+ snailSpriteCount.toString()+'.png'),
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
                onLongPress: longPress,
                onTap: press,
                child: Column(
                  children: [
                    Text(
                      name,
                      style: TextStyle(color: rareColor,fontSize: 15,fontWeight: FontWeight.bold),
                    ),
                    Text('Level : '+ level.toString(),),
                    Image.asset('assets/achievenment/move/'+"Carpentry"+'Up'+ snailSpriteCount.toString()+'.png'),
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
                onLongPress: longPress,
                onTap: press,
                child: Column(
                  children: [
                    Text(
                      name,
                      style: TextStyle(color: rareColor,fontSize: 15,fontWeight: FontWeight.bold),
                    ),
                    Text('Level : '+ level.toString(),),
                    Image.asset('assets/achievenment/move/'+"Carpentry"+'Down'+ snailSpriteCount.toString()+'.png'),
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
                onLongPress: longPress,
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
                      Image.asset('assets/achievenment/move/'+"Carpentry"+snailSpriteCount.toString()+'.png'),
                    ],
                  ),
                  //Image.asset('assets/achievenment/move/'+name+snailSpriteCount.toString()+'.png'),
                ),
              ),
            );
          }
        }

    }
    else {
      if (snailDirection == 'left') {
        return Container(
          alignment: Alignment.bottomCenter,
          height: 120,
          width: 120,
          child:GestureDetector(
            onLongPress: longPress,
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
            onLongPress: longPress,
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
            onLongPress: longPress,
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
            onLongPress: longPress,
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
}
