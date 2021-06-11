import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:focus_assist/pages/focusAssist.dart';
import 'package:focus_assist/pages/login/feature_ui/FadeAnimation.dart';
import 'package:focus_assist/pages/login/feature_ui/button_login.dart';
import 'package:focus_assist/pages/login/feature_ui/dontyouhaveaccount.dart';
import 'package:focus_assist/pages/login/feature_ui/edit_text_login.dart';
import 'package:focus_assist/pages/login/feature_ui/edit_text_password_login.dart';
import 'package:focus_assist/pages/login/feature_ui/forget_password.dart';
import 'package:focus_assist/pages/login/screen/sign_up_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:focus_assist/classes/Data.dart';

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
                          FadeAnimation(1.2,  Text('Welcome you comeback',style: TextStyle(color: Colors.white,fontSize: size.height*0.025),)),
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
                      FadeAnimation(1.4,edit_text_login(
                        icon: Icons.person,
                        hintText: "Your Email",
                        onChanged: (value){
                            _taiKhoan = value;
                        },
                      )),
                      SizedBox(height: size.height*0.03,),
                      FadeAnimation(1.4,edit_text_password_login(
                        onChanged: (value){
                          _matKhau = value;
                        },
                      )),
                      SizedBox(height: size.height*0.07,),
                      FadeAnimation(1.4, forgot_password(

                      )),
                      FadeAnimation(1.6,button_login(
                        text: 'LOGIN',
                        press: () async {
                            _queryCheckUser(_taiKhoan, _matKhau, context);
                        },
                      )),
                       FadeAnimation(1.6, Donthaveanaccount(
                        login: true,
                        press: () {Navigator.push(context, MaterialPageRoute(builder: (context){return SignUpScreen();}));},
                      )),
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
}


//TODO Check tài khoản có tồn tại hay không
void _queryCheckUser(String tk, String mk,context) async
{

  if (tk == null || mk == null)
  {
    print('Điền nđầy đủ thông tin');
    _show(context, 'Điền đầy đủ thông tin!');
    return;
  }

  //Check tài khoản
  final checkTK = await DbProvider.instance.rawQuery('''
  select * from NGUOIDUNG where TENTAIKHOAN = '$tk'
  ''');

  if (checkTK.length == 0)
    {
      _show(context,"Tài khoản không tồn tại");
      return;
    }

  if (checkTK[0]['MATKHAU'] == mk)
  {
    StaticData.userID = checkTK[0]['MANGUOIDUNG'];
    _showSuccess(context, "Đăng nhập thành công!");
    return;
  } else {
    _show(context, "Sai mật khẩu");
  }
  return;
}


//TODO Show thông báo
void _show(context, String message){
  Alert(
    context: context,
    title: 'Thông báo',
    type: AlertType.warning,
    closeIcon: Icon(Icons.error),
    desc: message,
    buttons: [
      DialogButton(
        child: Text(
          "CANCEL",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
        color: Colors.red,
      )
    ],
  ).show();
}


void _showSuccess(context, String message){
  Alert(
    context: context,
    type: AlertType.success,
    title: "Thông báo",
    closeIcon: Icon(Icons.error),
    desc: message,
    buttons: [
      DialogButton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(
              "ACCEPT",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
        onPressed: () {
          Navigator.pop(context);
          runApp(focus());
          },
        width: 120,
        color: Colors.green[400],
      )
    ],
  ).show();
}




