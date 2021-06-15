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
      ),
    );
  }

  void increaseLevel(int index) {
    int goldLevelUp;
    if (StaticData.PokemonUsers[index].rareColor == Colors.greenAccent) {
      goldLevelUp = 50;
    } else if (StaticData.PokemonUsers[index].rareColor == Colors.blueAccent) {
      goldLevelUp = 200;
    } else if (StaticData.PokemonUsers[index].rareColor ==
        Colors.purpleAccent) {
      goldLevelUp = 800;
    } else if (StaticData.PokemonUsers[index].rareColor == Colors.redAccent) {
      goldLevelUp = 3200;
    }
    if (StaticData.PokemonUsers[index].Level == 100) {
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
                'Down1.png'),
          ),
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

            final k = await DbProvider.instance.rawQuery('''
              UPDATE POKEMON
              SET LEVELPOKEMON = ${StaticData.PokemonUsers[index].Level}
              WHERE MANGUOIDUNG = '${StaticData.userID}' AND MAPOKEMON = '${StaticData.PokemonUsers[index].MaPOKEMON}'
              ''');
            bool isCheckAchiLv50 = false;
            bool isCheckAchiLv100 = false;
            //Nhận thành tựu lv 50
            if (StaticData.PokemonUsers[index].Level == 50) {
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
                  }
                }
              }
            }

            //Nhận thành tựu lv 100
            if (StaticData.PokemonUsers[index].Level == 100) {
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
          image: AssetImage('assets/achievenment/ui/background.png'),
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
                height: size.height * 0.7,
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
    String id = StaticData.userID;

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

    // :v
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
