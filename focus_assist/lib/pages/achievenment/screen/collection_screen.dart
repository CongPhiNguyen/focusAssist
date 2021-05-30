import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_assist/classes/ClassCardAchievenment.dart';
import 'package:focus_assist/classes/ClassCardShop.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:focus_assist/pages/achievenment/feature/CardCollection.dart';

class CollectionScreen extends StatefulWidget {
  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}



class _CollectionScreenState extends State<CollectionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadingVatPhamUser();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Collection',
        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            height: size.height*0.05,
            width: size.width*0.35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 1,
                  offset: Offset(0,5),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.wallet_giftcard,color: Colors.green,),
                Text(totalMoney().toString() +' dollar',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: Colors.green),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.amber[200],
            ),
            height: size.height*0.7,
            child: DetailCardCollection(size: size),
          ),
        ],
      ),
    );

  }
  void  LoadingVatPhamUser() async {
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


int totalMoney(){
  int totalMoney=0;
  for(int i = 0; i < items.length;i++)
    {
      totalMoney += items[i].diemThanhtuu;
    }
  totalMoney += StaticData.Vang;
  return totalMoney;
}



