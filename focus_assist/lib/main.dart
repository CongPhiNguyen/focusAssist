import 'package:flutter/material.dart';
import 'package:focus_assist/pages/account_setting_screen.dart';
import 'package:focus_assist/pages/setting_screen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => SettingScreen(),
      '/SettingScreen/Account': (context) => AccountSettingScreen(),
    }
  ));
}
