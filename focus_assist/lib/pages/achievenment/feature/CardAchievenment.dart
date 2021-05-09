import 'package:flutter/material.dart';
import 'package:focus_assist/pages/achievenment/feature/star.dart';
import 'CustomCard.dart';

//import 'PaintRight.dart';

class CardAchievement extends StatelessWidget {
  final String name;
  final int diemThanhtuu;
  final String iconImage;
  final int star;
  final Color endColor;
  final Color startColor;
  const CardAchievement({
    Key key, this.name, this.iconImage, this.diemThanhtuu, this.star, this.endColor, this.startColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [startColor,startColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: startColor,
                  blurRadius: 5,
                  offset: Offset(0,2),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: CustomPaint(
              size: Size(100,150),
              painter: CustomCard(24,endColor,startColor),
            ),
          ),
          Positioned.fill(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    iconImage,
                    height: 30,
                    width: 30,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,),
                      ),

                      Text(
                        'Bạn được cộng '+ diemThanhtuu.toString() +' điểm',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,),
                      ),

                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        star.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Avenir',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      RatingStar(Sao: star,),

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



