import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../focusAssist.dart';

class forgot_password extends StatelessWidget {
  const forgot_password({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _tk, _firstPetName,_childHoodName,_mk, _re_mk;
    return GestureDetector(
      onTap: (){
        Alert(
            context: context,
            title: "FORGOT PASSWORD" ,
            content: Column(
              children: <Widget>[
                TextField(
                  onChanged: (value){
                    _tk = value;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: 'Username',
                  ),
                ),
                TextField(
                  onChanged: (value){
                    _firstPetName = value;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: "First pet's name",
                  ),
                ),
                TextField(
                  onChanged: (value){
                    _childHoodName = value;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: "Childhood name",
                  ),
                ),
                TextField(
                  onChanged: (value){
                    _mk = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'NewPassword',
                  ),
                ),
                TextField(
                  onChanged: (value){
                    _re_mk = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Re-NewPassword',
                  ),
                ),
              ],
            ),
            buttons: [
              DialogButton(
                child: Text(
                  "CANCEL",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(116, 116, 191, 1.0),
                  Color.fromRGBO(52, 138, 199, 1.0)
                ]),
              ),
              DialogButton(
                child: Text(
                  "RESET PASS",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  if(_tk == null || _mk == null || _re_mk == null || _childHoodName == null || _firstPetName == null)
                  {
                    Fluttertoast.showToast(msg: 'Please enter all information needed', textColor: Colors.red[300], backgroundColor: Colors.grey[100], gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG,timeInSecForIosWeb: 1 );
                  }else {
                    checkTK(_tk, _firstPetName,_childHoodName,_mk, _re_mk, context);
                    // Navigator.pop(context);
                  }
                },
                color: Color.fromRGBO(0, 179, 134, 1.0),
              )
            ]).show();
      },
      child: Text(
        'Forgot password ? ',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }

  void checkTK(String tk, String firstPetname,String childHoodname,String mk, String re_mk,context) async {

    final k = await DbProvider.instance.rawQuery('''
  SELECT * FROM NGUOIDUNG WHERE TENTAIKHOAN = '$tk'
  ''');
    if (k.length == 0) {
      Fluttertoast.showToast(msg: 'Account does not exist', textColor: Colors.red[300], backgroundColor: Colors.grey[100], gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG,timeInSecForIosWeb: 1 );
      //_show(context, 'Tài khoản không tồn tại');
      return;
    }

    final queryList = await DbProvider.instance.rawQuery('''
      SELECT * FROM THONGTINNGUOIDUNG WHERE MANGUOIDUNG = '${k.first['MANGUOIDUNG']}';      
      ''');

    if(queryList[0]['FIRSTPETNAME'] != firstPetname || queryList[0]['CHILDHOODNAME'] != childHoodname){
      Fluttertoast.showToast(msg: 'Incorrect answers', textColor: Colors.red[300], backgroundColor: Colors.grey[100], gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG,timeInSecForIosWeb: 1 );
      return;
    }

    if (mk != re_mk) {
      // _show(context, 'Re-password incorrect');
      Fluttertoast.showToast(msg: 'Re-password incorrect', textColor: Colors.red[300], backgroundColor: Colors.grey[100], gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG,timeInSecForIosWeb: 1 );
      return;
    }

    final update = await DbProvider.instance.rawQuery('''
  UPDATE NGUOIDUNG
  SET MATKHAU = '${maHoaPassWord(mk)}'
  WHERE TENTAIKHOAN = '$tk'
  ''');
    // _showSuccess(context, 'Successfully !');
    Navigator.pop(context);
    Fluttertoast.showToast(msg: 'Reset password successfully', textColor: Colors.black54, backgroundColor: Colors.grey[100],gravity: ToastGravity.CENTER, toastLength: Toast.LENGTH_SHORT);
    return;
  }

  String maHoaPassWord(String PassWord){

    var bytes = utf8.encode(PassWord);
    var has = sha512224.convert(bytes);

    String matKhauMaHoa = has.toString();

    return matKhauMaHoa;
  }

}




// void _show(context, String message){
//   Alert(
//     context: context,
//     title: 'Thông báo',
//     type: AlertType.warning,
//     closeIcon: Icon(Icons.error),
//     desc: message,
//     buttons: [
//       DialogButton(
//         child: Text(
//           "CANCEL",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         onPressed: () => Navigator.pop(context),
//         width: 120,
//         color: Colors.red,
//       )
//     ],
//   ).show();
// }
//
//
// void _showSuccess(context, String message){
//   Alert(
//     context: context,
//     type: AlertType.success,
//     title: "",
//     closeIcon: Icon(Icons.error),
//     desc: message,
//     buttons: [
//       DialogButton(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//
//             Text(
//               "ACCEPT",
//               style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//           ],
//         ),
//         onPressed: () {
//           Navigator.pop(context);
//           Navigator.pop(context);
//         },
//         width: 120,
//         color: Colors.green[400],
//       )
//     ],
//   ).show();
// }

