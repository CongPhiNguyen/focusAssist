import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text(
          'CHAT APP',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
      ),
      body: Center(
        child: GoogleSignInButton(),
      ),
    );
  }
}
