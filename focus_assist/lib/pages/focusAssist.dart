import 'package:flutter/material.dart';

import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/pages/main_screen.dart';
import 'login/screen/welcome_screen.dart';

class FocusAssist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Focus Assist',
      home: (StaticData.isSignedIn) ? MainScreen() : WelcomeScreen(),
    );
  }
}
