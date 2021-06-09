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


class Achievenment{
  final String MATHANHTUU;
  final String TENTHANHTUU;
  final String MOTA;
  final int star;
  final Color startColor;
  final Color endColor;
  final int bonus;

  Achievenment(
      this.MATHANHTUU,
      this.TENTHANHTUU,
      this.MOTA, this.star
      , this.bonus,
      this.startColor,
      this.endColor);
}

final List<Achievenment> listAchievenment = [
  Achievenment('TT01', 'Blue', 'Trứng Blue', 1, 200, Colors.brown[300],Colors.brown[400]),
  Achievenment('TT02', 'Carpentry', 'Trứng Carpentry', 1, 200, Colors.brown[300],Colors.brown[400]),
  Achievenment('TT03', 'Cheese', 'Trứng Cheese', 1, 200, Colors.brown[300],Colors.brown[400]),
  Achievenment('TT04', 'Chocolate', 'Trứng Chocolate', 1, 200, Colors.brown[300],Colors.brown[400]),
  Achievenment('TT05', 'Cream', 'Trứng Cream', 1, 200, Colors.brown[300],Colors.brown[400]),
  Achievenment('TT06', 'DeepBlue', 'Trứng DeepBlue', 1, 200, Colors.brown[300],Colors.brown[400]),
  Achievenment('TT07', 'Demon', 'Trứng Demon', 1, 200, Colors.brown[300],Colors.brown[400]),
  Achievenment('TT08', 'Diamod', 'Trứng Diamod', 1, 200, Colors.brown[300],Colors.brown[400]),
  Achievenment('TT09', 'Electric', 'Trứng Electric', 1, 200, Colors.brown[300],Colors.brown[400]),
  Achievenment('TT10', 'Fire', 'Trứng Fire', 1, 200, Colors.brown[300],Colors.brown[400]),
  Achievenment('TT11', 'Forest', 'Trứng Forest', 1, 200, Colors.brown[300],Colors.brown[400]),
  Achievenment('TT12', 'Ice', 'Trứng Ice', 1, 200, Colors.brown[300],Colors.brown[400]),
  Achievenment('TT13', 'Loli', 'Trứng Loli', 1, 200, Colors.brown[300],Colors.brown[400]),
  Achievenment('TT14', 'Magic', 'Trứng Magic', 1, 200, Colors.brown[300],Colors.brown[400]),
  Achievenment('TT15', 'Rock', 'Trứng Rock', 1, 200, Colors.brown[300],Colors.brown[400]),
  Achievenment('TT16', 'Silver', 'Trứng Silver', 1, 200, Colors.brown[300],Colors.brown[400]),
  Achievenment('TT17', 'Sky', 'Trứng Sky', 1, 200, Colors.brown[300],Colors.brown[400]),
  Achievenment('TT18', 'Strawberry', 'Trứng Strawberry', 1, 200, Colors.brown[300],Colors.brown[400]),
  Achievenment('TT19', 'Sweety', 'Trứng Sweety', 1, 200, Colors.brown[300],Colors.brown[400]),
  Achievenment('TT20', 'Water', 'Trứng Water', 1, 200, Colors.brown[300],Colors.brown[400]),
];



























