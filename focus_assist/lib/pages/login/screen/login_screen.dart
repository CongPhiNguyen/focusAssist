import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:focus_assist/pages/focusAssist.dart';
import 'package:focus_assist/pages/login/feature_ui/FadeAnimation.dart';
import 'package:focus_assist/pages/login/feature_ui/button_login.dart';
import 'package:focus_assist/pages/login/feature_ui/dontyouhaveaccount.dart';
import 'package:focus_assist/pages/login/feature_ui/edit_text_login.dart';
import 'package:focus_assist/pages/login/feature_ui/edit_text_password_login.dart';
import 'package:focus_assist/pages/login/screen/sign_up_screen.dart';


class LoginScreen extends StatelessWidget {

  String _taiKhoan, _matKhau;

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
                  FadeAnimation(1.2,Text('Login', style: TextStyle(color: Colors.white, fontSize: 40.0,fontWeight: FontWeight.bold,),)),
                  SizedBox(height: size.height*0.01,),
                  FadeAnimation(1.4,  Text('Welcome you comeback',style: TextStyle(color: Colors.white,fontSize: 20.0),)),
                  SizedBox(height: size.height*0.01,),

                ],
              ),
            ),
            SizedBox(height: size.height*0.01,),

            Container(
              height: size.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: size.height*0.03,),
                      FadeAnimation(1.6,edit_text_login(
                        icon: Icons.person,
                        hintText: "Your Email",
                        onChanged: (value){
                            _taiKhoan = value;
                        },
                      )),
                      SizedBox(height: size.height*0.03,),
                      FadeAnimation(1.8,edit_text_password_login(
                        onChanged: (value){
                          _matKhau = value;
                        },
                      )),
                      SizedBox(height: size.height*0.1,),
                      FadeAnimation(2.0, GestureDetector(
                        onTap: (){},
                        child: Text(
                          'Forgot password ? ',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      )),
                       FadeAnimation(2.2,button_login(
                        text: 'LOGIN',
                        press: () async {
                         // final info = await DbProvider.instance.sreach('NGUOIDUNG', _taiKhoan);
                          final infoUSER = await DbProvider.instance.query('NGUOIDUNG');
                          for (int i = 0; i < infoUSER.length; i++)
                            {
                              if (infoUSER[i]['MATKHAU'] == _matKhau && infoUSER[i]['TENTAIKHOAN'] == _taiKhoan)
                                {
                                  print("Đang nhập thành công vs tài khoản $_taiKhoan");

                                }
                              else
                                {
                                  print("TK không tồn tại hoặc sai mk");
                                }
                            };

                         // info.forEach(print);
                        },
                      )),
                       FadeAnimation(2.4, Donthaveanaccount(
                        login: true,
                        press: () {Navigator.push(context, MaterialPageRoute(builder: (context){return SignUpScreen();}));},
                      )),
                       FadeAnimation(3.6, Container(
                        height: size.height*0.15,
                        width: size.width*3,
                        child: Image.asset(
                          'assets/login/ui/UI_login_screen.png',
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
}





