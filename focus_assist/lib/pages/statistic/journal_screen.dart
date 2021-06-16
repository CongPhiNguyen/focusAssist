import 'package:flutter/material.dart';
import 'package:focus_assist/pages/statistic//edit_group_dialog.dart';
import 'package:focus_assist/pages/statistic//list_of_achivement.dart';
import 'package:focus_assist/pages/statistic//view_activity.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:focus_assist/pages/statistic//add_screen.dart';
import 'package:focus_assist/pages/statistic//add_new_group_dialog.dart';
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
    String userID = StaticData.userID;
    int selectedDay = dateTimeToInt(_selectedDay);
    database = await dbHelper.rawQuery(
        ''' select * from MUCTIEU where MAMUCTIEU in (select MAMUCTIEU from THONGKE where NGAYHOANTHANH=$selectedDay) and MANGUOIDUNG='$userID' ''');
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
            doneList.add(database[i]['TENMUCTIEU']);
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
    return Column(
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
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        getDoneTask();
                      },
                      child: Image.asset('assets/done.png',
                          width: 30, height: 30)),
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
                ListTile(
                  title: Center(
                    child: Text(doneList[index],
                        style: TextStyle(color: Colors.black)),
                  ),
                  tileColor: Colors.white,
                ),
                Divider(height: 1, color: Colors.black45)
              ],
            );
          },
        ),
        Container(
          height: 20,
          decoration: BoxDecoration(
              color: Color(0xff73a656),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
        )
      ],
    );
  }

  void getAllActivity() async {
    String userID = StaticData.userID;
    database = await dbHelper
        .rawQuery('''select * from MUCTIEU where MANGUOIDUNG='$userID' ''');
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
    String userID = StaticData.userID;
    List<Map<String, dynamic>> database = await dbHelper.rawQuery(
        ''' select * from MUCTIEU where MAMUCTIEU not in (select MAMUCTIEU from THONGKE where NGAYHOANTHANH=$selectedDay) and MANGUOIDUNG='$userID' ''');
    List<Map<String, dynamic>> flexibleData = [];
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
          // Quăng ra ngoài rồi hẵn xử lý
          flexibleData.add(database[i]);
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
    List<String> daysofWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    // Flexible Handler
    for (int i = 0; i < flexibleData.length; i++) {
      // Rắc rối nhất là ở đây
      // Lấy số lần đã làm trong tuần

      // Lấy thứ của ngày hiện tại
      String day = DateFormat('EEEE').format(_selectedDay);
      int indexOfDay = daysofWeek.indexOf(day);
      int selectedDay = dateTimeToInt(_selectedDay);
      // Số của ngày đầu tuần
      int startOfWeek = selectedDay - indexOfDay;
      int endOfWeek = selectedDay + 6 - indexOfDay;
      String key = flexibleData[i]['MAMUCTIEU'];
      // Lấy từ đầu tuần tới cuối tuần của cái bảng thống kê để coi thử làm đc bao nhiêu lần rồi
      List<Map<String, dynamic>> data = await dbHelper.rawQuery(
          '''select count(*) as SOLAN from THONGKE where NGAYHOANTHANH>=$startOfWeek and NGAYHOANTHANH<=$endOfWeek and MAMUCTIEU='$key' ''');
      print(data.toString());
      int count = 0;
      if (data.length == 0) {
        count = 0;
      } else
        count = data[0]['SOLAN'];
      if (flexibleData[i]['SOLAN'] <= count) {
        continue;
      }
      setState(() {
        toDos.add(
          ToDo(
              check: false,
              task: flexibleData[i]['TENMUCTIEU'] +
                  '  $count/' +
                  flexibleData[i]['SOLAN'].toString(),
              taskKey: flexibleData[i]['MAMUCTIEU']),
        );
      });
    }
    if (toDos.length == 0) {
      toDos = [
        ToDo(check: false, task: "Không có gì", taskKey: 'None'),
      ];
    }
  }

  Widget ToDoList() {
    return Column(
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
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      getToDoList();
                      getDoneTask();
                    },
                    child: Image.asset(
                      'assets/todo.png',
                      width: 35,
                      height: 35,
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
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Center(
                    child: Text(toDos[index].task,
                        style: TextStyle(color: Colors.black)),
                  ),
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
                                    // Thêm 50 vàng
                                    int golds = StaticData.Vang += 50;
                                    //Add vào database
                                    String userKey = StaticData.userID;
                                    dbHelper.rawQuery(
                                        ''' update THONGTINNGUOIDUNG set VANG=$golds where MANGUOIDUNG='$userKey' ''');
                                    loadGold();
                                    // Xoá sổ todos bằng cách thêm vào bảng thống kê
                                    Map<String, dynamic> row = {
                                      'MAMUCTIEU': toDos[index].taskKey,
                                      'NGAYHOANTHANH':
                                          dateTimeToInt(_selectedDay)
                                    };
                                    final id =
                                        await dbHelper.insert('THONGKE', row);
                                    print('inserted row id: $id');
                                    getToDoList();
                                    getDoneTask();
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
        Container(
          height: 20,
          decoration: BoxDecoration(
              color: Color(0xffe7e732),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
        )
      ],
    );
  }

  Widget AllActivity() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Color(0xffF4A460),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "All activity",
                    style: TextStyle(color: Colors.white, fontSize: 22),
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
                      getDoneTask();
                      getAllGroup();
                    },
                    child: ListTile(
                      title: Center(
                        child: Text(allActivity[index],
                            style: TextStyle(color: Colors.black)),
                      ),
                      tileColor: Colors.white,
                    ),
                  ),
                  Divider(height: 1, color: Colors.black45)
                ],
              );
            },
          ),
          Container(
            height: 20,
            decoration: BoxDecoration(
                color: Color(0xffF4A460),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
          )
        ],
      ),
    );
  }

  Widget GroupTable() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: List<Widget>.generate(allGroup.length, (int index) {
              return Row(children: [
                GroupActivity(index),
                SizedBox(
                  width: 30,
                )
              ]);
            })),
      ),
    );
  }

  void getGroupActivity(int index) async {
    String key = allGroupKey[index];
    String userID = StaticData.userID;
    database = await dbHelper.rawQuery(
        '''select * from MUCTIEU where MANHOM='$key' and MANGUOIDUNG='$userID' ''');
    List<String> tempActivity = [];
    List<String> tempActivityKey = [];
    for (int j = 0; j < database.length; j++) {
      tempActivity.add(database[j]['TENMUCTIEU']);
      tempActivityKey.add(database[j]['MAMUCTIEU']);
    }
    setState(() {
      allGroupActivity[index] = tempActivity;
      allGroupActivityKey[index] = tempActivityKey;
    });
  }

  void getAllGroup() async {
    setState(() {
      allGroup = [];
      allGroupKey = [];
    });
    String userID = StaticData.userID;
    database = await dbHelper
        .rawQuery('''select * from NHOMMUCTIEU where MANGUOIDUNG='$userID' ''');
    for (int i = 0; i < database.length; i++) {
      setState(() {
        allGroup.add(database[i]['TENNHOM']);
        allGroupKey.add(database[i]['MANHOM']);
      });
    }
    for (int i = 0; i < allGroupKey.length; i++) {
      setState(() {
        allGroupActivity.add([]);
        allGroupActivityKey.add([]);
      });
    }
    for (int i = 0; i < allGroup.length; i++) {
      getGroupActivity(i);
    }
  }

  Widget GroupActivity(inDex) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: 270,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 2, 2, 2),
                          child: Text(
                            allGroup[inDex],
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                                onTap: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (_) => EditGroup(
                                      groupKey: allGroupKey[inDex],
                                      groupName: allGroup[inDex],
                                    ),
                                  );
                                  getAllGroup();
                                },
                                child: Icon(Icons.edit, color: Colors.white)),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                                onTap: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
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
                                child: Icon(Icons.delete, color: Colors.white)),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        )
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
                        title: Center(
                          child: Text(allGroupActivity[inDex][index],
                              style: TextStyle(color: Colors.black)),
                        ),
                        tileColor: Colors.white,
                      ),
                    ),
                    Divider(height: 1, color: Colors.black45)
                  ],
                );
              },
            ),
            Container(
              height: 15,
              decoration: BoxDecoration(
                  color: Color(0xffe66771),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
            )
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

  Widget Calendar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children: [
          TableCalendar(
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
          Row(
            children: <Widget>[
              Expanded(
                  flex: 5,
                  child: Row(children: [
                    SizedBox(width: 10),
                    Text('Completion : ' + rate + ' %'),
                  ])),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffffffff),
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
            loadGold();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                backgroundColor: Color(0xffffffff),
                radius: 15,
                child: Image.asset('assets/gold.png', width: 30, height: 30),
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
        Calendar(),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Image.asset(
              'assets/dodone.png',
              width: 40,
              height: 40,
            ),
            SizedBox(width: 20),
            Text(
              'Todo and Done',
              style: TextStyle(fontSize: 22, color: Colors.black54),
            ),
          ]),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 270,
                      child: ToDoList(),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 270,
                      child: DoneTask(),
                    ),
                  ),
                ],
              ),
            )),
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0), //or 15.0
                      child: Container(
                        height: 40.0,
                        width: 40.0,
                        child: Image.asset(
                          'assets/group_activity.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Group Activity',
                      style: TextStyle(fontSize: 22, color: Colors.black54),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                      color: Color(0xffe0e6ee),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (_) => AddGroup(),
                      );
                      getAllActivity();
                      getToDoList();
                      getAllGroup();
                    },
                    child: Text('Add new',
                        style: TextStyle(fontSize: 20, color: Colors.black54)),
                  ),
                )
              ],
            )),

        SizedBox(
          height: 12,
        ),
        GroupTable(),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Row(
            children: [
              Image.asset('assets/allactivity.png', width: 50, height: 50),
              Text(
                'All Activity',
                style: TextStyle(fontSize: 22, color: Colors.black54),
              ),
            ],
          ),
        ),
        AllActivity(),
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
