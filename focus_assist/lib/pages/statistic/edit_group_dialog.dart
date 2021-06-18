import 'package:flutter/material.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'dart:math';
import 'package:focus_assist/classes/Data.dart';

class EditGroup extends StatefulWidget {
  final String groupKey, groupName;

  EditGroup({Key key, this.groupKey, this.groupName}) : super(key: key);
  @override
  _EditGroupState createState() => _EditGroupState();
}

class _EditGroupState extends State<EditGroup> {
  TextEditingController getGroupName;
  String error = "Group name can't be blank";
  final dbHelper = DbProvider.instance;
  bool isOK;

  @override
  void initState() {
    super.initState();
    getGroupName = TextEditingController(text: widget.groupName);
    isOK = true;
  }

//Hàm tạo string random để Tạo khoá
  String getRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  // ignore: non_constant_identifier_names
  void AddNewGroup() async {
    Map<String, dynamic> row = {
      'MANHOM': getRandomString(5),
      'TENNHOM': getGroupName.text,
      'MANGUOIDUNG': StaticData.userID,
    };
    final id = await dbHelper.insert('NHOMMUCTIEU', row);
    print('inserted row id: $id');
  }

  void editGroup() async {
    String newName = getGroupName.text;
    String key = widget.groupKey;
    await dbHelper.rawQuery(
        '''update NHOMMUCTIEU set TENNHOM='$newName' where MANHOM='$key'  ''');
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder k = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: (!StaticData.isDarkMode)?Colors.black:Colors.grey),
    );
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 15),
            Text(
              'Edit group',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
              child: TextField(
                controller: getGroupName,
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(18),
                    focusedBorder: k,
                    disabledBorder: k,
                    enabledBorder: k,
                    errorBorder: k,
                    focusedErrorBorder: k,
                    border: OutlineInputBorder(),
                    labelText: 'Group Name',
                    labelStyle: TextStyle(fontSize: 20, color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[400])
                ),
                style: TextStyle(fontSize: 20,),
              ),
            ),
            (isOK)
                ? SizedBox()
                : Center(
                    child: Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  )),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 100,
              padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
              decoration: BoxDecoration(
                  // color: Color(0xffe0e6ee),
                  color: (!StaticData.isDarkMode)?Colors.grey[200]:Colors.grey[700],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: InkWell(
                onTap: () {
                  if (getGroupName.text == null ||
                      getGroupName.text.length < 1) {
                    if (this.mounted) {
                      setState(() {
                        isOK = false;
                      });
                    } else
                      return;

                    print("Fuck");
                  } else {
                    editGroup();
                    Navigator.pop(context);
                  }
                },
                child: Center(
                  child: Text('Finish',
                      style: TextStyle(fontSize: 20,)),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            )
          ],
        )));
  }
}
