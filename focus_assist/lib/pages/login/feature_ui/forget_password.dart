import 'package:flutter/material.dart';
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
    String _tk, _mk, _re_mk;
    return GestureDetector(
      onTap: (){
        Alert(
            context: context,
            title: "FORGET PASSWORD",
            content: Column(
              children: <Widget>[
                TextField(
                  onChanged: (value){
                    _tk = value;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: 'Tài khoản',
                  ),
                ),
                TextField(
                  onChanged: (value){
                    _mk = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                ),
                TextField(
                  onChanged: (value){
                    _re_mk = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Re-Password',
                  ),
                ),
              ],
            ),
            buttons: [
              DialogButton(
                child: Text(
                  "FIND",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  checkTK(_tk, _mk, _re_mk, context);
                  Navigator.pop(context);
                },
                color: Color.fromRGBO(0, 179, 134, 1.0),
              ),
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
}


void checkTK(String tk, String mk, String re_mk,context) async {
  final k = await DbProvider.instance.rawQuery('''
  SELECT * FROM NGUOIDUNG WHERE TENTAIKHOAN = '$tk'
  ''');
  if (k.length == 0) {
    _show(context, 'Tài khoản không tồn tại');
    return;
  }
  if (mk != re_mk) {
    _show(context, 'Nhập lại mật khẩu không đúng');
    return;
  }

  final update = await DbProvider.instance.rawQuery('''
  UPDATE NGUOIDUNG
  SET MATKHAU = '$mk'
  WHERE TENTAIKHOAN = '$tk'
  ''');
  _showSuccess(context, 'Đổi mật khẩu thành công !');
  return;
}

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
        },
        width: 120,
        color: Colors.green[400],
      )
    ],
  ).show();
}

