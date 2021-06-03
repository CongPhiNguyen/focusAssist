import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'dart:math';
import 'package:focus_assist/pages/add_new_group_dialog.dart';

class EditActivity extends StatefulWidget {
  final String activityKey, activityName;

  EditActivity({Key key, this.activityKey, this.activityName})
      : super(key: key);
  @override
  _EditActivityState createState() => _EditActivityState();
}

class _EditActivityState extends State<EditActivity> {
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
  String text = 'Fuck', text2 = "FUCK";

  //Dùng để cho việc chọn nhóm:
  String dropDownGroup;
  bool newGroup;
  @override
  void initState() {
    newGroup = false;
    allGroup = ['Choose a group'];
    dropDownGroup = allGroup[0];
    allGroupKey = ['None'];
    // TODO: implement initState
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
    getAllInformation();
  }

  //Load lại các thông tin của activity vào cái form
  void getAllInformation() async {
    String activityKey = widget.activityKey;
    List<Map<String, dynamic>> database = await dbHelper.rawQuery('''
        select * from MUCTIEU where MAMUCTIEU='$activityKey'
    ''');
    String groupKey;
    if (database.length > 0) {
      setState(() {
        getActivity = TextEditingController(text: database[0]['TENMUCTIEU']);
        getDescription = TextEditingController(text: database[0]['MOTA']);
        groupKey = database[0]['MANHOM'];
        startTime = DateTime.parse(
            database[0]['NGAYBATDAU'].toString().replaceAll('/', '-'));
      });
      String type = database[0]['LOAIHINH'];
      if (type == 'Fixed') {
        setState(() {
          dropDownValue = 'Fixed';
        });
        String cacNgay = database[0]['CACNGAY'].toString();
        while (cacNgay.length < 7) {
          cacNgay = '0' + cacNgay;
        }
        for (int i = 0; i < 7; i++) {
          setState(() {
            checkDay[i] = (cacNgay[i] == '1') ? true : false;
          });
        }
      } else if (type == 'Flexible') {
        setState(() {
          dropDownValue = 'Flexible';
          getDayPerWeek =
              TextEditingController(text: database[0]['SOLAN'].toString());
        });
      } else if (type == 'Repeating') {
        setState(() {
          dropDownValue = 'Repeating';
          getRepeatingDay = TextEditingController(
              text: database[0]['KHOANGTHOIGIAN'].toString());
        });
      }
    }
    database = await dbHelper.rawQuery('''
        select * from NHOMMUCTIEU where MANHOM='$groupKey'
    ''');
    if (database.length > 0)
      setState(() {
        dropDownGroup = database[0]['TENNHOM'];
      });
  }

  //Hàm tạo string random để Tạo khoá
  String getRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  // List các hàm tạo các widget phù hợp với từng loại hoạt động
  List<Widget> Flexible() {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
        child: Text(
          "How often do you want to perform the activity: ",
          style: TextStyle(fontSize: 18),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
        child: Row(
          children: [
            Expanded(
              flex: 4,
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
            Expanded(
                flex: 1,
                child: SizedBox(
                  width: 10,
                )),
            Expanded(
                flex: 9,
                child: Text("per week", style: TextStyle(fontSize: 20)))
          ],
        ),
      ),
    ];
  }

  List<Widget> Fixed() {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
        child: Text("Select the day you want to do the activity:",
            style: TextStyle(fontSize: 17)),
      ),
      SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dayOfWeek.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      checkDay[index] = !checkDay[index];
                    });
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
    ];
  }

  List<Widget> Repeating() {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
        child: Text("Repeating every: ", style: TextStyle(fontSize: 20)),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text("Every", style: TextStyle(fontSize: 20))),
              Expanded(
                  flex: 1,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: getRepeatingDay,
                    decoration: InputDecoration(hintText: 'num'),
                    style: TextStyle(fontSize: 20),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  )),
              Expanded(
                  flex: 4, child: Text("day", style: TextStyle(fontSize: 20))),
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
      return await showDialog(
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
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Message"),
                content: Text("You must choose a group"),
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
    return true;
  }

  // Các hàm thực hiện các việc liên quan đến dữ liệu
  void editActivity() async {
    bool valid = await checkValidActivity();
    if (valid == false) return;
    String key = widget.activityKey;
    dbHelper.rawQuery('''update MUCTIEU 
    set TENMUCTIEU='' where MAMUCTIEU='key' ''');
  }

  void getAllGroup() async {
    List<Map<String, dynamic>> database = await dbHelper.query('NHOMMUCTIEU');
    setState(() {
      text2 = database.toString();
    });
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
      setState(() {
        allGroup = ['None', 'None1', 'None2'];
        dropDownValue = allGroup[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff8A2BE2),
          title: Text("Add new activity", style: TextStyle(fontSize: 25)),
          actions: [
            FlatButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    "Edit",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ))
          ],
          elevation: 1,
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
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
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
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
                            contentPadding: EdgeInsets.all(28),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white)),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
              child: Center(
                child: Row(children: [
                  Text(
                    "Start date: ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    startTime.toString().substring(0, 10),
                    style: TextStyle(fontSize: 20),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.date_range),
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: startTime,
                              firstDate: DateTime.utc(2020, 1, 1),
                              lastDate: DateTime.utc(2120, 31, 12))
                          .then((date) {
                        setState(() {
                          if (date != null) startTime = date;
                        });
                      });
                    },
                    label: Text(""),
                  )
                ]),
              ),
            ),

            Divider(
              height: 10,
              color: Colors.black,
            ),
            //Chọn group của các activity
            Center(
              child: Row(
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
                      setState(() {
                        dropDownGroup = newValue;
                      });
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
                  ElevatedButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (_) => AddGroup(),
                        );
                        getAllGroup();
                      },
                      child: Text(
                        "New",
                        style: TextStyle(fontSize: 22),
                      ))
                ],
              ),
            ),
            // Bảng chọn loại của cái activity
            Center(
              child: Row(
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
                      setState(() {
                        dropDownValue = newValue;
                      });
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
            TextButton(
                onPressed: () {
                  dbHelper.rawQuery('''delete from NHOMMUCTIEU''');
                },
                child:
                    Text("DELETE NHOMMUCTIEU", style: TextStyle(fontSize: 30))),
            TextButton(
                onPressed: () {
                  dbHelper.rawQuery('''delete from MUCTIEU''');
                },
                child: Text("DELETE MUCTIEU", style: TextStyle(fontSize: 30))),
            Text(
              allGroup.toString(),
              style: TextStyle(fontSize: 20),
            )
          ],
        ));
  }
}
