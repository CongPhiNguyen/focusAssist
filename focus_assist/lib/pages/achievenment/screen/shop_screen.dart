import 'package:flutter/material.dart';
import 'package:focus_assist/classes/ClassCardShop.dart';
import 'package:focus_assist/pages/achievenment/feature/CardShop.dart';
import 'package:focus_assist/pages/achievenment/feature/design_appbar_shop.dart';



class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.amber,

        elevation: 0,
        centerTitle: true,
        title: Text(
          'SHOP',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),
        ),
      ),
      body: Column(
        children: <Widget>[
          design_appbar_shop(size: size),
          Container(
            height: size.height*0.65,
            child: ListView.builder(
                itemCount: value.length,
                itemBuilder: (context,num) {
                  return Center(
                    child: card_shop(
                      size: size,
                      name: value[num].name,
                      price: value[num].price,
                      rareColor: value[num].rareColor,
                      imageEgg: value[num].imageEgg,
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}

