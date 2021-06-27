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
            begin: Alignment.topRight,
            colors: [
              //Colors.amber[100],
              Colors.amber[100],
              Colors.amber[50],
              Colors.grey[50],
              Colors.amber[100],
              Colors.amber[100],
              Colors.amber[100],
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height*0.13,),
            /*FadeAnimation(1.2,Text(
              'WELCOME TO',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.height*0.03,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                fontFamily: "Roboto",
              ),
            )),*/
            SizedBox(height: size.height*0.011,),
            FadeAnimation(1.2,Text(
              'Focus Assist',
              style: TextStyle(
                color: Colors.amber[900],
                fontSize: size.height*0.06,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontFamily: "Roboto",
              ),
            )),
            FadeAnimation(1.2,Container(
              height: size.height*0.5,
              width: size.width*1,
              child: Image.asset('assets/achievenment/ui/login5.png'),
            )),
            FadeAnimation(1.4, button_login(
              color: Colors.amber[600],
              text: "LOGIN",
              press: () {Navigator.push(context, MaterialPageRoute(builder: (context){return LoginScreen();}));},
            )),
            FadeAnimation(1.4, button_login(
              text:"SIGN UP",
              color: Colors.amber[200],
              textColor: Colors.grey[800],
              press: (){Navigator.push(context, MaterialPageRoute(builder: (context){return SignUpScreen();}));},
            )),
          ],
        ),
      ),
    );
  }
}

