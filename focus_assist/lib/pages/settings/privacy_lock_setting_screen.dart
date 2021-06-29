import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';

class PrivacyLockSettingScreen extends StatefulWidget {
  @override
  _PrivacyLockSettingScreenState createState() => _PrivacyLockSettingScreenState();
}

class _PrivacyLockSettingScreenState extends State<PrivacyLockSettingScreen> {
  bool isPrivacyLockEnable = StaticData.isPrivacyLockOn;
  bool isPasscodeNull = false;
  TextEditingController passcodeEditingController = new TextEditingController();
  TextEditingController newPasscodeController = new TextEditingController();
  TextEditingController confirmPasscodeController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPrivacyLockSetting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 1,
        title: Text(
          'Privacy Lock',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).appBarTheme.titleTextStyle.color,
            letterSpacing: 0.5,
          ),
        ),
        leading: BackButton(),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 5.0),
          ListTile(
            onTap: () {
              setState(() {
                isPrivacyLockEnable = !isPrivacyLockEnable;
              });
              updatePrivacyLockOnOff(isPrivacyLockEnable);
              if (isPrivacyLockEnable && isPasscodeNull) showSetPasscodeDialog();
            },
            title: Text(
              '        Privacy Lock Enabled',
            ),
            trailing: Switch(
              value: isPrivacyLockEnable,
              onChanged: (value) {
                setState(() {
                  isPrivacyLockEnable = value;
                });
                updatePrivacyLockOnOff(isPrivacyLockEnable);
                if (isPrivacyLockEnable && isPasscodeNull) showSetPasscodeDialog();
              },
            ),
          ),
          ListTile(
            enabled: isPrivacyLockEnable,
            onTap: () {
              showChangePasscodeDialog();
            },
            title: Text(
              '        Change Passcode',
            ),
          ),
        ],
      ),
    );
  }

  loadPrivacyLockSetting() async {
    List<Map<String, dynamic>> queryList = await DbProvider.instance.rawQuery('''
        SELECT * FROM THONGTINNGUOIDUNG WHERE MANGUOIDUNG = '${StaticData.userID}';
        ''');
    setState(() {
      isPrivacyLockEnable = queryList.first['PRIVACYLOCK'] == 1;
    });
    if (queryList.first['LOCKPASSCODE'] == '') isPasscodeNull = true;
    print('passcode: ${queryList.first['LOCKPASSCODE']}');
    // await updatePasscode('passcode');
  }

  updatePrivacyLockOnOff(bool value) async {
    await DbProvider.instance.rawQuery('''
        UPDATE THONGTINNGUOIDUNG
        SET PRIVACYLOCK = ${value?1:0}
        WHERE MANGUOIDUNG = '${StaticData.userID}';
        ''');
    StaticData.isPrivacyLockOn = value;
  }

  updatePasscode(String newPasscode) async {
    await DbProvider.instance.rawQuery('''
        UPDATE THONGTINNGUOIDUNG
        SET LOCKPASSCODE = '$newPasscode'
        WHERE MANGUOIDUNG = '${StaticData.userID}';
        ''');
    Fluttertoast.showToast(msg: 'Change passcode successfully', textColor: Colors.black54, backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_SHORT);
  }

  showChangePasscodeDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        OutlineInputBorder outlineInputBorder = OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: (!StaticData.isDarkMode)?Colors.black:Colors.grey),
        );
        return AlertDialog(
          title: Center(
              child: Text(
                'Change Passcode',
                style: TextStyle(color: (!StaticData.isDarkMode)?Colors.blue:Colors.white),
              )),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          contentPadding: EdgeInsets.fromLTRB(20, 25, 20, 0),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // SizedBox(height: 10,),
                TextField(
                  controller: passcodeEditingController,
                  obscureText: true,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: outlineInputBorder,
                    disabledBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder,
                    focusedErrorBorder: outlineInputBorder,
                    labelText: 'Passcode',
                    labelStyle: TextStyle(fontSize: 18, color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[400]),
                    //hintText: 'Password',
                  ),
                ),
                SizedBox(height: 5),
                // Divider(
                //   height: 1,
                //   color: Colors.blue,
                // ),
                TextField(
                  controller: newPasscodeController,
                  obscureText: true,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: outlineInputBorder,
                    disabledBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder,
                    focusedErrorBorder: outlineInputBorder,
                    labelText: 'New Passcode',
                    labelStyle: TextStyle(fontSize: 18, color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[400]),
                    //hintText: 'New Password',
                  ),
                ),
                // Divider(
                //   height: 1,
                //   color: Colors.blue,
                // ),
                SizedBox(height: 5),
                TextField(
                  controller: confirmPasscodeController,
                  obscureText: true,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: outlineInputBorder,
                    disabledBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder,
                    focusedErrorBorder: outlineInputBorder,
                    labelText: 'Confirm Passcode',
                    labelStyle: TextStyle(fontSize: 18, color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[400]),
                    //hintText: 'Confirm New Password',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                print('Cancel');
                passcodeEditingController.clear();
                newPasscodeController.clear();
                confirmPasscodeController.clear();

                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () async {
                print('OK');
                List<Map<String, dynamic>> queryList = await DbProvider.instance.rawQuery('''
                    select * from THONGTINNGUOIDUNG where MANGUOIDUNG = '${StaticData.userID}'
                    ''');
                print(queryList[0]['LOCKPASSCODE']);
                if (passcodeEditingController.text == '' || newPasscodeController.text == '' || confirmPasscodeController.text == '') {
                  Fluttertoast.showToast(msg: 'Please enter all information needed', textColor: Colors.red[300], backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
                }
                else if (passcodeEditingController.text != queryList[0]['LOCKPASSCODE']) {
                  Fluttertoast.showToast(msg: 'Incorrect Passcode', textColor: Colors.red[300], backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
                }
                else if (newPasscodeController.text != confirmPasscodeController.text) {
                  Fluttertoast.showToast(msg: 'Confirm passcode does not match', textColor: Colors.red[300], backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
                }
                else {
                  updatePasscode(newPasscodeController.text);
                  //Fluttertoast.showToast(msg: 'Change password successfully', textColor: Colors.black54, backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
                  passcodeEditingController.clear();
                  newPasscodeController.clear();
                  confirmPasscodeController.clear();
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  showSetPasscodeDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        OutlineInputBorder outlineInputBorder = OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: (!StaticData.isDarkMode)?Colors.black:Colors.grey),
        );
        return AlertDialog(
          title: Center(
              child: Text(
                'Set Passcode',
                style: TextStyle(color: (!StaticData.isDarkMode)?Colors.blue:Colors.white),
              )),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          contentPadding: EdgeInsets.fromLTRB(20, 25, 20, 0),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(height: 10,),
                // TextField(
                //   controller: passcodeEditingController,
                //   obscureText: true,
                //   style: TextStyle(fontSize: 18),
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //     focusedBorder: outlineInputBorder,
                //     disabledBorder: outlineInputBorder,
                //     enabledBorder: outlineInputBorder,
                //     errorBorder: outlineInputBorder,
                //     focusedErrorBorder: outlineInputBorder,
                //     labelText: 'Passcode',
                //     labelStyle: TextStyle(fontSize: 18, color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[400]),
                //     //hintText: 'Password',
                //   ),
                // ),
                // SizedBox(height: 5),
                // Divider(
                //   height: 1,
                //   color: Colors.blue,
                // ),
                TextField(
                  controller: newPasscodeController,
                  obscureText: true,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: outlineInputBorder,
                    disabledBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder,
                    focusedErrorBorder: outlineInputBorder,
                    labelText: 'New Passcode',
                    labelStyle: TextStyle(fontSize: 18, color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[400]),
                    //hintText: 'New Password',
                  ),
                ),
                // Divider(
                //   height: 1,
                //   color: Colors.blue,
                // ),
                SizedBox(height: 5),
                TextField(
                  controller: confirmPasscodeController,
                  obscureText: true,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: outlineInputBorder,
                    disabledBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder,
                    focusedErrorBorder: outlineInputBorder,
                    labelText: 'Confirm Passcode',
                    labelStyle: TextStyle(fontSize: 18, color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[400]),
                    //hintText: 'Confirm New Password',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                print('Cancel');
                // passcodeEditingController.clear();
                newPasscodeController.clear();
                confirmPasscodeController.clear();
                updatePrivacyLockOnOff(false);
                setState(() {
                  isPrivacyLockEnable = false;
                });
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () async {
                print('OK');
                List<Map<String, dynamic>> queryList = await DbProvider.instance.rawQuery('''
                    select * from NGUOIDUNG where MANGUOIDUNG = '${StaticData.userID}'
                    ''');
                if (newPasscodeController.text == '' || confirmPasscodeController.text == '') {
                  Fluttertoast.showToast(msg: 'Please enter all information needed', textColor: Colors.red[300], backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
                }
                // else if (passcodeEditingController.text != queryList[0]['PASSCODE']) {
                //   Fluttertoast.showToast(msg: 'Incorrect Passcode', textColor: Colors.red[300], backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
                // }
                else if (newPasscodeController.text != confirmPasscodeController.text) {
                  Fluttertoast.showToast(msg: 'Confirm passcode does not match', textColor: Colors.red[300], backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
                }
                else {
                  updatePasscode(newPasscodeController.text);
                  //Fluttertoast.showToast(msg: 'Change password successfully', textColor: Colors.black54, backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
                  // passcodeEditingController.clear();
                  newPasscodeController.clear();
                  confirmPasscodeController.clear();
                  isPasscodeNull = false;
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

}
