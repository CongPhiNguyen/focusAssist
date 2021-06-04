import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:focus_assist/pages/achievenment/screen/achievenment_screen.dart';
import 'package:focus_assist/pages/achievenment/screen/collection_screen.dart';
import 'package:focus_assist/pages/achievenment/screen/shop_screen.dart';
import 'package:focus_assist/pages/farm/feature_ui/object_farm.dart';

class FarmScreen extends StatefulWidget {
  @override
  _FarmScreenState createState() => _FarmScreenState();
}

class _FarmScreenState extends State<FarmScreen> {

  int snailSpriteCount = 1;
  var snailPosX = [0.0,0.5,-0.5,-0.75,0.75,0.0,0.5,-0.5,-0.75,0.75,0.0,0.5,-0.5,-0.75,0.75];
  var snailPosY = [0.0,0.5,-0.5,-0.75,0.75,0.0,0.5,-0.5,-0.75,0.75,0.0,0.5,-0.5,-0.75,0.75];
  List snailDirection = ['up','left','up','down','left'];
  Random rd = new Random();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
    moveObject();
  }

  void load() {
    for (int i = 0; i < StaticData.PokemonUser.length;i++)
      {
        Random rdPos = new Random();
        var x = ((rdPos.nextInt(7) - 7) / 10);
        var y = ((rdPos.nextInt(7) - 7) / 10);
        snailPosX.add(x);
        snailPosY.add(y);

        Random direc = new Random();
        int index = direc.nextInt(4);
        switch (index) {
          case 0 :
            snailDirection[i] = 'left';
            break;
          case 1:
            snailDirection[i] = 'right';
            break;
          case 2:
            snailDirection[i] = 'up';
            break;
          case 3:
            snailDirection[i] = 'down';
            break;
          default:
            break;
        }
      }
  }

  void moveObject(){
    StaticData.timer = Timer.periodic(Duration(milliseconds: 2000),(test){
      setState(() {
        for(int i = 0;i<snailDirection.length;i++) {
          int index = rd.nextInt(4);
          switch (index) {
            case 0 :
              snailDirection[i] = 'left';
              break;
            case 1:
              snailDirection[i] = 'right';
              break;
            case 2:
              snailDirection[i] = 'up';
              break;
            case 3:
              snailDirection[i] = 'down';
              break;
            default:
              break;
          }
        }
      });
    });
    StaticData.timer2 = Timer.periodic(Duration(milliseconds:200), (timer) {
      setState(() {
        snailSpriteCount++;
        for(int i = 0;i< snailDirection.length;i++) {
          if (snailDirection[i] == 'left') {
            snailPosX[i] -= 0.05;
          } else if (snailDirection[i] == 'up') {
            snailPosY[i] -= 0.05;
          } else if (snailDirection[i] == 'down') {
            snailPosY[i] += 0.05;
          } else {
            snailPosX[i] += 0.05;
          }

          if(snailPosX[i] < -0.7) {
            snailDirection[i] = 'right';
          } else if(snailPosX[i] > 0.7){
            snailDirection[i]  = 'left';
          } else if(snailPosY[i] > 0.7) {
            snailDirection[i] = 'up';
          } else if(snailPosY[i] < -0.7){
            snailDirection[i] = 'down';
          }
        }

        if(snailSpriteCount ==3) {
          snailSpriteCount =1;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          children: [
            Container(
              height: size.height*0.2 ,
              child: Row(
                children: [
                  Container(
                    width: size.width*0.25,
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.star),
                        iconSize: 30,
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context){
                                return AchievenmentScreen();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: size.width*0.5,
                    height: size.height*0.2,
                    alignment: Alignment.center,
                    child: Image.asset('assets/achievenment/ui/nongtrai.png'),
                  ),
                  Container(
                    width: size.width*0.25,
                  ),
                ],
              ),
            ),

            Container(
              height: size.height*0.69,
              color: Colors.blue,
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: StaticData.PokemonUser.length,
                    itemBuilder: (context,num){
                      return Container(
                            alignment: Alignment(0.4,-0.4),
                            child: Pokemon(
                              name: 'chimbang',
                              snailDirection: snailDirection[1],
                              snailSpriteCount: snailSpriteCount,
                              rareColor: StaticData.PokemonUser[num].rareColor,
                              level: StaticData.PokemonUser[num].Level,
                            ),
                      );
                    }
                  ),
                  Container(
                    alignment: Alignment(snailPosX[0],snailPosY[0]),
                    child: Pokemon(
                      name: 'chimbang',
                      snailDirection: snailDirection[0],
                      snailSpriteCount: snailSpriteCount,
                      rareColor: Colors.red,
                      level: 100,
                    ),
                  ),
                  Container(
                    alignment: Alignment(snailPosX[1],snailPosY[1]),
                    child: Pokemon(
                      name: 'snail',
                      snailDirection: snailDirection[1],
                      snailSpriteCount: snailSpriteCount,
                      rareColor: Colors.red,
                      level: 100,
                    ),
                  ),

                  Container(
                    alignment: Alignment(snailPosX[2],snailPosY[2]),
                    child: Pokemon(
                      name: 'chimdien',
                      snailDirection: snailDirection[2],
                      snailSpriteCount: snailSpriteCount,
                      rareColor: Colors.red,
                      level: 100,
                    ),
                  ),

                  Container(
                    alignment: Alignment(snailPosX[3],snailPosY[3]),
                    child: Pokemon(
                      name: 'chimlua',
                      snailDirection: snailDirection[3],
                      snailSpriteCount: snailSpriteCount,
                      rareColor: Colors.red,
                      level: 100,
                    ),
                  ),
                  Container(
                    alignment: Alignment(snailPosX[4],snailPosY[4]),
                    child: Pokemon(
                      name: 'fire',
                      snailDirection: snailDirection[4],
                      snailSpriteCount: snailSpriteCount,
                      rareColor: Colors.red,
                      level: 100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
