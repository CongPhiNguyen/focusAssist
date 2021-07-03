import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:flutter/material.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:focus_assist/classes/theme_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:focus_assist/pages/login/screen/welcome_screen.dart';
import 'package:focus_assist/classes/theme_provider.dart';

import 'package:focus_assist/classes/DbProvider.dart';

class AccountSettingScreen extends StatefulWidget {
  @override
  _AccountSettingScreenState createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  String username = 'Username';
  Image image;
  TextEditingController usernameEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController newPasswordEditingController = new TextEditingController();
  TextEditingController confirmNewPasswordEditingController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(ThemeProvider().themeMode.toString());
    LoadUsername();
    LoadUserImage();
  }

  Future<void> LoadUsername() async {
    Database db = await DbProvider.instance.database;
    List<dynamic> whereArguments = ['${StaticData.userID}'];
    List<Map<String, dynamic>> queryRows = await db.query('THONGTINNGUOIDUNG',
        where: 'MANGUOIDUNG = ?', whereArgs: whereArguments);
    if (queryRows.first['HOTEN'] == null || queryRows.first['HOTEN'] == '')
      return;
    try {
      setState(() {
        username = queryRows.first['HOTEN'];
      });
    } catch (e) {
      print('Error setting username: $e');
    }
  }

  Future<void> LoadUserImage() async {
    Database db = await DbProvider.instance.database;
    List<dynamic> whereArguments = ['${StaticData.userID}'];
    List<Map<String, dynamic>> queryRows = await db.query('THONGTINNGUOIDUNG',
        where: 'MANGUOIDUNG = ?', whereArgs: whereArguments);
    if (queryRows.first['ANH'] == null || queryRows.first['ANH'] == '') return;
    try {
      setState(() {
        image = imageFromBase64String(queryRows.first['ANH']);
      });
    } catch (e) {
      print('Error setting avatar: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(00.0, 20.0, 00.0, 0),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        width: 100.0,
                        child: BackButton(),
                      ),
                      Container(
                        width: 100.0,
                        child: Center(
                          child: CircleAvatar(
                            backgroundImage: (image == null)
                                ? AssetImage('assets/default.png')
                                : null,
                            backgroundColor: Colors.transparent,
                            radius: 50.0,
                            child: ClipRRect(
                              child: (image != null) ? image : null,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        width: 100.0,
                        child: PopupMenuButton(
                          onSelected: (value) {
                            print(value);
                            switch (value) {
                              case 1:
                                _showAvatarChoiceDialog(context);
                                break;
                              case 2:
                                _showEditNameDialog(context);
                                break;
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry>[
                            PopupMenuItem(
                              child: Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.account_circle,
                                      // color: Colors.blue,
                                    ),
                                    Text('   Change Avatar'),
                                  ],
                                ),
                              ),
                              value: 1,
                            ),
                            PopupMenuDivider(height: 5.0),
                            PopupMenuItem(
                              child: Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.edit,
                                      // color: Colors.blue,
                                    ),
                                    Text('   Edit Name'),
                                  ],
                                ),
                              ),
                              value: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      '$username',
                      style: TextStyle(
                        fontSize: 24.0,
                        // color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 40.0,
                thickness: 1.5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                      child: Text(
                        'CONNECT',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(),
                      elevation: 0.0,
                      child: ListTile(
                        onTap: () {
                          _showSignOutDialog(context);
                        },
                        title: Text(
                          'Sign Out',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: (!StaticData.isDarkMode)?Colors.blue[500]:Colors.white,
                          ),
                        ),
                        tileColor: (!StaticData.isDarkMode)?Colors.blue[50]:Colors.grey[800],
                        // tileColor: Colors.grey[800],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      elevation: 0.0,
                      child: ListTile(
                        onTap: () {
                          _showChangePasswordDialog(context);
                        },
                        title: Text(
                          'Change Password',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: (!StaticData.isDarkMode)?Colors.blue[500]:Colors.white,
                          ),
                        ),
                        tileColor: (!StaticData.isDarkMode)?Colors.blue[50]:Colors.grey[800],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.warning_rounded,
                            color: Colors.amber,
                          ),
                          Text(
                            '  CAUTION ZONE',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      elevation: 0.0,
                      child: ListTile(
                        onTap: () {
                          _showDeleteAllActivitiesDialog(context);
                        },
                        title: Text(
                          'Delete All Activities',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[500],
                            // color: (!StaticData.isDarkMode)?Colors.red[500]:Colors.red[500],
                          ),
                        ),
                        // tileColor: Colors.red[50],
                        tileColor: (!StaticData.isDarkMode)?Colors.red[50]:Colors.red[200],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      elevation: 0.0,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        onTap: () {
                          _showDeleteAccountDialog(context);
                        },
                        title: Text(
                          'Delete Account',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[500],
                            // color: (!StaticData.isDarkMode)?Colors.red[500]:Colors.red,
                          ),
                        ),
                        // tileColor: Colors.red[50],
                        tileColor: (!StaticData.isDarkMode)?Colors.red[50]:Colors.red[200],
                      ),
                    ),
                  ],
                ),
              ),
              // TextButton(
              //   onPressed: () async {
              //     Database db = await DbProvider.instance.database;
              //     // Map<String, dynamic> row = {
              //     //   'MAMUCTIEU': 'MT00001',
              //     //   'NGAYHOANTHANH': 20210529
              //     // };
              //     // Map<String, dynamic> row = {
              //     //   'MAMUCTIEU': 'MT00001',
              //     //   'MANGUOIDUNG': '${StaticData.userID}',
              //     //   'MANHOM': '',
              //     //   'TENMUCTIEU': 'Đọc sách',
              //     //   'MOTA': '',
              //     //   'NGAYBATDAU': 20210524,
              //     //   'LOAIHINH': 'FIXED',
              //     //   'CACNGAY': 1101011
              //     // };
              //     // Map<String, dynamic> row = {
              //     //   'MAMUCTIEU': 'MT00002',
              //     //   'MANGUOIDUNG': '${StaticData.userID}',
              //     //   'MANHOM': '',
              //     //   'TENMUCTIEU': 'Chạy bộ',
              //     //   'MOTA': '',
              //     //   'NGAYBATDAU': 20210524,
              //     //   'LOAIHINH': 'FLEXIBLE',
              //     //   'SOLAN': 3
              //     // };
              //     // Map<String, dynamic> row = {
              //     //   'MAMUCTIEU': 'MT00003',
              //     //   'MANGUOIDUNG': '${StaticData.userID}',
              //     //   'MANHOM': '',
              //     //   'TENMUCTIEU': 'Dọn nhà',
              //     //   'MOTA': '',
              //     //   'NGAYBATDAU': 20210524,
              //     //   'LOAIHINH': 'REPEATING',
              //     //   'KHOANGTHOIGIAN': 5
              //     // };
              //     // Map<String, dynamic> row = {
              //     //   'DADANGNHAP': 0,
              //     //   'MANGUOIDUNG': ''
              //     // };
              //     Map<String, dynamic> row = {
              //       'MATRICHDAN': 'TD005',
              //       'TRICHDAN': 'The will to win, the desire to succeed, the urge to reach your full potential... these are the keys that will unlock the door to personal excellence',
              //       'TACGIA': 'Confucius'
              //     };
              //     print(await db.insert('TRICHDAN', row));
              //
              //     // Database db = await DbProvider.instance.database;
              //     // await db.execute(
              //     //   '''
              //     //   INSERT INTO THONGTINNGUOIDUNG VALUES ('${StaticData.userID}', 'Crack of Dawn', '', 100, 1, 1, 1, '07:00:00', '21:00:00', 0, 0, '');
              //     //   '''
              //     // );
              //     print('Complete insert into table');
              //   },
              //   child: Text(
              //     'Insert',
              //   ),
              // ),
              // TextButton(
              //   onPressed: () async {
              //     Database db = await DbProvider.instance.database;
              //     List<Map<String, dynamic>> queryRows =
              //         await db.query('NGUOIDUNG');
              //     print(queryRows);
              //   },
              //   child: Text(
              //     'Query',
              //   ),
              // ),
              // TextButton(
              //   onPressed: () async {
              //     Database db = await DbProvider.instance.database;
              //     db.execute('''
              //     CREATE TABLE THAMSO (
              //         DADANGNHAP BOOL,
              //         MANGUOIDUNG TEXT,
              //         PRIMARY KEY (DADANGNHAP, MANGUOIDUNG)
              //     );
              //       ''');
              //     // db.execute(
              //     //   '''
              //     //   ALTER TABLE THONGTINNGUOIDUNG
              //     //   ADD COLUMN LOCKPASSCODE TEXT;
              //     //   '''
              //     // );
              //     print('Complete update table');
              //   },
              //   child: Text(
              //     'Update',
              //   ),
              // ),
              // TextButton(
              //   onPressed: () async {
              //     Database db = await DbProvider.instance.database;
              //     db.execute('''
              //       DELETE FROM THONGKE
              //       WHERE MAMUCTIEU = 'MT00001' AND NGAYHOANTHANH = 20210613;
              //       ''');
              //     print('Complete delete');
              //   },
              //   child: Text(
              //     'Delete',
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  _showEditNameDialog(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: (!StaticData.isDarkMode)?Colors.black:Colors.grey),
    );
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            'Edit Name',
            style: TextStyle(color: Colors.blue),
          )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Divider(
                  height: 1,
                  color: Colors.blue,
                ),
                TextField(
                  controller: usernameEditingController,
                  style: TextStyle(fontSize: 18,),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: outlineInputBorder,
                    disabledBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder,
                    focusedErrorBorder: outlineInputBorder,
                    labelText: 'Username',
                    labelStyle: TextStyle(fontSize: 18, color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[400]),
                    hintText: username,
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
                usernameEditingController.clear();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                print('OK');
                if (usernameEditingController.text == '') {
                  Fluttertoast.showToast(msg: 'Please enter username', textColor: Colors.red[300], backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
                }
                else {
                  setState(() {
                    username = usernameEditingController.text;
                  });
                  UpdateUsername(username);
                  usernameEditingController.clear();
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future _showAvatarChoiceDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Choose option",
            style: TextStyle(color: Colors.blue),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // Divider(
                //   height: 1,
                //   color: Colors.blue,
                // ),
                ListTile(
                  onTap: () {
                    _openGallery(context);
                  },
                  title: Text("Gallery"),
                  leading: Icon(
                    Icons.account_box,
                    color: Colors.blue,
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.blue,
                ),
                ListTile(
                  onTap: () {
                    _openCamera(context);
                  },
                  title: Text("Camera"),
                  leading: Icon(
                    Icons.camera,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    // setState(() {
    //   image = Image.file(File(pickedFile.path));
    // });
    if (pickedFile == null) {
      print('Null image');
      return;
    }
    String imgString = base64String(await pickedFile.readAsBytes());
    UpdateUserAvatar('${StaticData.userID}', imgString);
    setState(() {
      image = imageFromBase64String(imgString);
    });
    Navigator.pop(context);
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    // setState(() {
    //   image = Image.file(File(pickedFile.path));
    // });
    if (pickedFile == null) {
      print('Null image');
      return;
    }
    String imgString = base64String(await pickedFile.readAsBytes());
    UpdateUserAvatar('${StaticData.userID}', imgString);
    setState(() {
      image = imageFromBase64String(imgString);
    });
    Navigator.pop(context);
  }

  Future UpdateUsername(String newUsername) async {
    Database db = await DbProvider.instance.database;
    db.execute('''
        UPDATE THONGTINNGUOIDUNG
        SET HOTEN = '$newUsername'
        WHERE MANGUOIDUNG = '${StaticData.userID}';
        ''');
    Fluttertoast.showToast(msg: 'Change username successfully', textColor: Colors.black54, backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
  }

  Future UpdateUserAvatar(String userID, String imageByteString) async {
    Database db = await DbProvider.instance.database;
    db.execute('''
        UPDATE THONGTINNGUOIDUNG
        SET ANH = '$imageByteString'
        WHERE MANGUOIDUNG = '$userID';
        ''');
    Fluttertoast.showToast(msg: 'Change avatar successfully', textColor: Colors.black54, backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  _showSignOutDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
                'Sign Out',
                style: TextStyle(color: Colors.blue),
              )),
          content: SingleChildScrollView(
            child: Center(
              child: Text(
                  'Do you want to sign out?'
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () async {
                StaticData.isSignedIn = false;
                Database db = await DbProvider.instance.database;
                await db.execute(
                    '''
                    UPDATE THAMSO
                    SET DADANGNHAP = 0,
                        MANGUOIDUNG = '';
                    ''');
                StaticData.flutterLocalNotificationsPlugin.cancelAll();
                StaticData.isDarkMode = false;
                StaticData.isPrivacyLockOn = false;
                final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                themeProvider.changeToLightModeWithoutUpdateUser();
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
                Fluttertoast.showToast(msg: 'Sign out successfully', textColor: Colors.black54, backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_SHORT);
                StaticData.userID = '';
              },
            ),
          ],
        );
      },
    );
  }

  _showChangePasswordDialog(BuildContext context) {
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
                'Change Password',
                style: TextStyle(color: (!StaticData.isDarkMode)?Colors.blue:Colors.white),
              )),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          contentPadding: EdgeInsets.fromLTRB(20, 25, 20, 0),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // SizedBox(height: 10,),
                TextField(
                  controller: passwordEditingController,
                  obscureText: true,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: outlineInputBorder,
                    disabledBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder,
                    focusedErrorBorder: outlineInputBorder,
                    labelText: 'Password',
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
                  controller: newPasswordEditingController,
                  obscureText: true,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: outlineInputBorder,
                    disabledBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder,
                    focusedErrorBorder: outlineInputBorder,
                    labelText: 'New Password',
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
                  controller: confirmNewPasswordEditingController,
                  obscureText: true,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: outlineInputBorder,
                    disabledBorder: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder,
                    focusedErrorBorder: outlineInputBorder,
                    labelText: 'Confirm Password',
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
                passwordEditingController.clear();
                newPasswordEditingController.clear();
                confirmNewPasswordEditingController.clear();
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
                if (passwordEditingController.text == '' || newPasswordEditingController.text == '' || confirmNewPasswordEditingController.text == '') {
                  Fluttertoast.showToast(msg: 'Please enter all information needed', textColor: Colors.red[300], backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
                }
                else if (maHoaPassWord(passwordEditingController.text) != queryList[0]['MATKHAU']) {
                  Fluttertoast.showToast(msg: 'Incorrect Password', textColor: Colors.red[300], backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
                }
                else if (newPasswordEditingController.text != confirmNewPasswordEditingController.text) {
                  Fluttertoast.showToast(msg: 'Confirm password does not match', textColor: Colors.red[300], backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
                }
                else {
                  UpdatePassword(newPasswordEditingController.text);
                  //Fluttertoast.showToast(msg: 'Change password successfully', textColor: Colors.black54, backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
                  passwordEditingController.clear();
                  newPasswordEditingController.clear();
                  confirmNewPasswordEditingController.clear();
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  //Dung SHA-512224 băm mk
  String maHoaPassWord(String PassWord){

    var bytes = utf8.encode(PassWord);
    var has = sha512224.convert(bytes);

    String matKhauMaHoa = has.toString();

    return matKhauMaHoa;
  }

  Future UpdatePassword(String newPassword) async {
    String encryptedPasscode = maHoaPassWord(newPassword);
    Database db = await DbProvider.instance.database;
    db.execute('''
        UPDATE NGUOIDUNG
        SET MATKHAU = '$encryptedPasscode'
        WHERE MANGUOIDUNG = '${StaticData.userID}'
        ''');
    Fluttertoast.showToast(msg: 'Change password successfully', textColor: Colors.black54, backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
  }

  _showDeleteAllActivitiesDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
                'Delete All Activities',
                style: TextStyle(color: Colors.blue),
              )),
          content: SingleChildScrollView(
            child: Center(
              child: Text(
                  'Are you sure you want to delete all activities?'
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () async {
                // await _deleteFromTableTHONGKE();
                // await _deleteFromTableNHOMMUCTIEU();
                // await _deleteFromTableMUCTIEU();
                await _deleteAllActivities();
                Fluttertoast.showToast(msg: 'Delete all activities successfully', textColor: Colors.black54, backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  _showDeleteAccountDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
                'Delete Account',
                style: TextStyle(color: Colors.blue),
              )),
          content: SingleChildScrollView(
            child: Center(
              child: Text(
                  'Are you sure you want to delete account?'
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () async {
                // _deleteFromTableTHONGKE();
                // _deleteFromTableNHOMMUCTIEU();
                // _deleteFromTableMUCTIEU();
                // _deleteFromTableLICHSUTIMER();
                // _deleteFromTableTHANHTUUNGUOIDUNG();
                // _deleteFromTableVATPHAMNGUOIDUNG();
                // _deleteFromTablePOKEMON();
                // _deleteFromTableTHONGTINNGUOIDUNG();
                // _deleteFromTableNGUOIDUNG();
                _deleteAccount();
                Fluttertoast.showToast(msg: 'Delete account successfully', textColor: Colors.black54, backgroundColor: Colors.grey[100], toastLength: Toast.LENGTH_LONG);
                StaticData.isSignedIn = false;
                Database db = await DbProvider.instance.database;
                await db.execute(
                    '''
                    UPDATE THAMSO
                    SET DADANGNHAP = 0,
                        MANGUOIDUNG = '';
                    ''');
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
                StaticData.userID = '';
              },
            ),
          ],
        );
      },
    );
  }

  _deleteAllActivities() async {
    try{
      await _deleteFromTableTHONGKE();
      await _deleteFromTableNHOMMUCTIEU();
      await _deleteFromTableMUCTIEU();
    }
    catch(e) {
      print(e.toString());
    }

  }

  _deleteAccount() async {
    try {
      _deleteFromTableTHONGKE();
      _deleteFromTableNHOMMUCTIEU();
      _deleteFromTableMUCTIEU();
      _deleteFromTableLICHSUTIMER();
      _deleteFromTableTHANHTUUNGUOIDUNG();
      _deleteFromTableVATPHAMNGUOIDUNG();
      _deleteFromTablePOKEMON();
      _deleteFromTableTHONGTINNGUOIDUNG();
      _deleteFromTableNGUOIDUNG();
    }
    catch(e) {
      print(e.toString());
    }
  }

  _deleteFromTableTHONGKE() async {
    Database db = await DbProvider.instance.database;
    await db.execute('''
        DELETE FROM THONGKE
        WHERE MAMUCTIEU IN (SELECT MAMUCTIEU FROM MUCTIEU WHERE MANGUOIDUNG = '${StaticData.userID}')
        ''');
  }

  _deleteFromTableNHOMMUCTIEU() async {
    Database db = await DbProvider.instance.database;
    await db.execute('''
        DELETE FROM NHOMMUCTIEU
        WHERE MANGUOIDUNG = '${StaticData.userID}'
        ''');
  }

  _deleteFromTableMUCTIEU() async {
    Database db = await DbProvider.instance.database;
    await db.execute('''
        DELETE FROM MUCTIEU
        WHERE MANGUOIDUNG = '${StaticData.userID}'
        ''');
  }

  _deleteFromTableLICHSUTIMER() async {
    Database db = await DbProvider.instance.database;
    await db.execute('''
        DELETE FROM LICHSUTIMER
        WHERE MANGUOIDUNG = '${StaticData.userID}'
        ''');
  }

  _deleteFromTableNGUOIDUNG() async {
    Database db = await DbProvider.instance.database;
    await db.execute('''
        DELETE FROM NGUOIDUNG
        WHERE MANGUOIDUNG = '${StaticData.userID}'
        ''');
  }

  _deleteFromTableTHANHTUUNGUOIDUNG() async {
    Database db = await DbProvider.instance.database;
    await db.execute('''
        DELETE FROM THANHTUUNGUOIDUNG
        WHERE MANGUOIDUNG = '${StaticData.userID}'
        ''');
  }

  _deleteFromTableTHONGTINNGUOIDUNG() async {
    Database db = await DbProvider.instance.database;
    await db.execute('''
        DELETE FROM THONGTINNGUOIDUNG
        WHERE MANGUOIDUNG = '${StaticData.userID}'
        ''');
  }

  _deleteFromTablePOKEMON() async {
    Database db = await DbProvider.instance.database;
    await db.execute('''
        DELETE FROM POKEMON
        WHERE MANGUOIDUNG = '${StaticData.userID}'
        ''');
  }

  _deleteFromTableVATPHAMNGUOIDUNG() async {
    Database db = await DbProvider.instance.database;
    await db.execute('''
        DELETE FROM VATPHAMNGUOIDUNG
        WHERE MANGUOIDUNG = '${StaticData.userID}'
        ''');
  }

}
