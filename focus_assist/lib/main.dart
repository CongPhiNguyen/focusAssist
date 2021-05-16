import 'package:flutter/material.dart';
import 'package:focus_assist/pages/focusAssist.dart';
import 'package:flutter_config/flutter_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  runApp(FocusAssist());
}
