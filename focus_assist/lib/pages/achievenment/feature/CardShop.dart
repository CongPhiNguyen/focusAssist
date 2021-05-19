import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class card_shop extends StatelessWidget {
  final String name;
  final int price;
  final String imageEgg;
  final Color rareColor;
  const card_shop({
    Key key,
    @required this.size, this.name, this.price, this.imageEgg, this.rareColor,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height*0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 1,
                  offset: Offset(0,5),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: size.height*0.03,),
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: rareColor,
                        ),
                      ),
                      SizedBox(height: size.height*0.01,),
                      Text(
                        price.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.overline,
                        ),
                      ),
                      SizedBox(height: size.height*0.01,),
                      Container(
                        height: size.height*0.05,
                        width: size.width*0.2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: FlatButton(
                            color: Colors.green[400],
                            onPressed: (){

                            },
                            child: Text(
                              'Buy',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    imageEgg,
                    height: size.width*0.2,
                    width: size.width*0.2,
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


