import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'dart:math';

import 'package:focus_assist/pages/statistic/add_new_group_dialog.dart';

class AddNew extends StatefulWidget {
  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  final dbHelper = DbProvider.instance;
  String dropDownValue;
  DateTime startTime;
  List<String> dayOfWeek;
  List<bool> checkDay;
  List<String> allGroup;
  List<String> allGroupKey;
  // Những biến để get Text
  TextEditingController getActivity, getDescription;
  //Biến để getText của Flexible
  int dayPerWeek;
  TextEditingController getDayPerWeek;
  //Biến để gettext Repeating
  int repeatingDay;
  TextEditingController getRepeatingDay;

  //Dùng để debug
  String text = 'Fuck', text2 = "FUCK", text3 = "SHIT", text4 = 'text4';

  //Dùng để cho việc chọn nhóm:
  String dropDownGroup;
  bool newGroup;

  bool isFailed = false;
  @override
  void initState() {
    newGroup = false;
    allGroup = ['Choose a group'];
    dropDownGroup = allGroup[0];
    allGroupKey = ['None'];
    super.initState();
    dropDownValue = 'Fixed';
    startTime = DateTime.now();
    dayOfWeek = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
    checkDay = [true, true, true, true, true, true, true];
    getActivity = TextEditingController();
    getDescription = TextEditingController();
    getDayPerWeek = TextEditingController();
    getRepeatingDay = TextEditingController();
    getAllGroup();
  }

  //Hàm tạo string random để Tạo khoá
  String getRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  // List các hàm tạo các widget phù hợp với từng loại hoạt động
  // ignore: non_constant_identifier_names
  List<Widget> Flexible() {
    return <Widget>[
      Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
              child: Text(
                "How often do you want to perform the activity: ",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 70,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: getDayPerWeek,
                          decoration: InputDecoration(hintText: 'days'),
                          style: TextStyle(fontSize: 20),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("per week", style: TextStyle(fontSize: 20))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ];
  }

  // ignore: non_constant_identifier_names
  List<Widget> Fixed() {
    return <Widget>[
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Text("Select the day you want to do the activity:",
                style: TextStyle(fontSize: 17)),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                  height: 50,
                  width: 370,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dayOfWeek.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (this.mounted) {
                            setState(() {
                              checkDay[index] = !checkDay[index];
                            });
                          } else
                            return;
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: checkDay[index]
                                  ? Color(0xff8A2BE2)
                                  : Color(0xffF0FFF0),
                              border: Border(
                                  bottom: BorderSide(
                                      color: !checkDay[index]
                                          ? Color(0xff8A2BE2)
                                          : Color(0xffF0FFF0),
                                      width: 1),
                                  top: BorderSide(
                                      color: !checkDay[index]
                                          ? Color(0xff8A2BE2)
                                          : Color(0xffF0FFF0),
                                      width: 1),
                                  right: BorderSide(
                                      color: !checkDay[index]
                                          ? Color(0xff8A2BE2)
                                          : Color(0xffF0FFF0),
                                      width: 1),
                                  left: BorderSide(
                                      color: !checkDay[index]
                                          ? Color(0xff8A2BE2)
                                          : Color(0xffF0FFF0),
                                      width: (index == 0) ? 1 : 0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(dayOfWeek[index],
                                  style: TextStyle(
                                      color: !checkDay[index]
                                          ? Color(0xff8A2BE2)
                                          : Color(0xffF0FFF0))),
                            )),
                      );
                    },
                  )),
            ),
          ),
        ],
      )
    ];
  }

  // ignore: non_constant_identifier_names
  List<Widget> Repeating() {
    return <Widget>[
      SizedBox(
        height: 10,
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Repeating every", style: TextStyle(fontSize: 20)),
              SizedBox(width: 20),
              Container(
                width: 70,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: getRepeatingDay,
                  decoration: InputDecoration(hintText: 'num'),
                  style: TextStyle(fontSize: 20),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              Text("day", style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      )
    ];
  }

  Future<bool> checkValidActivity() async {
    // Trường hợp nhập thiếu activity name
    if (getActivity.text == null || getActivity.text.length < 1) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Message"),
                content: Text("Activity name can't be left blank !"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'OK');
                    },
                    child: Text("OK"),
                  )
                ],
              ));
      return false;
    }
    // Nhập desciption(không bắt buộc)
    if (getDescription.text == null || getDescription.text.length < 1) {
      bool k = await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Message"),
                content:
                    Text("Are you sure not to add description to activity ?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text("Yes"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text("No"),
                  )
                ],
              ));
      if (k == false) return k;
    }

    // Trường hợp nhập sai của Flexible
    if (dropDownValue == 'Flexible') {
      if (getDayPerWeek.text.length < 1 || getDayPerWeek.text == null) {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text("Message"),
                  content: Text("Days per week can't left blanked"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"),
                    )
                  ],
                ));
        return false;
      } else {
        int times = int.parse(getDayPerWeek.text);
        if (times > 7 || times < 1) {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: Text("Message"),
                    content: Text(
                        "Days per week can't greater than 7 or less than 1"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("OK"),
                      )
                    ],
                  ));
          return false;
        }
      }
    }
    // Trường hợp nhập sai của repeating
    else if (dropDownValue == 'Repeating') {
      if (getRepeatingDay.text == null || getRepeatingDay.text.length < 1) {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text("Message"),
                  content: Text("Days repeating can't left blanked"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"),
                    )
                  ],
                ));
        return false;
      } else {
        int days = int.parse(getRepeatingDay.text);
        if (days < 1) {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: Text("Message"),
                    content: Text("Days repeating can't be 0"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("OK"),
                      )
                    ],
                  ));
          return false;
        }
      }
    }
    // Trường hợp thiếu nhóm:
    if (dropDownGroup == 'Choose a group') {
      bool k = await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Message"),
                content:
                    Text("Are you sure to not add this activity to a group ?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text("Yes"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text("No"),
                  )
                ],
              ));
      if (k == false) return k;
    }
    return true;
  }

  // Các hàm thực hiện các việc liên quan đến dữ liệu
  Future<void> addActivity() async {
    bool valid = await checkValidActivity();
    isFailed = !valid;
    if (valid == false) return;
    Map<String, dynamic> row = {
      'MAMUCTIEU': getRandomString(5),
      'MANGUOIDUNG':
          (StaticData.userID == null) ? 'MANGUOIDUNG' : StaticData.userID,
      'MANHOM': allGroupKey[allGroup.indexOf(dropDownGroup)],
      'TENMUCTIEU': getActivity.text,
      'MOTA': (getDescription.text == null) ? 'MOTA' : getDescription.text,
      'NGAYBATDAU': dateTimeToInt(startTime),
      'LOAIHINH': dropDownValue,
    };
    if (dropDownValue == 'Fixed') {
      String fixedDay = "";
      for (int i = 0; i < dayOfWeek.length; i++) {
        if (checkDay[i] == false) {
          fixedDay += '0';
        } else
          fixedDay += '1';
      }
      row['CACNGAY'] = int.parse(fixedDay);
    } else if (dropDownValue == 'Flexible') {
      int times = int.parse(getDayPerWeek.text);
      row['SOLAN'] = times;
    } else if (dropDownValue == 'Repeating') {
      row['KHOANGTHOIGIAN'] = getRepeatingDay.text;
    }
    if (this.mounted) {
      setState(() {
        text = row.toString();
      });
    } else
      return;

    final id = await dbHelper.insert('MUCTIEU', row);
    print('inserted row id: $id');
  }

  Future<void> getAllGroup() async {
    String userID = StaticData.userID;
    List<Map<String, dynamic>> database = await dbHelper
        .rawQuery('''select * from NHOMMUCTIEU where MANGUOIDUNG='$userID' ''');
    if (this.mounted) {
      setState(() {
        text2 = database.toString();
      });
    } else
      return;

    // setState(() {
    //   allGroup = [];
    //   allGroupKey = [];
    // });
    while (allGroup.length > 1) {
      allGroup.removeLast();
      allGroupKey.removeLast();
    }
    for (int i = 0; i < database.length; i++) {
      allGroupKey.add(database[i]['MANHOM']);
      allGroup.add(database[i]['TENNHOM']);
    }

    if (allGroup.length == 0) {
      if (this.mounted) {
        setState(() {
          allGroup = ['None', 'None1', 'None2'];
          dropDownValue = allGroup[0];
        });
      } else
        return;
    }
  }

  int dateTimeToInt(DateTime dateTime) {
    return dateTime.year * 10000 + dateTime.month * 100 + dateTime.day;
  }

  DateTime intToDateTime(int dateTimeInt) {
    int year = (dateTimeInt / 10000).floor();
    int month = (dateTimeInt / 100).floor() % 100;
    int day = dateTimeInt % 100;
    return DateTime(year, month, day);
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder k = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Colors.white),
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff8A2BE2),
          title: Text("Add new activity", style: TextStyle(fontSize: 25)),
          actions: [
            TextButton(
                onPressed: () async {
                  await addActivity();
                  if (isFailed) {
                  } else
                    Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    "Create",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ))
          ],
          elevation: 1,
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            // Thêm tên của activity và các description
            Container(
                decoration: BoxDecoration(
                    color: Color(0xff8A2BE2),
                    borderRadius: BorderRadius.all(Radius.circular(0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: getActivity,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                          labelText: 'Activity Name',
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: k,
                          disabledBorder: k,
                          enabledBorder: k,
                          errorBorder: k,
                          focusedErrorBorder: k,
                        ),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Description
                      TextField(
                        controller: getDescription,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(18),
                            focusedBorder: k,
                            disabledBorder: k,
                            enabledBorder: k,
                            errorBorder: k,
                            focusedErrorBorder: k,
                            border: OutlineInputBorder(),
                            labelText: 'Description',
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        maxLines: 3,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                child: Center(
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Text(
                      "Start date: ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      startTime.toString().substring(0, 10),
                      style: TextStyle(fontSize: 20),
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.date_range),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: startTime,
                                firstDate: DateTime.utc(2020, 1, 1),
                                lastDate: DateTime.utc(2120, 31, 12))
                            .then((date) {
                          if (this.mounted) {
                            setState(() {
                              if (date != null) startTime = date;
                            });
                          } else
                            return;
                        });
                      },
                      label: Text(""),
                    )
                  ]),
                ),
              ),
            ),

            Divider(
              height: 10,
              color: Colors.black,
            ),
            //Chọn group của các activity
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Group",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  DropdownButton<String>(
                    value: dropDownGroup,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    iconSize: 24,
                    elevation: 16,
                    style:
                        const TextStyle(color: Colors.deepPurple, fontSize: 20),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      if (this.mounted) {
                        setState(() {
                          dropDownGroup = newValue;
                        });
                      } else
                        return;
                    },
                    items:
                        allGroup.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () async {
                      bool l = await showDialog(
                        context: context,
                        builder: (_) => AddGroup(),
                      );
                      await getAllGroup();
                      print(l);
                      if (l != null && l == true) {
                        if (this.mounted) {
                          setState(() {
                            dropDownGroup = allGroup[allGroup.length - 1];
                          });
                        }
                      }
                    },
                    child: Text(
                      "New",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ],
              ),
            ),
            // Bảng chọn loại của cái activity
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Select type",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  DropdownButton<String>(
                    value: dropDownValue,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    iconSize: 24,
                    elevation: 16,
                    style:
                        const TextStyle(color: Colors.deepPurple, fontSize: 20),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      if (this.mounted) {
                        setState(() {
                          dropDownValue = newValue;
                        });
                      } else
                        return;
                    },
                    items: <String>['Fixed', 'Flexible', 'Repeating']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (dropDownValue == 'Fixed')
                    ? Fixed()
                    : (dropDownValue == 'Flexible')
                        ? Flexible()
                        : Repeating()),
            debugWidget(),
          ],
        ));
  }

  Widget debugWidget() {
    return Column(
      children: [
        Text(StaticData.userID == null ? "NGUOIDUNG" : StaticData.userID),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text, style: TextStyle(fontSize: 30)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                getAllGroup();
              },
              child: Text(text2, style: TextStyle(fontSize: 30))),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () async {
                List<Map<String, dynamic>> data = await dbHelper
                    .rawQuery('''select * from THONGTINNGUOIDUNG''');
                if (this.mounted) {
                  setState(() {
                    text3 = data.toString();
                  });
                } else
                  return;
              },
              child: Text(text3, style: TextStyle(fontSize: 30))),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () async {
                // Thêm người dùng và bảng thông tin người dùng vào database
                Map<String, dynamic> row = {'MANGUOIDUNG': 'NGUOIDUNG'};
                final id = await dbHelper.insert('NGUOIDUNG', row);
                print('inserted row NGUOIDUNG id: $id');
                row = {'MANGUOIDUNG': 'NGUOIDUNG', 'VANG': 0};
                final id2 = await dbHelper.insert('THONGTINNGUOIDUNG', row);
                print('inserted THONGTINNGUOIDUNG row id: $id2');
              },
              child: Text(text4, style: TextStyle(fontSize: 30))),
        ),
        TextButton(
            onPressed: () {
              dbHelper.rawQuery('''delete from NHOMMUCTIEU''');
            },
            child: Text("DELETE NHOMMUCTIEU", style: TextStyle(fontSize: 30))),
        TextButton(
            onPressed: () {
              dbHelper.rawQuery('''delete from MUCTIEU''');
            },
            child: Text("DELETE MUCTIEU", style: TextStyle(fontSize: 30))),
        TextButton(
            onPressed: () {
              dbHelper.rawQuery('''delete from THANHTUU''');
              dbHelper.rawQuery('''delete from THANHTUUNGUOIDUNG''');
            },
            child: Text("DELETE THANHTUU", style: TextStyle(fontSize: 30))),
        Text(
          allGroup.toString(),
          style: TextStyle(fontSize: 20),
        )
      ],
    );
  }
}
