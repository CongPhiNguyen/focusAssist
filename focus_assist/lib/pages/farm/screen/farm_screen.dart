import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_assist/classes/ClassCardAchievenment.dart';
import 'package:focus_assist/classes/ClassPokemon.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:focus_assist/pages/achievenment/screen/achievenment_screen.dart';
import 'package:focus_assist/pages/achievenment/screen/collection_screen.dart';
import 'package:focus_assist/pages/achievenment/screen/shop_screen.dart';
import 'package:focus_assist/pages/farm/feature_ui/object_farm.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../classes/Data.dart';

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

  void InitPokemonUser() {
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
      alignment: Alignment(StaticData.PokemonUsers[index].positionX,
          StaticData.PokemonUsers[index].positionY),
      child: Pokemon(
        name: StaticData.PokemonUsers[index].TenPokemon,
        snailDirection: StaticData.PokemonUsers[index].direction,
        snailSpriteCount: StaticData.PokemonUsers[index].currentFrame,
        rareColor: StaticData.PokemonUsers[index].rareColor,
        level: StaticData.PokemonUsers[index].Level,
        press: () {
          increaseLevel(index);
        },
        longPress: () {
          deletePokemon(context, index);
        },
      ),
    );
  }

  void deletePokemon(context, int index) {
    int rank = 1;
    if (StaticData.PokemonUsers[index].Level >= 24 &&
        StaticData.PokemonUsers[index].Level < 50 &&
        StaticData.PokemonUsers[index].rareColor == Colors.redAccent) {
      rank = 2;
    }
    if (StaticData.PokemonUsers[index].Level >= 49 &&
        StaticData.PokemonUsers[index].rareColor == Colors.redAccent) {
      rank = 3;
    }

    double price = 0;
    if(StaticData.PokemonUsers[index].rareColor == Colors.greenAccent){
      price = ((100 + (5*StaticData.PokemonUsers[index].Level))*30/100);
    }
    if(StaticData.PokemonUsers[index].rareColor == Colors.blueAccent){
      price = ((200 + (10*StaticData.PokemonUsers[index].Level))*30/100);
    }
    if(StaticData.PokemonUsers[index].rareColor == Colors.purpleAccent){
      price = ((350 + (15*StaticData.PokemonUsers[index].Level))*30/100);
    }
    if(StaticData.PokemonUsers[index].rareColor == Colors.redAccent){
      price = ((500 + (20*StaticData.PokemonUsers[index].Level))*30/100);
    }



    Alert(
        context: context,
        title: 'SELL POKEMON',
        closeIcon: Icon(Icons.auto_awesome),
        desc: "Do you want to sell this pokemon with ${price.toInt()} gold?",
        content: Column(
          children: [
            Center(
              child: Text(
                StaticData.PokemonUsers[index].TenPokemon,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: StaticData.PokemonUsers[index].rareColor,
                ),
              ),
            ),
            Center(
              child: Image.asset('assets/achievenment/move/' +
                  StaticData.PokemonUsers[index].TenPokemon +
                  rank.toString() +
                  'Down1.png'),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            child: Text(
              "SELL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () async {
              await DbProvider.instance.rawQuery('''
            DELETE FROM POKEMON
            WHERE MAPOKEMON = '${StaticData.PokemonUsers[index].MaPOKEMON}' AND MANGUOIDUNG = '${StaticData.userID}'
            ''');

              setState(() {
                StaticData.Vang += price.toInt();
                StaticData.PokemonUsers.removeAt(index);
              });

              await DbProvider.instance.rawQuery('''
              UPDATE THONGTINNGUOIDUNG
              SET VANG = ${StaticData.Vang}
              WHERE MANGUOIDUNG = '${StaticData.userID}'
              ''');

              Navigator.pop(context);
            },
            color: Colors.redAccent,
          ),
          DialogButton(
            child: Text(
              "CANCEL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(116, 116, 191, 1.0),
              Color.fromRGBO(52, 138, 199, 1.0)
            ]),
          )
        ]).show();
  }

  void increaseLevel(int index) {
    int goldLevelUp;
    if (StaticData.PokemonUsers[index].rareColor == Colors.greenAccent) {
      goldLevelUp = 5;
    } else if (StaticData.PokemonUsers[index].rareColor == Colors.blueAccent) {
      goldLevelUp = 10;
    } else if (StaticData.PokemonUsers[index].rareColor ==
        Colors.purpleAccent) {
      goldLevelUp = 15;
    } else if (StaticData.PokemonUsers[index].rareColor == Colors.redAccent) {
      goldLevelUp = 20;
    }
    if (StaticData.PokemonUsers[index].Level >= 50) {
      showFail(context, index, goldLevelUp, "Your pokemon has been max level");
    } else if (goldLevelUp > StaticData.Vang) {
      showFail(
          context,
          index,
          goldLevelUp,
          "You don't have enough " +
              goldLevelUp.toString() +
              ' gold to LevelUp');
    } else {
      showSuccess(context, index, goldLevelUp);
    }
  }

  void showFail(context, int index, int goldLevelUp, String message) {
    int rank = 1;
    if (StaticData.PokemonUsers[index].Level >= 24 &&
        StaticData.PokemonUsers[index].Level < 50 &&
        StaticData.PokemonUsers[index].rareColor == Colors.redAccent) {
      rank = 2;
    }
    if (StaticData.PokemonUsers[index].Level >= 49 &&
        StaticData.PokemonUsers[index].rareColor == Colors.redAccent) {
      rank = 3;
    }

    Alert(
      context: context,
      title: 'LEVEL UP',
      closeIcon: Icon(Icons.auto_awesome),
      desc: message,
      content: Column(
        children: [
          Center(
            child: Text(
              StaticData.PokemonUsers[index].TenPokemon,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: StaticData.PokemonUsers[index].rareColor,
              ),
            ),
          ),
          Center(
              child: Image.asset('assets/achievenment/move/' +
                  StaticData.PokemonUsers[index].TenPokemon +
                  '$rank' +
                  'Down1.png')),
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
          color: Colors.blue,
        )
      ],
    ).show();
  }

  void showSuccess(context, int index, int goldLevelUp) {
    int rank = 1;
    if (StaticData.PokemonUsers[index].Level >= 24 &&
        StaticData.PokemonUsers[index].Level < 50 &&
        StaticData.PokemonUsers[index].rareColor == Colors.redAccent) {
      rank = 2;
    }
    if (StaticData.PokemonUsers[index].Level >= 49 &&
        StaticData.PokemonUsers[index].rareColor == Colors.redAccent) {
      rank = 3;
    }
    Alert(
      context: context,
      title: 'LEVEL UP',
      closeIcon: Icon(Icons.auto_awesome),
      desc: "Use " + goldLevelUp.toString() + ' gold to LevelUp',
      content: Column(
        children: [
          Center(
            child: Text(
              StaticData.PokemonUsers[index].TenPokemon,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: StaticData.PokemonUsers[index].rareColor,
              ),
            ),
          ),
          Center(
            child: Image.asset('assets/achievenment/move/' +
                StaticData.PokemonUsers[index].TenPokemon +
                "$rank" +
                'Down1.png'),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "LevelUp",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            StaticData.PokemonUsers[index].Level += 1;
            setState(() {
              StaticData.Vang -= goldLevelUp;
            });
            final k = await DbProvider.instance.rawQuery('''
              UPDATE POKEMON
              SET LEVELPOKEMON = ${StaticData.PokemonUsers[index].Level}
              WHERE MANGUOIDUNG = '${StaticData.userID}' AND MAPOKEMON = '${StaticData.PokemonUsers[index].MaPOKEMON}'
              ''');
            final t = await DbProvider.instance.rawQuery('''
                    UPDATE THONGTINNGUOIDUNG
                    SET VANG = ${StaticData.Vang}
                    WHERE MANGUOIDUNG = '${StaticData.userID}'
                    ''');
            bool isCheckAchiLv50 = false;
            bool isCheckAchiLv100 = false;
            //Nhận thành tựu lv 25
            if (StaticData.PokemonUsers[index].Level == 25) {
              //Kiểm có thành tựu lv 50 hay chưa
              for (int i = 0; i < StaticData.AchiUser.length; i++) {
                if (StaticData.AchiUser[i].MOTA ==
                    '${StaticData.PokemonUsers[index].TenPokemon} level ${StaticData.PokemonUsers[index].Level.toString()}') {
                  isCheckAchiLv50 = true;
                }
              }
              //Thêm thành tựu
              if (isCheckAchiLv50 == false) {
                for (int i = 0; i < StaticData.AchiList.length; i++) {
                  if (StaticData.AchiList[i].MOTA ==
                      '${StaticData.PokemonUsers[index].TenPokemon} level ${StaticData.PokemonUsers[index].Level.toString()}') {
                    StaticData.AchiUser.add(StaticData.AchiList[i]);
                    StaticData.Vang += StaticData.AchiList[i].bonus;

                    final row = {
                      'MATHANHTUU': StaticData.AchiList[i].MATHANHTUU,
                      'MANGUOIDUNG': StaticData.userID
                    };
                    int e = await DbProvider.instance
                        .insert('THANHTUUNGUOIDUNG', row);

                    final k = await DbProvider.instance.rawQuery('''
                    UPDATE THONGTINNGUOIDUNG
                    SET VANG = ${StaticData.Vang}
                    WHERE MANGUOIDUNG = '${StaticData.userID}'
                    ''');
                    if (StaticData.PokemonUsers[index].rareColor ==
                        Colors.redAccent) {
                      Navigator.pop(context);
                      receiveAchi(
                          context,
                          "Evolved and received ${StaticData.AchiList[i].bonus} bonus gold!",
                          index);
                      return;
                    } else {
                      Navigator.pop(context);
                      receiveAchi(
                          context,
                          "Your pokemon has reached lv 25 and received ${StaticData.AchiList[i].bonus} bonus gold",
                          index);
                      return;
                    }
                  }
                }
              }
            }
            //  receiveAchi(context, "Bạn nhận đạt được thành tựu lv 25 và được bonus ${StaticData.AchiList[index].bonus}", index);
            //Nhận thành tựu lv 50
            if (StaticData.PokemonUsers[index].Level == 50) {
              //Kiểm có thành tựu lv 100 hay chưa
              for (int i = 0; i < StaticData.AchiUser.length; i++) {
                if (StaticData.AchiUser[i].MOTA ==
                    '${StaticData.PokemonUsers[index].TenPokemon} level ${StaticData.PokemonUsers[index].Level.toString()}') {
                  isCheckAchiLv100 = true;
                }
              }
              //Thêm thành tựu
              if (isCheckAchiLv100 == false) {
                for (int i = 0; i < StaticData.AchiList.length; i++) {
                  if (StaticData.AchiList[i].MOTA ==
                      '${StaticData.PokemonUsers[index].TenPokemon} level ${StaticData.PokemonUsers[index].Level.toString()}') {
                    StaticData.AchiUser.add(StaticData.AchiList[i]);
                    StaticData.Vang += StaticData.AchiList[i].bonus;

                    final row = {
                      'MATHANHTUU': StaticData.AchiList[i].MATHANHTUU,
                      'MANGUOIDUNG': StaticData.userID
                    };
                    int e = await DbProvider.instance
                        .insert('THANHTUUNGUOIDUNG', row);

                    final k = await DbProvider.instance.rawQuery('''
                    UPDATE THONGTINNGUOIDUNG
                    SET VANG = ${StaticData.Vang}
                    WHERE MANGUOIDUNG = '${StaticData.userID}'
                    ''');

                    if (StaticData.PokemonUsers[index].rareColor ==
                        Colors.redAccent) {
                      Navigator.pop(context);
                      receiveAchi(
                          context,
                          "Evolved and received and ${StaticData.AchiList[i].bonus} bonus gold",
                          index);
                      return;
                    } else {
                      Navigator.pop(context);
                      receiveAchi(
                          context,
                          "Your pokemon has reached lv 50 and received ${StaticData.AchiList[i].bonus} bonus gold",
                          index);
                      return;
                    }
                  }
                }
              }
            }

            Navigator.pop(context);
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  void startAnimation() {
    StaticData.timer = Timer.periodic(Duration(milliseconds: 2000), (test) {
      for (int i = 0; i < StaticData.PokemonUsers.length; i++) {
        StaticData.PokemonUsers[i].changeDirection();
      }
      InitPokemonUser();
    });
    StaticData.timer2 = Timer.periodic(Duration(milliseconds: 200), (timer) {
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
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          // image: AssetImage('assets/achievenment/ui/background.png'),
          image: (!StaticData.isDarkMode)
              ? AssetImage('assets/achievenment/ui/background.png')
              : AssetImage('assets/achievenment/ui/background_darkmode.jpg'),
          fit: BoxFit.fill,
        )),
        child: Center(
          child: Column(
            children: [
              Container(
                height: size.height * 0.2,
                child: Row(
                  children: [
                    Container(
                      width: size.width * 0.25,
                      height: size.height * 0.1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return AchievenmentScreen();
                              },
                            ),
                          );
                        },
                        child:
                            Image.asset('assets/achievenment/ui/thanhtuu.PNG'),
                      ),
                    ),
                    Container(
                      width: size.width * 0.5,
                      height: size.height * 0.2,
                      alignment: Alignment.center,
                      child: Image.asset('assets/achievenment/ui/nongtrai.png'),
                    ),
                    Container(
                      width: size.width * 0.25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: size.width * 0.25,
                            height: size.height * 0.1,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CollectionScreen();
                                    },
                                  ),
                                );
                              },
                              child:
                                  Image.asset('assets/achievenment/ui/tui.PNG'),
                            ),
                          ),
                          Container(
                            width: size.width * 0.25,
                            height: size.height * 0.1,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ShopScreen();
                                    },
                                  ),
                                );
                              },
                              child: Image.asset(
                                  'assets/achievenment/ui/cuahang.PNG'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: size.height * 0.035,
                      child: Image.asset('assets/gold.png'),
                    ),
                    // Icon(Icons.wallet_giftcard,color: Colors.green,),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      StaticData.Vang.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: (!StaticData.isDarkMode)
                              ? Colors.grey[100]
                              : Colors.grey[300]),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height * 0.65,
                child: Stack(
                  children: pokemonWidgetList,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void Loading() async {

    // await DbProvider.instance.rawQuery('''
    //     UPDATE THONGTINNGUOIDUNG
    //     SET VANG = 5000
    //     WHERE MANGUOIDUNG = '${StaticData.userID}';
    //     ''');

    StaticData.EggUser.clear();
    String id = StaticData.userID;
    final k = await DbProvider.instance.rawQuery('''
      select * from VATPHAMNGUOIDUNG where MANGUOIDUNG = '$id'
      ''');

    for (int i = 0; i < k.length; i++) {
      for (int j = 0; j < StaticData.EggShop.length; j++) {
        if (StaticData.EggShop[j].MaVP == k[i]['MAVATPHAM']) {
          setState(() {
            StaticData.EggUser.add(StaticData.EggShop[j]);
          });
        }
      }
    }

    final ListPokemon = await DbProvider.instance.rawQuery('''
    SELECT * FROM POKEMON WHERE MANGUOIDUNG = '$id'
    ''');
    StaticData.PokemonUsers.clear();

    for (int i = 0; i < ListPokemon.length; i++) {
      switch (ListPokemon[i]['DOHIEM']) {
        case 1:
          InfoPokemon index = new InfoPokemon(
            ListPokemon[i]['MAPOKEMON'],
            ListPokemon[i]['NAMEPOKEMON'],
            ListPokemon[i]['LEVELPOKEMON'],
            Colors.greenAccent,
          );
          index.randomDirecAndPos();
          setState(() {
            StaticData.PokemonUsers.add(index);
          });
          break;

        case 2:
          InfoPokemon index = new InfoPokemon(
            ListPokemon[i]['MAPOKEMON'],
            ListPokemon[i]['NAMEPOKEMON'],
            ListPokemon[i]['LEVELPOKEMON'],
            Colors.blueAccent,
          );
          index.randomDirecAndPos();
          setState(() {
            StaticData.PokemonUsers.add(index);
          });
          break;

        case 3:
          InfoPokemon index = new InfoPokemon(
            ListPokemon[i]['MAPOKEMON'],
            ListPokemon[i]['NAMEPOKEMON'],
            ListPokemon[i]['LEVELPOKEMON'],
            Colors.purpleAccent,
          );
          index.randomDirecAndPos();
          setState(() {
            StaticData.PokemonUsers.add(index);
          });
          break;

        case 4:
          InfoPokemon index = new InfoPokemon(
            ListPokemon[i]['MAPOKEMON'],
            ListPokemon[i]['NAMEPOKEMON'],
            ListPokemon[i]['LEVELPOKEMON'],
            Colors.redAccent,
          );
          index.randomDirecAndPos();
          setState(() {
            StaticData.PokemonUsers.add(index);
          });
          break;

        default:
          break;
      }
    }

    // final D = await DbProvider.instance.rawQuery('''
    // UPDATE THONGTINNGUOIDUNG
    //  SET VANG = 70000;
    //  WHERE MANGUOIDUNG = '$id'
    // ''');

    final updateBonus = await DbProvider.instance.rawQuery('''
    SELECT * FROM THONGTINNGUOIDUNG WHERE MANGUOIDUNG = '$id'
    ''');

    StaticData.Vang = updateBonus[0]['VANG'];

    print(StaticData.Vang);

    final ListAchie = await DbProvider.instance.query('THANHTUU');
    StaticData.AchiList.clear();
    StaticData.AchiUser.clear();
    for (int i = 0; i < ListAchie.length; i++) {
      switch (ListAchie[i]['CAPDO']) {
        case 1:
          Achievenment index = new Achievenment(
            ListAchie[i]['MATHANHTUU'],
            ListAchie[i]['TENTHANHTUU'],
            ListAchie[i]['MOTA'],
            ListAchie[i]['CAPDO'],
            ListAchie[i]['VANG'],
            Colors.brown[300],
            Colors.brown[400],
          );
          setState(() {
            StaticData.AchiList.add(index);
          });
          break;

        case 2:
          Achievenment index = new Achievenment(
            ListAchie[i]['MATHANHTUU'],
            ListAchie[i]['TENTHANHTUU'],
            ListAchie[i]['MOTA'],
            ListAchie[i]['CAPDO'],
            ListAchie[i]['VANG'],
            Colors.grey[200],
            Colors.grey[200],
          );
          setState(() {
            StaticData.AchiList.add(index);
          });
          break;

        case 3:
          Achievenment index = new Achievenment(
            ListAchie[i]['MATHANHTUU'],
            ListAchie[i]['TENTHANHTUU'],
            ListAchie[i]['MOTA'],
            ListAchie[i]['CAPDO'],
            ListAchie[i]['VANG'],
            Colors.yellow,
            Colors.yellow[600],
          );
          setState(() {
            StaticData.AchiList.add(index);
          });
          break;
        default:
          break;
      }
    }

    final user = await DbProvider.instance.rawQuery('''
      SELECT * FROM THANHTUUNGUOIDUNG WHERE MANGUOIDUNG = '$id'
      ''');

    for (int i = 0; i < StaticData.AchiList.length; i++) {
      for (int j = 0; j < user.length; j++) {
        if (StaticData.AchiList[i].MATHANHTUU == user[j]['MATHANHTUU']) {
          setState(() {
            StaticData.AchiUser.add(StaticData.AchiList[i]);
          });
        }
      }
    }
  }
}

void receiveAchi(context, String message, int index) {
  int rank = 1;
  if (StaticData.PokemonUsers[index].Level >= 24 &&
      StaticData.PokemonUsers[index].Level < 50 &&
      StaticData.PokemonUsers[index].rareColor == Colors.redAccent) {
    rank = 2;
  }
  if (StaticData.PokemonUsers[index].Level >= 49 &&
      StaticData.PokemonUsers[index].rareColor == Colors.redAccent) {
    rank = 3;
  }

  Alert(
      context: context,
      title: 'Achievenment',
      closeIcon: Icon(Icons.auto_awesome),
      desc: message,
      content: Column(
        children: [
          Center(
            child: Text(
              StaticData.PokemonUsers[index].TenPokemon,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: StaticData.PokemonUsers[index].rareColor,
              ),
            ),
          ),
          Center(
            child: Image.asset('assets/achievenment/move/' +
                StaticData.PokemonUsers[index].TenPokemon +
                rank.toString() +
                'Down1.png'),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "ACCEPT",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ]).show();
}
