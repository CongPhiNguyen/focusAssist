import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_assist/pages/focusAssist.dart';
import 'package:focus_assist/pages/login/feature_ui/button_login.dart';
import 'package:focus_assist/pages/login/feature_ui/dontyouhaveaccount.dart';
import 'package:focus_assist/pages/login/feature_ui/edit_text_login.dart';
import 'package:focus_assist/pages/login/feature_ui/edit_text_password_login.dart';
import 'package:focus_assist/pages/login/screen/sign_up_screen.dart';


class LoginScreen extends StatelessWidget {
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
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: size.height*0.03,),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Login', style: TextStyle(color: Colors.white, fontSize: 40.0,fontWeight: FontWeight.bold,),),
                  SizedBox(height: size.height*0.01,),
                  Text('Welcome you comeback',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                  SizedBox(height: size.height*0.01,),

                ],
              ),
            ),
            SizedBox(height: size.height*0.01,),

            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: size.height*0.03,),
                      edit_text_login(
                        icon: Icons.person,
                        hintText: "Your Email",
                        onChanged: (value){},
                      ),
                      SizedBox(height: size.height*0.03,),
                      edit_text_password_login(
                        onChanged: (value){},
                      ),
                      SizedBox(height: size.height*0.06,),
                      GestureDetector(
                        onTap: (){},
                        child: Text(
                          'Forgot password ? ',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      button_login(
                        text: 'LOGIN',
                        press: (){
                          runApp(FocusAssist());
                        },
                      ),
                      Donthaveanaccount(
                        login: true,
                        press: () {Navigator.push(context, MaterialPageRoute(builder: (context){return SignUpScreen();}));},
                      ),
                      Container(
                        height: size.height*0.15,
                        width: size.width*3,
                        child: Image.asset(
                          'assets/login/ui/UI_login_screen.png',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}





