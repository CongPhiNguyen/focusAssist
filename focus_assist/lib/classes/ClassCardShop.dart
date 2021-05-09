import 'package:flutter/material.dart';

class CardShopInfo{
  final String name;
  final double price;
  final String imageEgg;
  final Color rareColor;

  CardShopInfo(
      this.name,
      this.price,
      this.imageEgg,
      this.rareColor,
      );
}

final List<CardShopInfo> value = [
  CardShopInfo('Luong Thien Phuoc', 300, 'assets/achievenment/Eggs/eggCarpentry.png', Colors.red),
  CardShopInfo('Hoang Dan Quang', 1110, 'assets/achievenment/Eggs/eggElectric.png',Colors.purple),
  CardShopInfo('Bui Nhu Phuoc', 700, 'assets/achievenment/Eggs/eggFire.png',Colors.green),
  CardShopInfo('Hoang Dan Quang', 5000, 'assets/achievenment/Eggs/eggIce.png',Colors.indigoAccent),
  CardShopInfo('Luong Thien Phuoc', 300, 'assets/achievenment/Eggs/eggMagic.png', Colors.red),
  CardShopInfo('Hoang Dan Quang', 1110, 'assets/achievenment/Eggs/eggRock.png',Colors.purple),
  CardShopInfo('Bui Nhu Phuoc', 700, 'assets/achievenment/Eggs/eggSky.png',Colors.green),
  CardShopInfo('Hoang Dan Quang', 5000, 'assets/achievenment/Eggs/eggWater.png',Colors.indigoAccent),
  CardShopInfo('Luong Thien Phuoc', 300, 'assets/achievenment/Eggs/eggCarpentry.png', Colors.red),
  CardShopInfo('Hoang Dan Quang', 1110, 'assets/achievenment/Eggs/eggElectric.png',Colors.purple),
  CardShopInfo('Bui Nhu Phuoc', 700, 'assets/achievenment/Eggs/eggFire.png',Colors.green),
  CardShopInfo('Hoang Dan Quang', 5000, 'assets/achievenment/Eggs/eggIce.png',Colors.indigoAccent),
  CardShopInfo('Luong Thien Phuoc', 300, 'assets/achievenment/Eggs/eggMagic.png', Colors.red),
  CardShopInfo('Hoang Dan Quang', 1110, 'assets/achievenment/Eggs/eggRock.png',Colors.purple),
  CardShopInfo('Bui Nhu Phuoc', 700, 'assets/achievenment/Eggs/eggSky.png',Colors.green),
  CardShopInfo('Hoang Dan Quang', 5000, 'assets/achievenment/Eggs/eggWater.png',Colors.indigoAccent),
];

