import 'package:flutter/material.dart';
import 'package:focus_assist/pages/achievenment/screen/collection_screen.dart';


class design_appbar_shop extends StatelessWidget {
  const design_appbar_shop({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

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
                Positioned(
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
                SizedBox(width: size.width * 0.2,),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.amber[600],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    icon: Image.asset('assets/achievenment/ui/treasure.png'),
                    iconSize: 30,
                    onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context){return CollectionScreen();}));},
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
