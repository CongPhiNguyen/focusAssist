import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:focus_assist/pages/login/feature_ui/FadeAnimation.dart';
import 'package:focus_assist/pages/login/feature_ui/button_login.dart';
import 'package:focus_assist/pages/login/feature_ui/edit_text_login.dart';

import '../../main_screen.dart';


class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key key}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final validCharacters = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');
  String _firstPetName,_childHoodName;

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
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: size.height*0.2,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Container(
                      width: size.width*0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FadeAnimation(1.2,  Text('Question',style: TextStyle(color: Colors.white,fontSize: 40.0,fontWeight: FontWeight.bold,),)),
                          SizedBox(height: size.height*0.01,),
                          FadeAnimation(1.2,  Text('To reset your password',style: TextStyle(color: Colors.white,fontSize: size.height*0.02),)),
                          SizedBox(height: size.height*0.01,),
                        ],
                      ),
                    ),
                    FadeAnimation(2,Container(
                      width: size.width*0.3,
                      height: size.height*0.15,
                      child: Image.asset('assets/achievenment/ui/ui_light.PNG'),
                    )),
                  ],
                ),
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
                      hintText: "Your first pet's name",
                      onChanged: (value){
                        _firstPetName = value;
                      },
                    )),
                    SizedBox(height: size.height*0.0015,),
                    FadeAnimation(1.2,edit_text_login(
                      icon: Icons.person,
                      hintText: "Your childhood's name or nickname",
                      onChanged: (value){
                        _childHoodName = value;
                      },
                    )),
                    SizedBox(height: size.height*0.0015,),

                    SizedBox(height: size.height*0.03,),
                    FadeAnimation(1.4, button_login(
                      color: Colors.amber[600],
                      text: 'CONFIRM',
                      press: () async {
                        if (_firstPetName == null || _childHoodName == null)
                        {
                          //_show(context, "Điền đầy đủ thông tin!");
                          Fluttertoast.showToast(msg: 'Please enter all information needed', textColor: Colors.red[300], backgroundColor: Colors.grey[100], gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG,timeInSecForIosWeb: 1 );
                        }
                        else if (validCharacters.hasMatch(_firstPetName) == false || validCharacters.hasMatch(_childHoodName)== false){
                          Fluttertoast.showToast(msg: "Invalid characters", textColor: Colors.red[300], backgroundColor: Colors.grey[100], gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG);
                        }
                        else
                        {
                          final k = await DbProvider.instance.rawQuery('''
                          UPDATE THONGTINNGUOIDUNG
                          SET FIRSTPETNAME = '$_firstPetName',
                              CHILDHOODNAME = '$_childHoodName'
                          WHERE MANGUOIDUNG = '${StaticData.userID}';
                          ''');

                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MainScreen()),
                          );
                          Fluttertoast.showToast(msg: 'Sign up successfully', textColor: Colors.black54, backgroundColor: Colors.grey[100],gravity: ToastGravity.CENTER, toastLength: Toast.LENGTH_SHORT);
                        }

                      },
                    )),
                    SizedBox(height: size.height*0.02,),
                    FadeAnimation(2.5,Container(
                      height: size.height*0.15,
                      width: size.width*0.6,
                      child: Image.asset('assets/achievenment/ui/ui_signin.PNG'),
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
