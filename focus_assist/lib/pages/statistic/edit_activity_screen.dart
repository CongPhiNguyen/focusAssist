import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'dart:math';
import 'package:focus_assist/pages/statistic/add_new_group_dialog.dart';

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
    getAllInformation();
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

  //Load lại các thông tin của activity vào cái form
  void getAllInformation() async {
    String activityKey = widget.activityKey;
    List<Map<String, dynamic>> database = await dbHelper.rawQuery('''
        select * from MUCTIEU where MAMUCTIEU='$activityKey'
    ''');
    String groupKey;
    if (database.length > 0) {
      if (this.mounted) {
        setState(() {
          getActivity = TextEditingController(text: database[0]['TENMUCTIEU']);
          getDescription = TextEditingController(text: database[0]['MOTA']);
          groupKey = database[0]['MANHOM'];
          startTime =
              intToDateTime(int.parse(database[0]['NGAYBATDAU'].toString()));
        });
      } else
        return;

      String type = database[0]['LOAIHINH'];
      if (type == 'Fixed') {
        if (this.mounted) {
          setState(() {
            dropDownValue = 'Fixed';
          });
        } else
          return;

        String cacNgay = database[0]['CACNGAY'].toString();
        while (cacNgay.length < 7) {
          cacNgay = '0' + cacNgay;
        }
        for (int i = 0; i < 7; i++) {
          if (this.mounted) {
            setState(() {
              checkDay[i] = (cacNgay[i] == '1') ? true : false;
            });
          } else
            return;
        }
      } else if (type == 'Flexible') {
        if (this.mounted) {
          setState(() {
            dropDownValue = 'Flexible';
            getDayPerWeek =
                TextEditingController(text: database[0]['SOLAN'].toString());
          });
        } else
          return;
      } else if (type == 'Repeating') {
        if (this.mounted) {
          setState(() {
            dropDownValue = 'Repeating';
            getRepeatingDay = TextEditingController(
                text: database[0]['KHOANGTHOIGIAN'].toString());
          });
        } else
          return;
      }
    }
    database = await dbHelper.rawQuery('''
        select * from NHOMMUCTIEU where MANHOM='$groupKey'
    ''');
    if (database.length > 0) if (this.mounted) {
      setState(() {
        dropDownGroup = database[0]['TENNHOM'];
      });
    } else
      return;
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
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                "How often do you want to perform the activity?",
                style: TextStyle(fontSize: 18),
                softWrap: true,
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
                        width: 50,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: getDayPerWeek,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(hintText: 'days'),
                          style: TextStyle(fontSize: 20),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("per week", style: TextStyle(fontSize: 20))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  // ignore: non_constant_identifier_names
  List<Widget> Fixed() {
    return <Widget>[
      Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text("When do you want to do the activity?",
                style: TextStyle(fontSize: 18)),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                  height: 45,
                  width: 370,
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
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                          child: Container(
                              width: 48.5,
                              decoration: BoxDecoration(
                                color: checkDay[index]
                                    // ? Color(0xff8A2BE2)
                                    // : Color(0xffF0FFF0),
                                    ? (!StaticData.isDarkMode)
                                        ? Colors.grey[50]
                                        : Colors.grey[700]
                                    : (!StaticData.isDarkMode)
                                        ? Colors.grey[100]
                                        : Colors.grey[800],
                                border: Border(
                                  bottom: BorderSide(
                                      color: !checkDay[index]
                                          ? (!StaticData.isDarkMode)
                                              ? Colors.grey[50]
                                              : Colors.grey[800]
                                          : (!StaticData.isDarkMode)
                                              ? Colors.blue
                                              : Colors.grey[500],
                                      width: 5),
                                  // top: BorderSide(
                                  //     color: !checkDay[index]
                                  //         ? (!StaticData.isDarkMode)?Colors.blue:Colors.grey[700]
                                  //         : (!StaticData.isDarkMode)?Colors.grey[200]:Colors.grey[500],
                                  //     width: 1),
                                  // right: BorderSide(
                                  //     color: !checkDay[index]
                                  //         ? (!StaticData.isDarkMode)?Colors.blue:Colors.grey[700]
                                  //         : (!StaticData.isDarkMode)?Colors.grey[200]:Colors.grey[500],
                                  //     width: 1),
                                  // left: BorderSide(
                                  //     color: !checkDay[index]
                                  //         ? (!StaticData.isDarkMode)?Colors.blue:Colors.grey[700]
                                  //         : (!StaticData.isDarkMode)?Colors.grey[200]:Colors.grey[500],
                                  //     width: (index == 0) ? 1 : 0)
                                ),
                              ),
                              child: Center(
                                child: Text(dayOfWeek[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: !checkDay[index]
                                          ? Colors.black
                                          : Colors.black,
                                    )),
                              )),
                        ),
                      );
                    },
                  )),
            ),
          ),
        ]),
      )
    ];
  }

  // ignore: non_constant_identifier_names
  List<Widget> Repeating() {
    return <Widget>[
      Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Repeating every", style: TextStyle(fontSize: 18)),
              SizedBox(width: 20),
              Container(
                width: 50,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: getRepeatingDay,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(hintText: 'num'),
                  style: TextStyle(fontSize: 20),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text("days", style: TextStyle(fontSize: 18)),
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
                    Text("Are you sure you don't want to add description?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text("No"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text("Yes"),
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
                        "Days per week can't be greater than 7 or less than 1"),
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
                content: Text(
                    "Are you sure you don't want to add this activity to a group ?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text("No"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text("Yes"),
                  )
                ],
              ));
      if (k == false) return k;
    }
    return true;
  }

  // Các hàm thực hiện các việc liên quan đến dữ liệu
  Future<void> editActivity() async {
    bool valid = await checkValidActivity();
    if (valid == false) return;
    String key = widget.activityKey;
    String val = '';
    String activityName = getActivity.text;
    String description = getDescription.text;
    int beginDay = dateTimeToInt(startTime);
    String groupKey = allGroupKey[allGroup.indexOf(dropDownGroup)];
    val = '''TENMUCTIEU= '$activityName''';
    val += '''', MOTA='$description''';
    val += '''', NGAYBATDAU=$beginDay ''';
    val += ''', LOAIHINH='$dropDownValue' ''';
    val += ''', MANHOM='$groupKey' ''';
    if (dropDownValue == 'Fixed') {
      String fixedDay = "";
      for (int i = 0; i < dayOfWeek.length; i++) {
        if (checkDay[i] == false) {
          fixedDay += '0';
        } else
          fixedDay += '1';
      }
      val += ''', CACNGAY=$fixedDay ''';
    } else if (dropDownValue == 'Flexible') {
      String soLan = getDayPerWeek.text;
      val += ''', SOLAN=$soLan ''';
    } else if (dropDownValue == 'Repeating') {
      String days = getRepeatingDay.text;
      val += ''', KHOANGTHOIGIAN='$days' ''';
    }
    if (this.mounted) {
      setState(() {
        text = val;
      });
    } else
      return;

    dbHelper.rawQuery('''update MUCTIEU
     set $val where MAMUCTIEU='$key' ''');
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

  Future<bool> checkUniqueName(String name) async {
    String userID = StaticData.userID;
    List<Map<String, dynamic>> database = await dbHelper
        .rawQuery('''select * from NHOMMUCTIEU where MANGUOIDUNG='$userID' ''');
    for (int i = 0; i < database.length; i++) {
      if (database[i]['TENNHOM'] == name) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder k = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
          width: 1,
          color: (!StaticData.isDarkMode) ? Colors.black : Colors.grey),
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.color,
          title: Text(
            "Edit activity",
            style: TextStyle(
              color: Theme.of(context).appBarTheme.titleTextStyle.color,
              letterSpacing: 0.5,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  await editActivity();
                  if (isFailed) {
                  } else
                    Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    "Edit      ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    color: (!StaticData.isDarkMode)
                        ? Colors.grey[50]
                        : Colors.grey[850],
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
                          labelStyle: TextStyle(
                              color: (!StaticData.isDarkMode)
                                  ? Colors.black
                                  : Colors.grey[400],
                              fontSize: 18),
                          focusedBorder: k,
                          disabledBorder: k,
                          enabledBorder: k,
                          errorBorder: k,
                          focusedErrorBorder: k,
                        ),
                        // style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Description
                      TextField(
                        controller: getDescription,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            focusedBorder: k,
                            disabledBorder: k,
                            enabledBorder: k,
                            errorBorder: k,
                            focusedErrorBorder: k,
                            border: OutlineInputBorder(),
                            labelText: 'Description (optional)',
                            labelStyle: TextStyle(
                                color: (!StaticData.isDarkMode)
                                    ? Colors.black
                                    : Colors.grey[400],
                                fontSize: 18)),
                        maxLines: 3,
                        // style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Center(
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    "Start date: ",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    startTime.toString().substring(0, 10),
                    style: TextStyle(fontSize: 18),
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

            Divider(
              height: 10,
              color: (!StaticData.isDarkMode) ? Colors.black : Colors.grey,
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
                    style: const TextStyle(color: Colors.blue, fontSize: 18),
                    underline: Container(
                      height: 2,
                      color: Colors.blue,
                    ),
                    onChanged: (String newValue) {
                      if (this.mounted) {
                        setState(() {
                          dropDownGroup = newValue;
                        });
                      }
                    },
                    items:
                        allGroup.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                            width: 150,
                            child:
                                Text(value, overflow: TextOverflow.ellipsis)),
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
                      style: TextStyle(fontSize: 20),
                    ),
                  )
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
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  DropdownButton<String>(
                    value: dropDownValue,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.blue, fontSize: 18),
                    underline: Container(
                      height: 2,
                      color: Colors.blue,
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
          ],
        ));
  }
}
