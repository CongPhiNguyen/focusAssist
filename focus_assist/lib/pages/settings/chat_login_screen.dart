import 'package:flutter/material.dart';
import 'package:focus_assist/classes/Data.dart';
import 'dart:async';
import 'package:focus_assist/pages/settings//google_sign_in_widget.dart';

class ChatLoginScreen extends StatefulWidget {
  @override
  _ChatLoginScreenState createState() => _ChatLoginScreenState();
}

class _ChatLoginScreenState extends State<ChatLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (!StaticData.isDarkMode)?Colors.grey[50]:Colors.grey[900],
      appBar: AppBar(
        title: Text(
          'CONTACT',
          style: TextStyle(
            color: Theme.of(context).appBarTheme.titleTextStyle.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
      ),
      body: Center(
        child: GoogleSignInButton(),
      ),
    );
  }
}
