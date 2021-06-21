import 'package:flutter/material.dart';
import 'package:focus_assist/pages/achievenment/feature/star.dart';
import 'CustomCard.dart';

class CardAchievement extends StatefulWidget {
  final String name;
  final String mota;
  final int diemThanhtuu;
  final String iconImage;
  final int star;
  final Color endColor;
  final Color startColor;
  final String imageAchi;

  const CardAchievement(
      {Key key,
      this.name,
      this.mota,
      this.diemThanhtuu,
      this.iconImage,
      this.star,
      this.endColor,
      this.startColor, this.imageAchi})
      : super(key: key);
  @override
  _CardAchievementState createState() => _CardAchievementState(
      name, mota, diemThanhtuu, iconImage, star, endColor, startColor,imageAchi);
}

class _CardAchievementState extends State<CardAchievement> {
  final String name;
  final String mota;
  final int diemThanhtuu;
  final String iconImage;
  final int star;
  final Color endColor;
  final Color startColor;
  final String imageAchi;
  _CardAchievementState(this.name, this.mota, this.diemThanhtuu, this.iconImage,
      this.star, this.endColor, this.startColor, this.imageAchi);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 8,bottom: 8,right: 16,left: 16),
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [startColor, startColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: startColor,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: CustomPaint(
              size: Size(size.height * 0.15, size.width * 0.15),
              painter: CustomCard(24, endColor, startColor),
            ),
          ),
          Positioned.fill(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    'assets/achievenment/achieImage/'+imageAchi+'.png',
                    height: size.height * 0.06,
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
                          color: Colors.purpleAccent,
                          fontSize: size.height * 0.025,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        mota,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Bonus :' + diemThanhtuu.toString() + ' vàng',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size.height * 0.015,
                        ),
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
                          fontSize: size.height * 0.02,
                          fontFamily: 'Avenir',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      RatingStar(
                        Sao: star,
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
