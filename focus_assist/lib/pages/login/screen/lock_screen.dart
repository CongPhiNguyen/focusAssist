import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:focus_assist/pages/login/feature_ui/FadeAnimation.dart';
import 'package:focus_assist/pages/login/feature_ui/button_login.dart';
import 'package:focus_assist/pages/login/feature_ui/color.dart';
import 'package:focus_assist/pages/login/feature_ui/edit_text.dart';
import 'package:focus_assist/pages/main_screen.dart';

class LockScreen extends StatefulWidget {
  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  TextEditingController passcodeEditingController = new TextEditingController();

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
            Container(
              height: size.height*0.2,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Container(
                      height: size.height*0.2,
                      width: size.width*0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FadeAnimation(1.2,Text('Login', style: TextStyle(color: Colors.white, fontSize: size.height*0.05,fontWeight: FontWeight.bold,),)),
                          SizedBox(height: size.height*0.01,),
                          FadeAnimation(1.2,  Text('Welcome back',style: TextStyle(color: Colors.white,fontSize: size.height*0.025),)),
                          SizedBox(height: size.height*0.01,),
                        ],
                      ),
                    ),
                    FadeAnimation(2,Container(
                      height: size.height*0.2,
                      width: size.width*0.3,
                      child: Image.asset('assets/achievenment/ui/ui_light.PNG'),
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height*0.01,),
            Container(
              height: size.height*0.9,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: size.height*0.03,),
                    FadeAnimation(1.4,Text(
                      'PRIVACY LOCK',
                      style: TextStyle(color: Colors.grey[700], fontSize: size.height*0.05,fontWeight: FontWeight.bold,)
                    )),
                    SizedBox(height: size.height*0.05,),
                    FadeAnimation(1.4,edit_text(
                      child: TextField(
                        controller: passcodeEditingController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Passcode",
                          icon: Icon(
                            Icons.lock,
                            color: mainColor,
                          ),
                          suffixIcon: Icon(
                            Icons.visibility,
                            color: colorEditText,
                          ),
                          border:  InputBorder.none,
                        ),
                      ),
                    )),
                    SizedBox(height: size.height*0.07,),
                    // FadeAnimation(1.4, forgot_password(
                    //
                    // )),
                    FadeAnimation(1.6,button_login(
                      text: 'LOGIN',
                      press: () async {
                        openApp();
                      },
                    )),
                    // FadeAnimation(1.6, Donthaveanaccount(
                    //   login: true,
                    //   press: () {Navigator.push(context, MaterialPageRoute(builder: (context){return SignUpScreen();}));},
                    // )),
                    SizedBox(height: size.height*0.04,),
                    FadeAnimation(2, Container(
                        height: size.height*0.2,
                        child: Image.asset(
                          'assets/achievenment/ui/ui_signup.PNG',
                        )),
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

  openApp() async {
    if (passcodeEditingController.text == '') {
      Fluttertoast.showToast(msg: 'Please enter passcode', textColor: Colors.red[300], backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
      return;
    }
    List<Map<String, dynamic>> queryList = await DbProvider.instance.rawQuery('''
        SELECT * FROM THONGTINNGUOIDUNG WHERE MANGUOIDUNG = '${StaticData.userID}';
        ''');
    if (queryList.first['LOCKPASSCODE'] != passcodeEditingController.text) {
      Fluttertoast.showToast(msg: 'Incorrect passcode', textColor: Colors.red[300], backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  }
}
