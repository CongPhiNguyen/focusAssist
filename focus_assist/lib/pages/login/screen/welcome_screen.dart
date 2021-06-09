import 'package:flutter/material.dart';
import 'package:focus_assist/pages/login/feature_ui/FadeAnimation.dart';
import 'package:focus_assist/pages/login/feature_ui/button_login.dart';
import 'package:focus_assist/pages/login/feature_ui/color.dart';
import 'package:focus_assist/pages/login/screen/sign_up_screen.dart';
import 'login_screen.dart';


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [
              Colors.purple[700],
              Colors.white,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height*0.1,),
            FadeAnimation(1.2,Text(
              'WELCOME TO',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.height*0.045,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            )),
            SizedBox(height: size.height*0.01,),
            FadeAnimation(1.2,Text(
              'Focus Assistance',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.height*0.025,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            )),
            FadeAnimation(1.2,Container(
              height: size.height*0.5,
              child: Image.asset('assets/login/ui/UI_welcome_screen.png'),
            )),
            FadeAnimation(1.4, button_login(
              color: mainColor,
              text: "LOGIN",
              press: () {Navigator.push(context, MaterialPageRoute(builder: (context){return LoginScreen();}));},
            )),
            FadeAnimation(1.4, button_login(
              text:"SIGN UP",
              color: Colors.purple[50],
              textColor: Colors.black,
              press: (){Navigator.push(context, MaterialPageRoute(builder: (context){return SignUpScreen();}));},
            )),
          ],
        ),
      ),
    );
  }
}

