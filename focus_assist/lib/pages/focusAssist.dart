import 'package:flutter/material.dart';

import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/theme_provider.dart';
import 'package:focus_assist/pages/main_screen.dart';
import 'package:provider/provider.dart';
import 'login/screen/welcome_screen.dart';

class FocusAssist extends StatelessWidget {
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    builder: (context, _) {
      final themeProvider = Provider.of<ThemeProvider>(context);
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Focus Assist',
        themeMode: themeProvider.themeMode,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        home: (StaticData.isSignedIn)?MainScreen():WelcomeScreen(),
      );
    },
  );
}

