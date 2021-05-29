
import 'package:flutter/material.dart';

import 'package:focus_assist/classes/ClassCardShop.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DetailCardCollection extends StatelessWidget {
  const DetailCardCollection({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      padding: EdgeInsets.all(5),
      children: List.generate(StaticData.EggUser.length, (index) {
        return Center(
          child: Container(
            margin: EdgeInsets.only(top:3,bottom: 3,left: 6,right: 6),
            width: size.width*0.4,
            decoration: BoxDecoration(
              color: Colors.amber[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                   // child: Image.asset(value[index].imageEgg),
                    child: Image.asset(StaticData.EggUser[index].imageEgg),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      StaticData.EggUser[index].TenVP,
                      style: TextStyle(color: StaticData.EggUser[index].rareColor,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.search,size: 20 ,),
                    padding: EdgeInsets.only(bottom: 20),
                    onPressed:(){
                      _show(
                          context,
                          StaticData.EggUser[index].TenVP,
                          StaticData.EggUser[index].rareColor,
                          StaticData.EggUser[index].Gia,
                          StaticData.EggUser[index].imageEgg,
                          StaticData.EggUser[index].moTa,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}


void _show(context, String name, Color rareColor,int price, String imageEgg, String mota){
  Alert(
    context: context,
    title: 'Information',
    closeIcon: Icon(Icons.info_outlined),
    desc: 'Đã sở hữu',
    content: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(name,style: TextStyle(color: rareColor),),
        Image.asset(imageEgg),
        Text('Mô tả :'+mota),
        Text('Price: ' + price.toString(),),
      ],
    ),
    buttons: [
      DialogButton(
        child: Text(
          "ACCEPT",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}


