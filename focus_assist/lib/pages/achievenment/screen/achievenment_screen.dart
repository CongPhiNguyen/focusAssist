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
    Loading();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.amber[300],
      backgroundColor: (!StaticData.isDarkMode)?Colors.amber[300]:Colors.grey[900],
      body: Column(
         children: <Widget>[
           Padding(
             padding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
             child: Container(
               height: size.height*0.07,
               child: Row(
                 children: [
                   Container(
                     // color: Colors.white,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15),
                       color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[800],
                     ),
                     child: IconButton(
                       icon: Icon(Icons.arrow_back),
                       onPressed: (){
                         Navigator.pop(context);
                       },
                     ),
                   ),
                   SizedBox(
                     width: size.width*0.14,
                   ),
                   Text(
                     'Achievenment',
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 25,
                       color: (!StaticData.isDarkMode)?Colors.grey[800]:Colors.grey[300],
                     ),
                   ),
                 ],
               ),
             ),
           ),
           Padding(
             padding: EdgeInsets.only(left: 15,right: 15),
             child: Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(25),
                 color: (!StaticData.isDarkMode)?Colors.amber[100]:Colors.grey[800],
               ),
               height: size.height*0.85,
               child: ListView.builder(
                   itemCount: StaticData.AchiUser.length,
                   itemBuilder: (context, num) {
                     return Center(
                       child: CardAchievement(
                         name: StaticData.AchiUser[num].TENTHANHTUU,
                         mota: StaticData.AchiUser[num].MOTA,
                         diemThanhtuu: StaticData.AchiUser[num].bonus,
                         star: StaticData.AchiUser[num].star,
                         endColor: StaticData.AchiUser[num].endColor,
                         startColor: StaticData.AchiUser[num].startColor,
                         imageAchi: StaticData.AchiUser[num].MATHANHTUU,
                       ),
                     );
                   }),
             ),
           ),
         ],
      ),
    );
  }

  void LoadingAchievenment() async {
    final ListAchie = await DbProvider.instance.query('THANHTUU');
    String id = StaticData.userID;
    StaticData.AchiList.clear();
    StaticData.AchiUser.clear();
    for (int i = 0; i < ListAchie.length; i++) {
      switch (ListAchie[i]['CAPDO']) {
        case 1:
          Achievenment index = new Achievenment(
            ListAchie[i]['MATHANHTUU'],
            ListAchie[i]['TENTHANHTUU'],
            ListAchie[i]['MOTA'] == null ? '' : ListAchie[i]['MOTA'],
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
            ListAchie[i]['MOTA'] == null ? '' : ListAchie[i]['MOTA'],
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
            ListAchie[i]['MOTA'] == null ? '' : ListAchie[i]['MOTA'],
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

  void Loading() async {
    StaticData.EggUser.clear();
    String id = StaticData.userID;
    final k = await DbProvider.instance.rawQuery('''
      select * from VATPHAMNGUOIDUNG where MANGUOIDUNG = '$id'
      '''
    );


    for (int i = 0 ; i < k.length; i++)
    {
      for (int j = 0; j < StaticData.EggShop.length; j++ )
      {
        if(StaticData.EggShop[j].MaVP == k[i]['MAVATPHAM'])
        {
          setState(() {
            StaticData.EggUser.add(StaticData.EggShop[j]);
          });
        }
      }
    }

    StaticData.EggUser.clear();

    await DbProvider.instance.rawQuery('''
                                select * from VATPHAMNGUOIDUNG where MANGUOIDUNG = '$id'
                                ''');


    for (int i = 0; i < k.length; i++) {
      for (int j = 0; j < StaticData.EggShop.length; j++) {
        if (StaticData.EggShop[j].MaVP == k[i]['MAVATPHAM']) {
          StaticData.EggUser.add(StaticData.EggShop[j]);
        }
      }
    }

  }
}
