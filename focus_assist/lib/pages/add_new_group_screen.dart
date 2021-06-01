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
    // TODO: implement initState
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
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)), //this right here
        child: Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: getGroupName,
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(28),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1, color: Colors.blue),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1, color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1, color: Colors.blue),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Colors.blue)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Colors.blue)),
                    border: OutlineInputBorder(),
                    labelText: 'Group Name',
                    labelStyle: TextStyle(color: Colors.blue, fontSize: 23)),
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
            (isOK)
                ? SizedBox()
                : Center(
                    child: Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  )),
            ElevatedButton(
              onPressed: () {
                if (getGroupName.text == null || getGroupName.text.length < 1) {
                  setState(() {
                    isOK = false;
                  });
                  print("Fuck");
                } else {
                  Navigator.pop(context);
                }
              },
              child: Text(
                "Create",
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        )));
  }
}
