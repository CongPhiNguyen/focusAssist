import 'dart:async';
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
  var snailPosX = [0.0,0.5,-0.5,-0.75,0.75];
  var snailPosY = [0.0,0.5,-0.5,-0.75,0.75];
  List snailDirection = ['up','left','up','down','left'];
  Random rd = new Random();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moveObject();
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.shopping_cart_rounded),
                            iconSize: 30,
                            onPressed: ()async {
                              // update vàng người dùng từ database

                              String id = StaticData.userID;
                              final k = await DbProvider.instance.rawQuery('''
                                select * from THONGTINNGUOIDUNG where MANGUOIDUNG = '$id'
                                '''
                              );
                              StaticData.Vang = k[0]['VANG'];

                              Loading();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context){return ShopScreen();})
                              );
                            },
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.collections),
                            iconSize: 30,
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context){
                                    return CollectionScreen();
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: size.height*0.69,
              color: Colors.blue,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment(snailPosX[0],snailPosY[0]),
                    child: BlueSnail(
                      name: 'chimbang',
                      snailDirection: snailDirection[0],
                      snailSpriteCount: snailSpriteCount,
                    ),
                  ),
                  Container(
                    alignment: Alignment(snailPosX[1],snailPosY[1]),
                    child: BlueSnail(
                      name: 'snail',
                      snailDirection: snailDirection[1],
                      snailSpriteCount: snailSpriteCount,
                    ),
                  ),

                  Container(
                    alignment: Alignment(snailPosX[2],snailPosY[2]),
                    child: BlueSnail(
                      name: 'chimdien',
                      snailDirection: snailDirection[2],
                      snailSpriteCount: snailSpriteCount,
                    ),
                  ),

                  Container(
                    alignment: Alignment(snailPosX[3],snailPosY[3]),
                    child: BlueSnail(
                      name: 'chimlua',
                      snailDirection: snailDirection[3],
                      snailSpriteCount: snailSpriteCount,
                    ),
                  ),
                  Container(
                    alignment: Alignment(snailPosX[4],snailPosY[4]),
                    child: BlueSnail(
                      name: 'fire',
                      snailDirection: snailDirection[4],
                      snailSpriteCount: snailSpriteCount,
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
