import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';

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
    List<dynamic> whereArguments = ['ND001'];
    List<Map<String, dynamic>> queryRows = await db.query('THONGTINNGUOIDUNG', where: 'MANGUOIDUNG = ?', whereArgs: whereArguments);
    if (queryRows.first['HOTEN'] == null || queryRows.first['HOTEN'] == '') return;
    try {
      setState(() {
        username = queryRows.first['HOTEN'];
      });
    }
    catch (e) {
      print('Error setting username: $e');
    }
  }

  Future<void> LoadUserImage() async {
    Database db = await DbProvider.instance.database;
    List<dynamic> whereArguments = ['ND001'];
    List<Map<String, dynamic>> queryRows = await db.query('THONGTINNGUOIDUNG', where: 'MANGUOIDUNG = ?', whereArgs: whereArguments);
    if (queryRows.first['ANH'] == null || queryRows.first['ANH'] == '') return;
    try {
      setState(() {
        image = imageFromBase64String(queryRows.first['ANH']);
      });
    }
    catch (e) {
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
                    children: <Widget> [
                      Container(
                        alignment: Alignment.topLeft,
                        width: 100.0,
                        child: BackButton(),
                      ),
                      Container(
                        width: 100.0,
                        child: Center(
                          child: CircleAvatar(
                            backgroundImage: (image == null)?AssetImage('assets/default.png'):null,
                            backgroundColor: Colors.white,
                            radius: 50.0,
                            child: ClipRRect(
                              child: (image != null)?image:null,
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
                          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
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
              Divider(height: 40.0, thickness: 1.5,),
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
                    SizedBox(height: 10.0,),
                    Card(
                      shape: RoundedRectangleBorder(),
                      elevation: 0.0,
                      child: ListTile(
                        onTap: () {},
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
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
                    SizedBox(height: 20.0,),
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
                    SizedBox(height: 10.0,),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      elevation: 0.0,
                      child: ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
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
                  Map<String, dynamic> row = {
                    'MAMUCTIEU': 'MT00003',
                    'MANGUOIDUNG': 'ND001',
                    'MANHOM': '',
                    'TENMUCTIEU': 'Dọn nhà',
                    'MOTA': '',
                    'NGAYBATDAU': '15/5/2021',
                    'LOAIHINH': 'REPEATING',
                    'KHOANGTHOIGIAN': 5
                  };
                  print(await db.insert('MUCTIEU', row));

                  // Database db = await DbProvider.instance.database;
                  // await db.execute(
                  //   '''
                  //   INSERT INTO THONGTINNGUOIDUNG VALUES ('ND001', 'Crack of Dawn', '', 100, 1, 1, 1, '07:00:00', '21:00:00', 0, 0, '');
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
                  List<Map<String, dynamic>> queryRows = await db.query('MUCTIEU');
                  print (queryRows);
                },
                child: Text(
                  'Query',
                ),
              ),
              TextButton(
                onPressed: () async {
                  Database db = await DbProvider.instance.database;
                  db.execute(
                    '''
                    INSERT INTO NGUOIDUNG VALUES ('ND001', 'ND001', 'ND001');
                    '''
                  );
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
                  // db.execute(
                  //   '''
                  //   ALTER TABLE THONGTINNGUOIDUNG
                  //   ADD COLUMN THONGBAO BOOL;
                  //   '''
                  // );
                  // db.execute(
                  //   '''
                  //   ALTER TABLE THONGTINNGUOIDUNG
                  //   ADD COLUMN THONGBAOSANG BOOL;
                  //   '''
                  // );
                  // db.execute(
                  //   '''
                  //   ALTER TABLE THONGTINNGUOIDUNG
                  //   ADD COLUMN THONGBAOTOI BOOL;
                  //   '''
                  // );
                  // db.execute(
                  //   '''
                  //   ALTER TABLE THONGTINNGUOIDUNG
                  //   ADD COLUMN THOIGIANTHONGBAOSANG TIME;
                  //   '''
                  // );
                  // db.execute(
                  //   '''
                  //   ALTER TABLE THONGTINNGUOIDUNG
                  //   ADD COLUMN THOIGIANTHONGBAOTOI TIME;
                  //   '''
                  // );
                  // db.execute(
                  //   '''
                  //   ALTER TABLE THONGTINNGUOIDUNG
                  //   ADD COLUMN DARKMODE BOOL;
                  //   '''
                  // );
                  // db.execute(
                  //   '''
                  //   UPDATE THONGTINNGUOIDUNG
                  //   SET THONGBAO = TRUE, THONGBAOSANG = TRUE, THONGBAOTOI = TRUE,
                  //       THOIGIANTHONGBAOSANG = '07:00:00', THOIGIANTHONGBAOTOI = '21:00:00',
                  //       DARKMODE = FALSE
                  //   WHERE MANGUOIDUNG = 'ND001';
                  //   '''
                  // );
                  db.execute(
                    '''
                    DELETE FROM MUCTIEU;
                    '''
                  );
                  print('Complete drop table');
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
          title: Center(child: Text('Edit Username', style: TextStyle(color: Colors.blue),)),
          content: SingleChildScrollView (
            child: ListBody(
              children: <Widget>[
                Divider(height: 1,color: Colors.blue,),
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
                UpdateUsername('ND001');    // user.getID()
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future _showAvatarChoiceDialog(BuildContext context)
  {
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: Text("Choose option",style: TextStyle(color: Colors.blue),),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Divider(height: 1,color: Colors.blue,),
              ListTile(
                onTap: (){
                  _openGallery(context);
                },
                title: Text("Gallery"),
                leading: Icon(Icons.account_box,color: Colors.blue,),
              ),
              Divider(height: 1,color: Colors.blue,),
              ListTile(
                onTap: (){
                  _openCamera(context);
                },
                title: Text("Camera"),
                leading: Icon(Icons.camera,color: Colors.blue,),
              ),
            ],
          ),
        ),);
    });
  }

  void _openCamera(BuildContext context)  async{
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    // setState(() {
    //   image = Image.file(File(pickedFile.path));
    // });
    String imgString = base64String(await pickedFile.readAsBytes());
    UpdateUserAvatar('ND001', imgString);
    setState(() {
      image = imageFromBase64String(imgString);
    });
    Navigator.pop(context);
  }

  void _openGallery(BuildContext context) async{
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    // setState(() {
    //   image = Image.file(File(pickedFile.path));
    // });
    String imgString = base64String(await pickedFile.readAsBytes());
    UpdateUserAvatar('ND001', imgString);
    setState(() {
      image = imageFromBase64String(imgString);
    });
    Navigator.pop(context);
  }

  Future UpdateUsername(String userID) async {
    Database db = await DbProvider.instance.database;
    db.execute(
        '''
        UPDATE THONGTINNGUOIDUNG
        SET HOTEN = '$username'
        WHERE MANGUOIDUNG = '$userID';
        '''
    );
  }

  Future UpdateUserAvatar(String userID, String imageByteString) async {
    Database db = await DbProvider.instance.database;
    db.execute(
        '''
        UPDATE THONGTINNGUOIDUNG
        SET ANH = '$imageByteString'
        WHERE MANGUOIDUNG = '$userID';
        '''
    );
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
}
