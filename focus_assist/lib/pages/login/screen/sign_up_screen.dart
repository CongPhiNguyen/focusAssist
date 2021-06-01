import 'package:flutter/material.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:focus_assist/pages/focusAssist.dart';
import 'package:focus_assist/pages/login/feature_ui/FadeAnimation.dart';
import 'package:focus_assist/pages/login/feature_ui/button_login.dart';
import 'package:focus_assist/pages/login/feature_ui/dontyouhaveaccount.dart';
import 'package:focus_assist/pages/login/feature_ui/edit_text_login.dart';
import 'package:focus_assist/pages/login/feature_ui/edit_text_password_login.dart';
import 'package:focus_assist/pages/login/feature_ui/login_with_socialnetwork.dart';
import 'package:focus_assist/pages/login/feature_ui/or_ui.dart';
import 'login_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:math';

class SignUpScreen extends StatelessWidget {
  String _taiKhoan, _matKhau, _maUser, _ten;

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
                  FadeAnimation(1.2,  Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 40.0,fontWeight: FontWeight.bold,),)),
                  SizedBox(height: size.height*0.01,),
                  FadeAnimation(1.2,  Text('Welcome you to Focus Assistance',style: TextStyle(color: Colors.white,fontSize: 15.0),)),
                  SizedBox(height: size.height*0.01,),
                ],
              ),
            ),
            SizedBox(height: size.height*0.01,),
            Container(
              height: size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child:  Column(
                    children: <Widget>[
                      FadeAnimation(1.2,edit_text_login(
                        icon: Icons.drive_file_rename_outline,
                        hintText: "Full name",
                        onChanged: (value){
                          _ten = value;
                        },
                      )),
                      SizedBox(height: size.height*0.0015,),
                      FadeAnimation(1.2,edit_text_login(
                        icon: Icons.person,
                        hintText: "Your Email",
                        onChanged: (value){
                          _taiKhoan = value;
                        },
                      )),
                      SizedBox(height: size.height*0.0015,),
                      FadeAnimation(1.4,edit_text_password_login(
                        onChanged: (value){
                          _matKhau = value;
                        },
                      )),
                      SizedBox(height: size.height*0.03,),
                      FadeAnimation(1.4, button_login(
                        text: 'SIGN UP',
                        press: () async {
                          if (_matKhau == null || _taiKhoan== null || _ten == null)
                            {
                              _show(context, "Điền đầy đủ thông tin!");
                            }
                          else
                            {
                              _maUser = getRandomString(10);
                              _queryCheckUser(_taiKhoan, _matKhau, _maUser, _ten ,context);
                            }
                        },
                      )),
                      SizedBox(height: size.height*0.02,),
                      FadeAnimation(1.4, Donthaveanaccount(
                        login: false,
                        press: (){Navigator.push(context, MaterialPageRoute(builder: (context){return LoginScreen();}));},
                      )),
                      SizedBox(height: size.height*0.02,),
                      FadeAnimation(1.6,Or()),
                      SizedBox(height: size.height*0.03,),
                      FadeAnimation(1.6,  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          login_with_socialnetwork(
                            iconImage: "assets/login/icon/facebook.png",
                            press: (){runApp(focus());},
                          ),
                          login_with_socialnetwork(
                            iconImage: "assets/login/icon/google.png",
                            press: (){runApp(focus());},
                          ),
                          login_with_socialnetwork(
                            iconImage: "assets/login/icon/twitter.png",
                            press: (){runApp(focus());},
                          ),
                        ],
                      )),
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

//TODO Random;
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


// Check tài khoản có tồn tại hay không
void _queryCheckUser(String tk,String mk, String maUser, String name ,context) async {
  final checkTK = await DbProvider.instance.rawQuery('''
  select * from NGUOIDUNG where TENTAIKHOAN = '$tk'
  ''');

  if (checkTK.length == 1) {
    _show(context, 'Tài khoản đã tồn tại');
    return;
  } else {
    Map<String, dynamic> row = {'MANGUOIDUNG': maUser, 'TENTAIKHOAN': tk,'MATKHAU': mk };
    int i = await DbProvider.instance.insert('NGUOIDUNG', row);

    row = {'MANGUOIDUNG': maUser ,
      'HOTEN': name,
      'ANH':  '0',
      'VANG': 7000,
      'THONGBAO': null,
      'THONGBAOSANG': null,
      'THONGBAOTOI' : null,
      'THOIGIANTHONGBAOSANG': null,
      'THOIGIANTHONGBAOTOI': null,
      'DARKMODE': null,
      'PRIVACYLOCK': null,
      'LOCKPASSCODE': null};
    int j = await DbProvider.instance.insert('THONGTINNGUOIDUNG', row);

    print('value of insert: $i');
    StaticData.userID = maUser;
    _showSuccess(context, "Đăng ký thành công!");

  }
}

// Báo lỗi
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

// Thông báo thành công
void _showSuccess(context, String message){
  Alert(
    context: context,
    type: AlertType.success,
    title: "Thông báo",
    closeIcon: Icon(Icons.error),
    desc: message,
    buttons: [
      DialogButton(
        child: Text(
          "ACCEPT",
          style: TextStyle(color: Colors.white, fontSize: 20),
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

