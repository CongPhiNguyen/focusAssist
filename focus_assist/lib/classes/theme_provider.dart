import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:sqflite/sqflite.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = StaticData.isDarkMode ? ThemeMode.dark : ThemeMode.light;

  // bool get isDarkMode {
  //   if (themeMode == ThemeMode.system) {
  //     final brightness = SchedulerBinding.instance.window.platformBrightness;
  //     return brightness == Brightness.dark;
  //   } else {
  //     return themeMode == ThemeMode.dark;
  //   }
  // }

  void toggleTheme(bool isOn) async {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    StaticData.isDarkMode = isOn;
    Database db = await DbProvider.instance.database;
    await db.execute('''
                      UPDATE THONGTINNGUOIDUNG
                      SET DARKMODE = ${(StaticData.isDarkMode)?1:0}
                      WHERE MANGUOIDUNG = '${StaticData.userID}'
                      ''');
    notifyListeners();
  }

  void changeToLightModeWithoutUpdateUser() {
    themeMode = ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.grey[900],
    backgroundColor: Colors.grey[850],
    primaryColor: Colors.black,
    //colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.grey, opacity: 0.8),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.black,
      backgroundColor: Colors.grey[800],
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[850],
      elevation: 1.0,
      titleTextStyle: TextStyle(
        color: Colors.grey[100],
        // color: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
  );

  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.grey[100],
    primaryColor: Colors.white,
    //colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.blue),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.grey[50],
      backgroundColor: Colors.blue.withOpacity(0.7),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 4.0,
      titleTextStyle: TextStyle(
        color: Colors.black87,
      ),
      iconTheme: IconThemeData(
        color: Colors.black87,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.black87,
      ),
    ),
  );
}