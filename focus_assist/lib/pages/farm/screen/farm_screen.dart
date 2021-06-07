import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  List<Widget> pokemonWidgetList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Loading();
    InitPokemonUser();
    startAnimation();
  }


  void InitPokemonUser () {
    List<Widget> finalList = [];
    for (int i = 0; i < StaticData.PokemonUsers.length; i++) {
      finalList.add(ContainerToPokemonWidget(i));
    }
    setState(() {
      pokemonWidgetList = finalList;
    });
  }

  Widget ContainerToPokemonWidget(int index) {
    return Container(
      alignment: Alignment(StaticData.PokemonUsers[index].positionX,StaticData.PokemonUsers[index].positionY),
      child: Pokemon(
        name: StaticData.PokemonUsers[index].TenPokemon,
        snailDirection: StaticData.PokemonUsers[index].direction,
        snailSpriteCount: StaticData.PokemonUsers[index].currentFrame,
        rareColor: StaticData.PokemonUsers[index].rareColor,
        level: StaticData.PokemonUsers[index].Level,
      ),
    );
  }


  void startAnimation() {
    StaticData.timer = Timer.periodic(Duration(milliseconds: 2000),(test){
      for (int i = 0; i < StaticData.PokemonUsers.length; i++) {
        StaticData.PokemonUsers[i].changeDirection();
      }
      InitPokemonUser();
    });
    StaticData.timer2 = Timer.periodic(Duration(milliseconds:200), (timer) {
      for (int i = 0; i < StaticData.PokemonUsers.length; i++) {
        StaticData.PokemonUsers[i].move();
      }
      InitPokemonUser();
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
                  /*Container(
                    width: size.width*0.25,
                    height: 50,
                    child: Stack(
                      children: [
                        Image.asset('assets/achievenment/ui/thanhtuu.PNG'),
                      ],
                    ),
                  ),*/
                 /* Container(
                      width: size.width*0.25,
                      height: 200,
                      child: IconButton(
                        icon: Image.asset('assets/achievenment/ui/thanhtuu.png'),
                        iconSize: 100,
                        onPressed: () {},
                      )
                  ),*/
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.collections_bookmark),
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

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.shopping_cart),
                            iconSize: 30,
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context){
                                    return ShopScreen();
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
              color: Colors.white,
              child: Stack(
                children: pokemonWidgetList,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void Loading() async {
    String id = StaticData.userID;

    final D = await DbProvider.instance.rawQuery('''
    UPDATE THONGTINNGUOIDUNG 
     SET VANG = 70000;
     WHERE MANGUOIDUNG = '$id'
    ''');

    final updateBonus = await DbProvider.instance.rawQuery('''
    SELECT * FROM THONGTINNGUOIDUNG WHERE MANGUOIDUNG = '$id'
    ''');

    StaticData.Vang = updateBonus[0]['VANG'];

    print(StaticData.Vang);
  }
}

