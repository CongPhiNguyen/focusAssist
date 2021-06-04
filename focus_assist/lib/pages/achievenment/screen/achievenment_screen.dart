import 'package:flutter/material.dart';
import 'package:focus_assist/classes/ClassCardAchievenment.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:focus_assist/pages/achievenment/feature/CardAchievenment.dart';
import 'package:focus_assist/pages/achievenment/screen/shop_screen.dart';

import 'collection_screen.dart';



class AchievenmentScreen extends StatefulWidget {
  final double totalMoney = 0;
  @override
  _AchievenmentScreenState createState() => _AchievenmentScreenState();
}


class _AchievenmentScreenState extends State<AchievenmentScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadingAchievenment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.amber,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.collections_sharp,
              color: Colors.black,
            ),

            onPressed: ()async{
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context){
                      return CollectionScreen();
                    }
                )
              );
            },
          ),

          IconButton(
            icon: Icon(Icons.shopping_cart_rounded,color: Colors.black,),
            onPressed: () async {
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
        ],
        centerTitle: true,
        title: Text(
          'Achievement',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),
        ),
      ),
      body: ListView.builder(
          itemCount: StaticData.AchiUser.length,
          itemBuilder: (context,num) {
            return  Center(
              child: CardAchievement(
                name: StaticData.AchiUser[num].TENTHANHTUU,
                mota: StaticData.AchiUser[num].MOTA,
                diemThanhtuu: StaticData.AchiUser[num].bonus,
                star: StaticData.AchiUser[num].star,
                endColor: StaticData.AchiUser[num].endColor,
                startColor: StaticData.AchiUser[num].startColor,
              ),
            );
          }
      ),
    );
  }

  void  LoadingAchievenment() async{
      final ListAchie = await DbProvider.instance.query('THANHTUU');
      String id = StaticData.userID;
      StaticData.AchiList.clear();
      StaticData.AchiUser.clear();
      for (int i = 0; i < ListAchie.length; i++)
        {
          switch(ListAchie[i]['CAPDO'])
          {
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

      for(int i = 0; i < StaticData.AchiList.length; i++){
        for(int j = 0; j < user.length;j++) {
            if(StaticData.AchiList[i].MATHANHTUU == user[j]['MATHANHTUU'])
              {
                setState(() {
                  StaticData.AchiUser.add(StaticData.AchiList[i]);
                });
              }
          }
      }
  }

  void Loading() async {
    StaticData.EggUser.clear();
    String id = StaticData.userID;
    final k = await DbProvider.instance.rawQuery('''
                                select * from VATPHAMNGUOIDUNG where MANGUOIDUNG = '$id'
                                '''
    );
    if (k.length ==0) print ("null");
    k.forEach(print);

    for (int i = 0 ; i < k.length; i++)
    {
      for (int j = 0; j < StaticData.EggShop.length; j++ )
      {
        if(StaticData.EggShop[j].MaVP == k[i]['MAVATPHAM'])
        {
          StaticData.EggUser.add(StaticData.EggShop[j]);
        }
      }
    }

    final updateBonus = await DbProvider.instance.rawQuery('''
    SELECT * FROM THONGTINNGUOIDUNG WHERE MANGUOIDUNG = '$id'
    ''');

    StaticData.Vang = updateBonus[0]['VANG'];
  }
}

