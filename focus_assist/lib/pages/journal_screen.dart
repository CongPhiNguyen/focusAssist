import 'package:flutter/material.dart';
import 'package:focus_assist/pages/edit_group_dialog.dart';
import 'package:focus_assist/pages/list_of_achivement.dart';
import 'package:focus_assist/pages/view_activity.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:focus_assist/pages/add_screen.dart';
import 'package:focus_assist/pages/add_new_group_dialog.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:intl/intl.dart';

class ToDo {
  bool check;
  String task;
  String taskKey;
  ToDo({this.check, this.task, this.taskKey});
}

class JournalScreen extends StatefulWidget {
  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  // Các biến dùng trong cái lịch
  CalendarFormat _calendarFormat;
  DateTime _focusedDay;
  DateTime _selectedDay;

  // Các biến để lưu dữ liệu các ngày
  List<String> items1;
  List<String> items;
  List<ToDo> toDos;
  List<String> allActivity, allActivityKey;

  Map<String, double> dataMap;

  //Các biến thực hiện việc xử lý dữ liệu
  final dbHelper = DbProvider.instance;
  List<Map<String, dynamic>> database;
  List<String> allGroup, allGroupKey;
  List<List<String>> allGroupActivity, allGroupActivityKey;
  List<String> doneList, doneListKey;

  String rate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allGroup = ['Fuck'];
    doneList = ['Không có gì'];
    doneListKey = ['None'];
    allGroupKey = ['NONE'];
    allGroupActivity = [];
    allGroupActivityKey = [];
    _calendarFormat = CalendarFormat.week;
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    items1 = ["Chơi cờ vua", "Luyện tập code", "Cày game"];
    toDos = [
      ToDo(check: false, task: "Không có gì", taskKey: 'None'),
    ];

    items = [];
    dataMap = {"Skip": 500, "Done": 322, "Fail": 112};
    allActivity = ["Không có gì"];
    allActivityKey = ['None'];
    loadGold();
    getAllActivity();
    getToDoList();
    getAllGroup();
    getDoneTask();
    rate = '0';
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

  void loadGold() async {
    String userID = StaticData.userID;
    List<Map<String, dynamic>> database = await dbHelper.rawQuery(
        ''' select * from THONGTINNGUOIDUNG where MANGUOIDUNG='$userID' ''');
    if (database.length > 0) {
      setState(() {
        StaticData.Vang = database[0]['VANG'];
      });
    }
  }

  // Các hàm cần thiết để load dữ liệu
  void getDoneTask() async {
    print("Fuck Done");
    int selectedDay = dateTimeToInt(_selectedDay);
    database = await dbHelper.rawQuery(
        ''' select * from MUCTIEU where MAMUCTIEU in (select MAMUCTIEU from THONGKE where NGAYHOANTHANH=$selectedDay) ''');
    if (database.length == 0) {
      setState(() {
        doneList = ['Không có gì'];
        doneListKey = ['None'];
      });
    }
    if (database.length > 0) {
      doneList = [];
      doneListKey = [''];
      String k = DateFormat('EEEE').format(_selectedDay);
      List<String> daysofWeek = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ];
      int indexOfK = daysofWeek.indexOf(k);
      for (int i = 0; i < database.length; i++) {
        DateTime start =
            intToDateTime(int.parse(database[i]['NGAYBATDAU'].toString()));
        if (_selectedDay.year < start.year) {
          continue;
        } else if (_selectedDay.year == start.year) {
          if (_selectedDay.month < start.month) {
            continue;
          } else if (_selectedDay.month == start.month) {
            if (_selectedDay.day < start.day) {
              continue;
            }
          }
        }
        if (database[i]['LOAIHINH'] == 'Fixed') {
          String h = database[i]['CACNGAY'].toString();
          // Xử lý vì chuyển từ int nên có thể không đủ 7 chữ số
          while (h.length < 7) {
            h = '0' + h;
          }
          if (h[indexOfK] == '1') {
            setState(() {
              doneList.add(database[i]['TENMUCTIEU']);
              doneListKey.add(database[i]['MAMUCTIEU']);
            });
          }
        } else if (database[i]['LOAIHINH'] == 'Flexible') {
          setState(() {
            doneList.add(
              database[i]['TENMUCTIEU'] +
                  '  0/' +
                  database[i]['SOLAN'].toString(),
            );
            doneListKey.add(database[i]['MAMUCTIEU']);
          });
        } else if (database[i]['LOAIHINH'] == 'Repeating') {
          int val = int.parse(database[i]['KHOANGTHOIGIAN']);
          Duration diff = start.difference(_selectedDay);
          if (diff.inDays % val == 0) {
            print(val);
            setState(() {
              doneList.add(database[i]['TENMUCTIEU']);
              doneListKey.add(database[i]['MAMUCTIEU']);
            });
          }
        }
      }
    }
    double rateInt = 0;
    if (doneList.length == 0 ||
        (doneList.length == 1 && doneListKey[0] == 'None'))
      rateInt = 0;
    else if (toDos.length == 0 ||
        (toDos.length == 1 && toDos[0].taskKey == 'None')) {
      rateInt = 100;
    } else
      rateInt = ((doneList.length.toDouble() *
          100.0 /
          (toDos.length.toDouble() + doneList.length.toDouble())));
    if (rateInt > 100) rateInt = 100;
    setState(() {
      rate = rateInt.toString();
      if (rate.length > 8) {
        rate = rate.substring(0, 8);
      }
    });
  }

  Widget DoneTask() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.greenAccent, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Color(0xff73a656),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              getDoneTask();
                            },
                            child: Icon(
                              Icons.playlist_add_check,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            "Done activities",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      ]),
                )),
            ListView.builder(
              shrinkWrap: true,
              itemCount: doneList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        if (doneListKey[index] == 'None') return;
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewActivity(
                                      activityKey: doneListKey[index],
                                      activityName: doneList[index],
                                    )));
                        getAllActivity();
                        getToDoList();
                        getAllGroup();
                      },
                      child: ListTile(
                        title: Text(doneList[index],
                            style: TextStyle(color: Colors.black)),
                        tileColor: Colors.white,
                      ),
                    ),
                    Divider(height: 1, color: Colors.black45)
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void getAllActivity() async {
    database = await dbHelper.query('MUCTIEU');
    if (database.length == 0) {
      setState(() {
        allActivity = ['Không có gì'];
        allActivityKey = ['None'];
      });
    }
    if (database.length > 0) {
      setState(() {
        allActivity.clear();
        allActivityKey.clear();
        for (int i = 0; i < database.length; i++) {
          allActivity.add(database[i]['TENMUCTIEU']);
          allActivityKey.add(database[i]['MAMUCTIEU']);
        }
      });
    }
  }

  void getToDoList() async {
    print("Fuck Done");
    int selectedDay = dateTimeToInt(_selectedDay);
    database = await dbHelper.rawQuery(
        ''' select * from MUCTIEU where MAMUCTIEU not in (select MAMUCTIEU from THONGKE where NGAYHOANTHANH=$selectedDay) ''');
    if (database.length == 0) {
      setState(() {
        toDos = [
          ToDo(check: false, task: "Không có gì", taskKey: 'None'),
        ];
      });
    }
    if (database.length > 0) {
      toDos = [];
      String k = DateFormat('EEEE').format(_selectedDay);
      List<String> daysofWeek = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ];
      int indexOfK = daysofWeek.indexOf(k);
      for (int i = 0; i < database.length; i++) {
        DateTime start =
            intToDateTime(int.parse(database[i]['NGAYBATDAU'].toString()));
        if (_selectedDay.year < start.year) {
          continue;
        } else if (_selectedDay.year == start.year) {
          if (_selectedDay.month < start.month) {
            continue;
          } else if (_selectedDay.month == start.month) {
            if (_selectedDay.day < start.day) {
              continue;
            }
          }
        }
        if (database[i]['LOAIHINH'] == 'Fixed') {
          String h = database[i]['CACNGAY'].toString();
          // Xử lý vì chuyển từ int nên có thể không đủ 7 chữ số
          while (h.length < 7) {
            h = '0' + h;
          }
          if (h[indexOfK] == '1') {
            setState(() {
              toDos.add(ToDo(
                  check: false,
                  task: database[i]['TENMUCTIEU'],
                  taskKey: database[i]['MAMUCTIEU']));
            });
          }
        } else if (database[i]['LOAIHINH'] == 'Flexible') {
          setState(() {
            toDos.add(
              ToDo(
                  check: false,
                  task: database[i]['TENMUCTIEU'] +
                      '  0/' +
                      database[i]['SOLAN'].toString(),
                  taskKey: database[i]['MAMUCTIEU']),
            );
          });
        } else if (database[i]['LOAIHINH'] == 'Repeating') {
          int val = int.parse(database[i]['KHOANGTHOIGIAN']);
          Duration diff = start.difference(_selectedDay);
          if (diff.inDays % val == 0) {
            print(val);
            setState(() {
              toDos.add(
                ToDo(
                    check: false,
                    task: database[i]['TENMUCTIEU'],
                    taskKey: database[i]['MAMUCTIEU']),
              );
            });
          }
        }
      }
    }

    if (toDos.length == 0) {
      toDos = [
        ToDo(check: false, task: "Không có gì", taskKey: 'None'),
      ];
    }
  }

  Widget ToDoList() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.greenAccent, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Color(0xffe7e732),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              getToDoList();
                            },
                            child: Icon(
                              Icons.playlist_add_check,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            "To do",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      ]),
                )),
            ListView.builder(
              shrinkWrap: true,
              itemCount: toDos.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    CheckboxListTile(
                      value: toDos[index].check,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(toDos[index].task,
                          style: TextStyle(color: Colors.black)),
                      tileColor: Colors.white,
                      onChanged: (bool value) async {
                        if (toDos[index].taskKey == 'None') return;
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: Text("Message"),
                                  content: Text("Done it: " +
                                      toDos[index].task.toString() +
                                      "?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        setState(() {
                                          toDos[index].check = value;
                                        });
                                        // Xoá sổ todos bằng cách thêm vào bảng thống kê
                                        Map<String, dynamic> row = {
                                          'MAMUCTIEU': toDos[index].taskKey,
                                          'NGAYHOANTHANH':
                                              dateTimeToInt(_selectedDay)
                                        };
                                        final id = await dbHelper.insert(
                                            'THONGKE', row);
                                        print('inserted row id: $id');
                                        getToDoList();
                                      },
                                      child: Text("Yes"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("No"),
                                    )
                                  ],
                                ));
                        getDoneTask();
                      },
                    ),
                    Divider(height: 1, color: Colors.black45)
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget AllActivity() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.greenAccent, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Color(0xffe66771),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              getAllActivity();
                            },
                            child: Icon(
                              Icons.playlist_add_check,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            "All activity",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      ]),
                )),
            ListView.builder(
              shrinkWrap: true,
              itemCount: allActivity.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        if (allActivityKey[index] == 'None') return;
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewActivity(
                                      activityKey: allActivityKey[index],
                                      activityName: allActivity[index],
                                    )));
                        getAllActivity();
                        getToDoList();
                        getAllGroup();
                      },
                      child: ListTile(
                        title: Text(allActivity[index],
                            style: TextStyle(color: Colors.black)),
                        tileColor: Colors.white,
                      ),
                    ),
                    Divider(height: 1, color: Colors.black45)
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget GroupTable() {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff9e9e9e),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: allGroup.length,
        itemBuilder: (context, index) {
          return GroupActivity(index);
        },
      ),
    );
  }

  void getAllGroup() async {
    setState(() {
      allGroup = [];
      allGroupKey = [];
    });
    database = await dbHelper.query('NHOMMUCTIEU');
    for (int i = 0; i < database.length; i++) {
      setState(() {
        allGroup.add(database[i]['TENNHOM']);
        allGroupKey.add(database[i]['MANHOM']);
      });
    }
    allGroupActivity = [];
    allGroupActivityKey = [];
    for (int i = 0; i < allGroupKey.length; i++) {
      setState(() {
        allGroupActivity.add([]);
        allGroupActivityKey.add([]);
      });

      print("Fcu");
      String key = allGroupKey[i];
      database = await dbHelper
          .rawQuery('''select * from MUCTIEU where MANHOM='$key' ''');
      for (int j = 0; j < database.length; j++) {
        setState(() {
          allGroupActivity[i].add(database[j]['TENMUCTIEU']);
          allGroupActivityKey[i].add(database[j]['MAMUCTIEU']);
        });
      }
    }
  }

  Widget GroupActivity(inDex) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.greenAccent, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Color(0xffe66771),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.playlist_add_check,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            allGroup[inDex],
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      ]),
                )),
            ListView.builder(
              shrinkWrap: true,
              itemCount: allGroupActivity[inDex].length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewActivity(
                                      activityKey: allGroupActivityKey[inDex]
                                          [index],
                                      activityName: allGroupActivity[inDex]
                                          [index],
                                    )));
                        getAllActivity();
                        getToDoList();
                        getAllGroup();
                      },
                      child: ListTile(
                        title: Text(allGroupActivity[inDex][index],
                            style: TextStyle(color: Colors.black)),
                        tileColor: Colors.white,
                      ),
                    ),
                    Divider(height: 1, color: Colors.black45)
                  ],
                );
              },
            ),
            Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Color(0xffe66771),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (_) => EditGroup(
                              groupKey: allGroupKey[inDex],
                              groupName: allGroup[inDex],
                            ),
                          );
                          getAllGroup();
                        },
                        child: Text("Edit group")),
                    SizedBox(width: 30),
                    ElevatedButton(
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Text("Message"),
                                    content: Text(
                                        "Are you sure to delete this group and all activity belong to it ?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          deleteGroup(inDex);
                                        },
                                        child: Text("Yes"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("No"),
                                      )
                                    ],
                                  ));
                          getAllActivity();
                          getToDoList();
                          getAllGroup();
                        },
                        child: Text("Delete group")),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void deleteGroup(inDex) {
    //Delete activitys of group
    for (int i = 0; i < allGroupActivityKey[inDex].length; i++) {
      String key = allGroupActivityKey[inDex][i];
      dbHelper.rawQuery(''' delete from MUCTIEU where MAMUCTIEU='$key' ''');
      // Delete trong bảng thống kê
      dbHelper.rawQuery(''' delete from THONGKE where MAMUCTIEU='$key' ''');
    }
    String key = allGroupKey[inDex];
    //Delete group
    dbHelper.rawQuery(''' delete from NHOMMUCTIEU where MANHOM='$key' ''');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: ListView(children: <Widget>[
        SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (_) => ListAchivement(),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                backgroundColor: Colors.yellow,
                radius: 10,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                StaticData.Vang.toString(),
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                width: 30,
              ),
            ],
          ),
        ),
        //Đây để hiện cái dòng qoutes
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                "\' No pain, no gain \'",
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        //Hiển thị calendar
        Padding(
          padding: const EdgeInsets.all(3.0),
          // ignore: missing_required_param
          child: TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  if (_selectedDay == DateTime.utc(2021, 4, 25)) {
                    setState(() {
                      this.items = items1;
                    });
                  } else
                    setState(() {
                      this.items = [];
                    });
                });
                getToDoList();
                getDoneTask();
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },

            calendarStyle: CalendarStyle(
                defaultTextStyle: TextStyle(fontSize: 20),
                weekendTextStyle: TextStyle(fontSize: 20)),

            // Đây là các dòng chỉnh cái header ở trên của cái lịch
            headerStyle: HeaderStyle(
              decoration: BoxDecoration(
                  color: Colors.cyan,
                  border: Border.all(color: Colors.white, width: 0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              titleCentered: true,
              titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
              formatButtonShowsNext: true,
              formatButtonVisible: false,
            ),

            ////Chỉnh định dạng của các ngày trong tuần
            daysOfWeekHeight: 51,
            daysOfWeekStyle: DaysOfWeekStyle(
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                ),
                ////Chỉnh các ngày cuối tuần
                weekendStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),

                ////Chỉnh các ngày trong tuần
                weekdayStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                )),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
                flex: 5,
                child: Row(children: [
                  SizedBox(width: 10),
                  Text('Conversion rate: ' + rate + ' %'),
                ])),
            Expanded(
                flex: 5,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Text("Less", style: TextStyle(fontSize: 17))),
                    Expanded(
                        flex: 2,
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.green[300],
                              radius: 10,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.green[500],
                              radius: 10,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.green[700],
                              radius: 10,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.green[900],
                              radius: 10,
                            ),
                          ],
                        )),
                    Expanded(
                        flex: 1,
                        child: Text("More", style: TextStyle(fontSize: 17)))
                  ],
                ))
          ],
        ),
        SizedBox(
          height: 30,
        ),
        ToDoList(),
        DoneTask(),
        SizedBox(
          height: 12,
        ),
        AllActivity(),
        SizedBox(
          height: 12,
        ),
        //Hiển thị các cái to do list
        GroupTable(),
        SizedBox(height: 12),
        Center(
            child: TextButton(
          child: Text(
            "Add new group",
            style: TextStyle(fontSize: 30),
          ),
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (_) => AddGroup(),
            );
            getAllActivity();
            getToDoList();
            getAllGroup();
          },
        )),
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddNew()),
            );
            getAllActivity();
            getToDoList();
            getAllGroup();
          },
          child: Text(
            "+",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
          )),
    );
  }
}
