import 'package:flutter/material.dart';
import 'package:focus_assist/pages/focusAssist.dart';
import 'package:focus_assist/pages/login/screen/login_screen.dart';
import 'package:focus_assist/pages/login/screen/welcome_screen.dart';

void main(){
  runApp(focusAssist());
}

class focusAssist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome',
      home: WelcomeScreen(),
    );
  }
}
