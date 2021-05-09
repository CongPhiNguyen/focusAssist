import 'package:flutter/material.dart';

class PlaceInfo{
  final String name;
  final int diemThanhtuu;
  final String image;
  final int star;
  final Color startColor;
  final Color endColor;


  PlaceInfo(this.name,
      this.diemThanhtuu,
      this.star,
      this.image,
      this.startColor,
      this.endColor);
}

final  List<PlaceInfo> items = [
  PlaceInfo('Rong 3 sao',15,3,'assets/achievenment/achieImage/dragon3.png',Colors.yellow,Colors.yellow[600]),
  PlaceInfo('Rong 2 sao',10,2,'assets/achievenment/achieImage/dragon2.png',Colors.brown[300],Colors.brown[400]),
  PlaceInfo('Rong 1 sao',5,1,'assets/achievenment/achieImage/dragon1.png',Colors.brown[300],Colors.brown[400]),
  PlaceInfo('Tap trung 5s',5,1,'assets/achievenment/achieImage/clock.png',Colors.grey[200],Colors.grey[200]),
  PlaceInfo('Tap trung 10s',10,2,'assets/achievenment/achieImage/clock.png',Colors.grey[200],Colors.grey[200]),
  PlaceInfo('Tap trung 15s',15,3,'assets/achievenment/achieImage/clock.png',Colors.yellow,Colors.yellow[600]),
  PlaceInfo('Rong 3 sao',15,3,'assets/achievenment/achieImage/dragon3.png',Colors.yellow,Colors.yellow[600]),
  PlaceInfo('Rong 2 sao',10,2,'assets/achievenment/achieImage/dragon2.png',Colors.brown[300],Colors.brown[400]),
  PlaceInfo('Rong 1 sao',5,1,'assets/achievenment/achieImage/dragon1.png',Colors.brown[300],Colors.brown[400]),
  PlaceInfo('Tap trung 5s',5,1,'assets/achievenment/achieImage/clock.png',Colors.grey[200],Colors.grey[200]),
  PlaceInfo('Tap trung 10s',10,2,'assets/achievenment/achieImage/clock.png',Colors.grey[200],Colors.grey[200]),
  PlaceInfo('Tap trung 15s',15,3,'assets/achievenment/achieImage/clock.png',Colors.yellow,Colors.yellow[600]),
];
