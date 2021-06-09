import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:focus_assist/classes/Data.dart';
import 'package:flutter/material.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:focus_assist/pages/login/screen/welcome_screen.dart';

class AccountSettingScreen extends StatefulWidget {
  @override
  _AccountSettingScreenState createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  String username = 'Username';
  Image image;
  TextEditingController usernameEditingController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      backgroundColor: Colors.white,
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
                            backgroundColor: Colors.white,
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
                                _showEditUsernameDialog(context);
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
                                      color: Colors.blue,
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
                                      color: Colors.blue,
                                    ),
                                    Text('   Edit Username'),
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
                        color: Colors.grey[700],
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
                            color: Colors.blue[500],
                          ),
                        ),
                        tileColor: Colors.blue[50],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      elevation: 0.0,
                      child: ListTile(
                        onTap: () {},
                        title: Text(
                          'Change Password',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[500],
                          ),
                        ),
                        tileColor: Colors.blue[50],
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
                        onTap: () {},
                        title: Text(
                          'Delete Data',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[500],
                          ),
                        ),
                        tileColor: Colors.red[50],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      elevation: 0.0,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        onTap: () {},
                        title: Text(
                          'Delete Account',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[500],
                          ),
                        ),
                        tileColor: Colors.red[50],
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  Database db = await DbProvider.instance.database;
                  // Map<String, dynamic> row = {
                  //   'MAMUCTIEU': 'MT00001',
                  //   'NGAYHOANTHANH': 20210529
                  // };
                  // Map<String, dynamic> row = {
                  //   'MAMUCTIEU': 'MT00001',
                  //   'MANGUOIDUNG': '${StaticData.userID}',
                  //   'MANHOM': '',
                  //   'TENMUCTIEU': 'Đọc sách',
                  //   'MOTA': '',
                  //   'NGAYBATDAU': 20210524,
                  //   'LOAIHINH': 'FIXED',
                  //   'CACNGAY': 1101011
                  // };
                  // Map<String, dynamic> row = {
                  //   'MAMUCTIEU': 'MT00002',
                  //   'MANGUOIDUNG': '${StaticData.userID}',
                  //   'MANHOM': '',
                  //   'TENMUCTIEU': 'Chạy bộ',
                  //   'MOTA': '',
                  //   'NGAYBATDAU': 20210524,
                  //   'LOAIHINH': 'FLEXIBLE',
                  //   'SOLAN': 3
                  // };
                  // Map<String, dynamic> row = {
                  //   'MAMUCTIEU': 'MT00003',
                  //   'MANGUOIDUNG': '${StaticData.userID}',
                  //   'MANHOM': '',
                  //   'TENMUCTIEU': 'Dọn nhà',
                  //   'MOTA': '',
                  //   'NGAYBATDAU': 20210524,
                  //   'LOAIHINH': 'REPEATING',
                  //   'KHOANGTHOIGIAN': 5
                  // };
                  Map<String, dynamic> row = {
                    'MAMUCTIEU': 'MT00001',
                    'NGAYHOANTHANH': 20210713
                  };
                  print(await db.insert('THONGKE', row));

                  // Database db = await DbProvider.instance.database;
                  // await db.execute(
                  //   '''
                  //   INSERT INTO THONGTINNGUOIDUNG VALUES ('${StaticData.userID}', 'Crack of Dawn', '', 100, 1, 1, 1, '07:00:00', '21:00:00', 0, 0, '');
                  //   '''
                  // );
                  print('Complete insert into table');
                },
                child: Text(
                  'Insert',
                ),
              ),
              TextButton(
                onPressed: () async {
                  Database db = await DbProvider.instance.database;
                  List<Map<String, dynamic>> queryRows =
                      await db.query('MUCTIEU');
                  print(queryRows);
                },
                child: Text(
                  'Query',
                ),
              ),
              TextButton(
                onPressed: () async {
                  Database db = await DbProvider.instance.database;
                  db.execute('''
                  CREATE TABLE MUCTIEU (
                      MAMUCTIEU TEXT PRIMARY KEY,
                      MANGUOIDUNG TEXT,
                      MANHOM TEXT,
                      TENMUCTIEU TEXT,
                      MOTA TEXT,
                      NGAYBATDAU INTEGER,
                      LOAIHINH TEXT,
                      CACNGAY INTEGER,
                      SOLAN INTEGER,
                      KHOANGTHOIGIAN INTEGER
                  );
                    ''');
                  // db.execute(
                  //   '''
                  //   ALTER TABLE THONGTINNGUOIDUNG
                  //   ADD COLUMN LOCKPASSCODE TEXT;
                  //   '''
                  // );
                  print('Complete update table');
                },
                child: Text(
                  'Update',
                ),
              ),
              TextButton(
                onPressed: () async {
                  Database db = await DbProvider.instance.database;
                  db.execute('''
                    DELETE FROM THONGKE
                    WHERE MAMUCTIEU = 'MT00001' AND NGAYHOANTHANH = 20210613;
                    ''');
                  print('Complete delete');
                },
                child: Text(
                  'Delete',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showEditUsernameDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            'Edit Username',
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    //labelText: 'Username',
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
                setState(() {
                  usernameEditingController.clear();
                });
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                print('OK');
                setState(() {
                  username = usernameEditingController.text;
                });
                UpdateUsername('${StaticData.userID}'); // user.getID()
                Navigator.pop(context);
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
                Divider(
                  height: 1,
                  color: Colors.blue,
                ),
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
    String imgString = base64String(await pickedFile.readAsBytes());
    UpdateUserAvatar('${StaticData.userID}', imgString);
    setState(() {
      image = imageFromBase64String(imgString);
    });
    Navigator.pop(context);
  }

  Future UpdateUsername(String userID) async {
    Database db = await DbProvider.instance.database;
    db.execute('''
        UPDATE THONGTINNGUOIDUNG
        SET HOTEN = '$username'
        WHERE MANGUOIDUNG = '$userID';
        ''');
  }

  Future UpdateUserAvatar(String userID, String imageByteString) async {
    Database db = await DbProvider.instance.database;
    db.execute('''
        UPDATE THONGTINNGUOIDUNG
        SET ANH = '$imageByteString'
        WHERE MANGUOIDUNG = '$userID';
        ''');
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
          // content: SingleChildScrollView(
          //   child: ListBody(
          //     children: <Widget>[
          //       // Divider(
          //       //   height: 1,
          //       //   color: Colors.blue,
          //       // ),
          //       SizedBox(
          //         height: 20,
          //         child: Text(
          //           'Do you want to sign out?'
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
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
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

}
