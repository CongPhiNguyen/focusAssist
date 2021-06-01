import 'package:flutter/material.dart';
import 'package:focus_assist/classes/ClassCardShop.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:focus_assist/pages/achievenment/feature/CardShop.dart';
import 'package:focus_assist/pages/achievenment/feature/design_appbar_shop.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadingDatabase();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isBuy;
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'SHOP',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        height: size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            design_appbar_shop(size: size),
            Container(
              height: size.height * 0.6,
              child: ListView.builder(
                  itemCount: StaticData.EggShop.length,
                  itemBuilder: (context, num) {
                    isBuy = false;
                    for (int i = 0; i < StaticData.EggUser.length; i ++)
                        {
                          if (StaticData.EggShop[num].MaVP == StaticData.EggUser[i].MaVP)
                           { isBuy = true;
                            break;}
                        }
                    return Center(
                      child: card_shop(
                        size: size,
                        name: StaticData.EggShop[num].TenVP,
                        price: StaticData.EggShop[num].Gia,
                        rareColor: StaticData.EggShop[num].rareColor,
                        imageEgg: StaticData.EggShop[num].imageEgg,
                        MAVP: StaticData.EggShop[num].MaVP,
                        isBuy: isBuy,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void LoadingDatabase() async {
    final infoVATPHAM = await DbProvider.instance.query('VATPHAM');
    StaticData.EggShop.clear();
    for (int i = 0; i < infoVATPHAM.length; i++) {
      switch (infoVATPHAM[i]['DOHIEM']) {
        case 1:
          InfoEggs index = new InfoEggs(
              infoVATPHAM[i]['MAVATPHAM'],
              infoVATPHAM[i]['TENVATPHAM'],
              infoVATPHAM[i]['MOTA'],
              infoVATPHAM[i]['GIA'],
              Colors.green,
              'assets/achievenment/Eggs/egg'+infoVATPHAM[i]['TENVATPHAM']+'.png');
          setState(() {
            StaticData.EggShop.add(index);
          });

          break;
        case 2:
          InfoEggs index = new InfoEggs(
              infoVATPHAM[i]['MAVATPHAM'],
              infoVATPHAM[i]['TENVATPHAM'],
              infoVATPHAM[i]['MOTA'],
              infoVATPHAM[i]['GIA'],
              Colors.blueAccent,
              'assets/achievenment/Eggs/egg'+infoVATPHAM[i]['TENVATPHAM']+'.png');
          setState(() {
            StaticData.EggShop.add(index);
          });
          break;
        case 3:
          InfoEggs index = new InfoEggs(
              infoVATPHAM[i]['MAVATPHAM'],
              infoVATPHAM[i]['TENVATPHAM'],
              infoVATPHAM[i]['MOTA'],
              infoVATPHAM[i]['GIA'],
              Colors.purpleAccent,
              'assets/achievenment/Eggs/egg'+infoVATPHAM[i]['TENVATPHAM']+'.png');
          setState(() {
            StaticData.EggShop.add(index);
          });
          break;
        case 4:
          InfoEggs index = new InfoEggs(
              infoVATPHAM[i]['MAVATPHAM'],
              infoVATPHAM[i]['TENVATPHAM'],
              infoVATPHAM[i]['MOTA'],
              infoVATPHAM[i]['GIA'],
              Colors.red,
              'assets/achievenment/Eggs/egg'+infoVATPHAM[i]['TENVATPHAM']+'.png');
          setState(() {
            StaticData.EggShop.add(index);
          });
          break;
        default:
          break;
      }
    }


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
  }
}

