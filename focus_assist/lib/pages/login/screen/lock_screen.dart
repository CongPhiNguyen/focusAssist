import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';

import 'package:focus_assist/pages/login/feature_ui/FadeAnimation.dart';
import 'package:focus_assist/pages/login/feature_ui/button_login.dart';

import 'package:focus_assist/pages/login/feature_ui/edit_text.dart';
import 'package:focus_assist/pages/login/feature_ui/forget_password.dart';
import 'package:focus_assist/pages/main_screen.dart';



class LockScreen extends StatefulWidget {
  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  TextEditingController passcodeEditingController = new TextEditingController();
  TextEditingController new_passcodeEditingController = new TextEditingController();
  final validCharacters = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');

  bool isPrivacy = true;
  String userName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Loading();
  }

  void Loading()async{
    final checkTK = await DbProvider.instance.rawQuery('''
  select * from NGUOIDUNG where MANGUOIDUNG = '${StaticData.userID}'
  ''');

  userName = checkTK[0]['TENTAIKHOAN'];

  }


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
                Colors.amber[800],
                Colors.amber[600],
                Colors.amber[400],
                Colors.amber[200],
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
                          FadeAnimation(1.2,Text('Focus Assist', style: TextStyle(color: Colors.white, fontSize: size.height*0.05,fontWeight: FontWeight.bold,),)),
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
                      isPrivacy?'PRIVACY LOCK':'RESET PASSCODE',
                      style: TextStyle(color: Colors.grey[700], fontSize: size.height*0.05,fontWeight: FontWeight.bold,)
                    )),
                    SizedBox(height: size.height*0.05,),
                    FadeAnimation(1.4, isPrivacy?Text(""):Center(child: Text(
                      "Username : ${userName}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        fontSize: 20,
                      ),
                    ),)),
                    SizedBox(height: size.height*0.01,),
                    FadeAnimation(1.4,edit_text(
                      child: TextField(
                        style: TextStyle(color: Colors.grey[700]),
                        controller: passcodeEditingController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: isPrivacy?"Passcode":"Password",
                          hintStyle: TextStyle(color: Colors.grey,),
                          icon: Icon(
                            Icons.lock,
                            color: Colors.amber[600],
                          ),
                          border:  InputBorder.none,
                        ),
                      ),
                    )),
                    SizedBox(height: size.height*0.01,),
                    // FadeAnimation(1.4, forgot_password(
                    //
                    // )),
                    FadeAnimation(1.4,
                        isPrivacy?SizedBox(height: 0,):edit_text(
                          child: TextField(
                            style: TextStyle(color: Colors.grey[700]),
                            controller: new_passcodeEditingController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "New Passcode",
                              hintStyle: TextStyle(color: Colors.grey,),
                              icon: Icon(
                                Icons.lock,
                                color: Colors.amber[600],
                              ),
                              border:  InputBorder.none,
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: size.height*0.01,),
                    FadeAnimation(1.6, isPrivacy?SizedBox(height: 0,):forgot_password()),
                    FadeAnimation(1.6,
                        isPrivacy?
                        button_login(
                      text: 'LOGIN',
                      color: Colors.amber[600],
                      press: () async {
                        openApp();
                      },
                      ) :
                        button_login(
                          text: 'RESET PASSCODE',
                          color: Colors.amber[600],
                          press: () async {
                            signIn();
                          },
                    ),),
                    // FadeAnimation(1.6, Donthaveanaccount(
                    //   login: true,
                    //   press: () {Navigator.push(context, MaterialPageRoute(builder: (context){return SignUpScreen();}));},
                    // )),
                    FadeAnimation(1.6, Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isPrivacy?"Forget Passcode?":"Sign In with Passcode",
                          style: TextStyle(color: Colors.amber[900]),
                        ),
                        GestureDetector(
                          onTap: (){
                            if(isPrivacy == true){
                              setState(() {
                                isPrivacy = false;
                                passcodeEditingController.text= '';
                                new_passcodeEditingController.text='';
                              });
                            }else{
                              setState(() {
                                isPrivacy = true;
                                passcodeEditingController.text= '';
                                new_passcodeEditingController.text='';
                              });
                            }
                          },
                          child: Text(
                            isPrivacy?"  Here":"   Return",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue[300],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                    ),
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

  signIn() async {
    if (passcodeEditingController.text == '' || new_passcodeEditingController.text == '') {
      Fluttertoast.showToast(msg: 'Please enter all information needed', textColor: Colors.red[300], backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
      return;
    }
    print(StaticData.userID);
    final checkTK = await DbProvider.instance.rawQuery('''
  select * from NGUOIDUNG where MANGUOIDUNG = '${StaticData.userID}'
  ''');

    print(checkTK[0]['MATKHAU']);
    if (checkTK[0]['MATKHAU'] != maHoaPassWord(passcodeEditingController.text))
    {
      //_show(context, "Sai mật khẩu");
      Fluttertoast.showToast(msg: 'Incorrect password', textColor: Colors.red[300], backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
      return;
    }

    if (validCharacters.hasMatch(new_passcodeEditingController.text) == false){
      Fluttertoast.showToast(msg: "Invalid passcode", textColor: Colors.red[300], backgroundColor: Colors.grey[100], gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG);
      return;
    }

    final update = await DbProvider.instance.rawQuery('''
    UPDATE THONGTINNGUOIDUNG
    SET LOCKPASSCODE = '${maHoaPassWord(new_passcodeEditingController.text)}'
    WHERE MANGUOIDUNG = '${StaticData.userID}'
    ''');


    setState(() {
      isPrivacy = true;
      passcodeEditingController.text= '';
      new_passcodeEditingController.text='';
    });
    Fluttertoast.showToast(msg: 'Reset passcode successfully', textColor: Colors.black54, backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_SHORT);

  }

  openApp() async {
    if (passcodeEditingController.text == '') {
      Fluttertoast.showToast(msg: 'Please enter passcode', textColor: Colors.red[300], backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
      return;
    }
    List<Map<String, dynamic>> queryList = await DbProvider.instance.rawQuery('''
        SELECT * FROM THONGTINNGUOIDUNG WHERE MANGUOIDUNG = '${StaticData.userID}';
        ''');
    if (queryList.first['LOCKPASSCODE'] != maHoaPassWord(passcodeEditingController.text)) {
      Fluttertoast.showToast(msg: 'Incorrect passcode', textColor: Colors.red[300], backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
    Fluttertoast.showToast(msg: 'Sign in successfully', textColor: Colors.black54, backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_SHORT);
  }

  //Dung SHA-512224 băm mk
  String maHoaPassWord(String PassWord){

    var bytes = utf8.encode(PassWord);
    var has = sha512224.convert(bytes);

    String matKhauMaHoa = has.toString();

    return matKhauMaHoa;
  }

}

