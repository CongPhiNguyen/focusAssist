import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:focus_assist/classes/theme_provider.dart';
import 'package:focus_assist/classes/Data.dart';

class ChangeThemeSwitchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
      value: StaticData.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}