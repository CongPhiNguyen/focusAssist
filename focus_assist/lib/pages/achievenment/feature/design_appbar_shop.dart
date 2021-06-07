import 'package:flutter/material.dart';
import 'package:focus_assist/classes/Data.dart';


class design_appbar_shop extends StatefulWidget {
  final Size size;

  const design_appbar_shop({Key key, this.size}) : super(key: key);
  @override
  _design_appbar_shopState createState() => _design_appbar_shopState(size);
}

class _design_appbar_shopState extends State<design_appbar_shop> {
  final Size size;
  int vang;
  _design_appbar_shopState(this.size);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      vang =StaticData.Vang;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
          ),
          Positioned(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'assets/achievenment/ui/UI_shop_volumn.png',
                    width: size.width*0.2,
                    height: size.height*0.13,
                  ),
                ),
                Text(
                  'Hi! Welcome shopping',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: size.width * 0.05,),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.amber[600],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.wallet_giftcard,color: Colors.green,),
                      Text(StaticData.Vang.toString() +' dollar',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
