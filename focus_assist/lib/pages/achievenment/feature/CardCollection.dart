
import 'package:flutter/material.dart';
import 'package:focus_assist/classes/ClassCardShop.dart';
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
      children: List.generate(value.length, (index) {
        return Center(
          child: Container(
            margin: EdgeInsets.only(top:3,bottom: 3,left: 6,right: 6),
            width: size.width*0.4,
            decoration: BoxDecoration(
              /*image: new DecorationImage(
                 image: AssetImage('assets/collection/UI_collection_background.png'),
                 fit: BoxFit.fill,
              ),*/
              color: Colors.amber[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Image.asset(value[index].imageEgg),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text(
                      value[index].name,
                      style: TextStyle(color: value[index].rareColor,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.search,size: 20 ,),
                    padding: EdgeInsets.only(bottom: 20),
                    onPressed:(){},
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
