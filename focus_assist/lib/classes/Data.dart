import 'dart:async';
import 'package:flutter/material.dart';
import 'package:focus_assist/classes/ClassCardAchievenment.dart';
import 'package:focus_assist/classes/ClassPokemon.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'ClassCardShop.dart';
import 'ClassTimerHistory.dart';

class StaticData {
  static bool isSignedIn = false;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static String userID = '';
  static int Vang = 0;
  static List<InfoEggs> EggUser = [];
  static List<InfoEggs> EggShop = [];
  static List<Achievenment> AchiUser = [];
  static List<Achievenment> AchiList = [];
  static Timer timer;
  static Timer timer2;
  static List<InfoPokemon> PokemonUsers = [];
  static List<timerHistories> timerHistoriesList = [];
  static bool focusTimerIsRunning;
}

class Info{
  final String name;
  final String mssv;
  final String birth;
  final String phone;
  final String mail;
  final Color color;

  Info(this.name, this.birth, this.phone, this.mail, this.color, this.mssv);
}

List<Info> member = [
  Info('Thiện Phước', '19/03/2001', '0387527010', '19522055@gm.uit.edu.vn', Colors.greenAccent,'19522055'),
  Info('Công phi', '19/03/2001', '0387527010', '19522055@gm.uit.edu.vn', Colors.redAccent,'19522055'),
  Info('Như Phước', '19/03/2001', '0387527010', '19522055@gm.uit.edu.vn', Colors.purpleAccent,'19522055'),
  Info('Dận Quang', '19/03/2001', '0387527010', '19522055@gm.uit.edu.vn', Colors.blueAccent,'19522055'),
  Info('Tấn Thành', '19/03/2001', '0387527010', '19522055@gm.uit.edu.vn', Colors.yellowAccent,'19522055')
];
