import 'package:flutter/material.dart';
import 'package:focus_assist/classes/ClassCardAchievenment.dart';
import 'package:focus_assist/pages/achievenment/feature/CardAchievenment.dart';
import 'package:focus_assist/pages/achievenment/screen/shop_screen.dart';



class AchievenmentScreen extends StatefulWidget {
  @override
  _AchievenmentScreenState createState() => _AchievenmentScreenState();
}

class _AchievenmentScreenState extends State<AchievenmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.amber,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart_rounded,color: Colors.black,),
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context){return ShopScreen();}));},

          ),
        ],
        centerTitle: true,
        title: Text(
          'Achievement',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),
        ),
      ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context,num) {
            return  Center(
              child: CardAchievement(
                name: items[num].name,
                iconImage: items[num].image,
                diemThanhtuu: 15,
                star: items[num].star,
                endColor: items[num].endColor,
                startColor: items[num].startColor,
              ),
            );
          }
      ),
    );
  }
}

