import 'package:flutter/material.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'dart:math';
import 'package:focus_assist/classes/Data.dart';

class AddGroup extends StatefulWidget {
  @override
  _AddGroupState createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  TextEditingController getGroupName;
  String error = "Group name can't be blanked";
  final dbHelper = DbProvider.instance;
  bool isOK;

  @override
  void initState() {
    super.initState();
    getGroupName = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder k = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Colors.black87),
    );
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Text(
              'Add new group',
              style: TextStyle(fontSize: 25, color: Colors.black87),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
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
                    labelStyle: TextStyle(color: Colors.black87, fontSize: 23)),
                style: TextStyle(fontSize: 20, color: Colors.black87),
              ),
            ),
            (isOK)
                ? SizedBox()
                : Center(
                    child: Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  )),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
              decoration: BoxDecoration(
                  color: Color(0xffe0e6ee),
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
                    AddNewGroup();
                    Navigator.pop(context);
                  }
                },
                child: Text('Create',
                    style: TextStyle(fontSize: 20, color: Colors.black87)),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        )));
  }
}
