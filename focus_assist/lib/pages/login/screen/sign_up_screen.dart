import 'package:flutter/material.dart';
import 'package:focus_assist/pages/focusAssist.dart';
import 'package:focus_assist/pages/login/feature_ui/button_login.dart';
import 'package:focus_assist/pages/login/feature_ui/dontyouhaveaccount.dart';
import 'package:focus_assist/pages/login/feature_ui/edit_text_login.dart';
import 'package:focus_assist/pages/login/feature_ui/edit_text_password_login.dart';
import 'package:focus_assist/pages/login/feature_ui/login_with_socialnetwork.dart';
import 'package:focus_assist/pages/login/feature_ui/or_ui.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [
                Colors.purple[900],
                Colors.purple[800],
                Colors.purple[400],
              ], // Colors
            )
        ),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: size.height*0.03,),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 40.0,fontWeight: FontWeight.bold,),),
                  SizedBox(height: 0.0,),
                  Text('Welcome you to Focus Assistance',style: TextStyle(color: Colors.white,fontSize: 15.0),),
                  SizedBox(height: 10,),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child:  Column(
                    children: <Widget>[
                      edit_text_login(
                        icon: Icons.person,
                        hintText: "Your Email",
                        onChanged: (value){},
                      ),
                      SizedBox(height: size.height*0.0015,),
                      edit_text_password_login(
                        onChanged: (value){},
                      ),
                      SizedBox(height: size.height*0.03,),
                      button_login(
                        text: 'SIGN UP',
                        press: (){
                          runApp(FocusAssist());
                        },
                      ),
                      SizedBox(height: size.height*0.02,),
                      Donthaveanaccount(
                        login: false,
                        press: (){Navigator.push(context, MaterialPageRoute(builder: (context){return LoginScreen();}));},
                      ),
                      SizedBox(height: size.height*0.02,),
                      Or(),
                      SizedBox(height: size.height*0.03,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          login_with_socialnetwork(
                            iconImage: "assets/login/icon/facebook.png",
                            press: (){runApp(FocusAssist());},
                          ),
                          login_with_socialnetwork(
                            iconImage: "assets/login/icon/google.png",
                            press: (){runApp(FocusAssist());},
                          ),
                          login_with_socialnetwork(
                            iconImage: "assets/login/icon/twitter.png",
                            press: (){runApp(FocusAssist());},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




