import 'dart:async';
import 'package:focus_assist/classes/ClassCardAchievenment.dart';
import 'package:focus_assist/classes/ClassPokemon.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'ClassCardShop.dart';
import 'ClassTimerHistory.dart';

class StaticData {
  static bool isSignedIn = false;
  static bool isDarkMode = false;
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
