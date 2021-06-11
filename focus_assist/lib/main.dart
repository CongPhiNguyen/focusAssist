import 'package:flutter/material.dart';
import 'package:focus_assist/pages/focusAssist.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:focus_assist/pages/login/screen/login_screen.dart';
import 'package:focus_assist/pages/login/screen/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  runApp(FocusAssist());
}

class FocusAssist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome',
      home: WelcomeScreen(),
    );
  }
}

