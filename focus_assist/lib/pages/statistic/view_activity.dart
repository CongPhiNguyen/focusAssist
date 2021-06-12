import 'package:flutter/material.dart';
import 'package:focus_assist/pages/statistic/edit_activity_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

class ViewActivity extends StatefulWidget {
  final String activityKey, activityName;

  ViewActivity({Key key, this.activityKey, this.activityName})
      : super(key: key);
  @override
  _ViewActivityState createState() => _ViewActivityState();
}

class _ViewActivityState extends State<ViewActivity> {
  String keyname, name;
  final dbHelper = DbProvider.instance;
  // Các biến dùng trong cái lịch
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<Map<String, dynamic>> database;
  Map<String, double> dataMap = {
    "Done": 5,
    "Miss": 20,
  };
  String consecutiveDays;
  String activityStartDay;
  // Các biến dùng để debug
  DateTime startTime;
  String doDays, failDays;

  // Các biến dùng để lưu ngày và mark ngày
  List<DateTime> listDoneDay = [];
  List<DateTime> listMissDay = [];

  DateTime _selectedDateTime, _targetedDateTime;
  double cHeight;
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    database = [];
    name = widget.activityName;
    keyname = widget.activityKey;

    startTime = DateTime.now();
    consecutiveDays = '0';
    activityStartDay = '';
    getData();
    doDays = '0';
    failDays = '0';
    _selectedDateTime = DateTime.now();
    _targetedDateTime = DateTime.now();
    markDays();
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

  void getData() async {
    String key = widget.activityKey;
    // Cập nhật lại sau khi chỉnh sửa
    database = await dbHelper
        .rawQuery('''select * from MUCTIEU where MAMUCTIEU='$key' ''');
    if (database.length > 0) {
      setState(() {
        name = database[0]['TENMUCTIEU'];
        activityStartDay = intToDateTime(database[0]['NGAYBATDAU']).toString();
        if (activityStartDay.length > 10) {
          activityStartDay = activityStartDay.substring(0, 10);
        }
      });
    }

    // Lấy các ngày đã làm
    int date = dateTimeToInt(startTime);
    List<Map<String, dynamic>> data = await dbHelper.rawQuery(
        '''select * from THONGKE where MAMUCTIEU='$key' and NGAYHOANTHANH<=$date ''');
    List<int> doneDay = [];
    for (int i = 0; i < data.length; i++) {
      doneDay.add(data[i]['NGAYHOANTHANH']);
    }

    for (int i = 0; i < doneDay.length; i++) {
      setState(() {
        listDoneDay.add(intToDateTime(doneDay[i]));
      });
    }
    print('list DoneDay: $listDoneDay');
    // Lấy ngày thực hiện ngày không thực hiện
    if (database.length > 0) {
      // Xử lý trường hợp fixed
      if (database[0]['LOAIHINH'] == 'Fixed') {
        //Tất cả những ngày đã làm nhỏ hơn ngày hoàn thành: doneDay
        //List tất cả những ngày cần làm
        List<int> toDoDays = [];
        // Lấy thứ của ngày bắt đầu
        String thu =
            DateFormat('EEEE').format(intToDateTime(database[0]['NGAYBATDAU']));
        List<String> daysofWeek = [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday'
        ];
        int indexThu = daysofWeek.indexOf(thu);
        String h = database[0]['CACNGAY'].toString();
        // Xử lý vì chuyển từ int nên có thể không đủ 7 chữ số
        while (h.length < 7) {
          h = '0' + h;
        }
        for (int day = database[0]['NGAYBATDAU'];
            day <= dateTimeToInt(startTime);
            day++) {
          if (h[indexThu] == '1') {
            toDoDays.add(day);
          }
          indexThu++;
          indexThu %= 7;
        }
        int doDay = 0, failDay = 0;
        for (int i = 0; i < toDoDays.length; i++) {
          if (doneDay.contains(toDoDays[i])) {
            doDay++;
          } else
            failDay++;
        }
        setState(() {
          doDays = doDay.toString();
          dataMap['Done'] = doDay * 1.0;
          failDays = failDay.toString();
          dataMap['Miss'] = failDay * 1.0;
        });

        for (int i = 0; i < toDoDays.length; i++) {
          if (!doneDay.contains(toDoDays[i]))
            setState(() {
              listMissDay.add(intToDateTime(toDoDays[i]));
            });
        }
        print('list Miss: $listMissDay');
        // Tính streak của fixed
        int conseDays = 0;
        for (int i = toDoDays.length - 1; i >= 0; i--) {
          if (doneDay.contains(toDoDays[i])) {
            conseDays++;
            //print(toDoDays[i]);
          } else {
            break;
          }
        }
        setState(() {
          consecutiveDays = conseDays.toString();
        });
      } else if (database[0]['LOAIHINH'] == 'Repeating') {
        int cachNgay = int.parse(database[0]['KHOANGTHOIGIAN']);
        // List tất cả các ngày cần làm:
        List<int> toDoDays = [];
        for (int day = database[0]['NGAYBATDAU'];
            day <= dateTimeToInt(startTime);
            day += cachNgay) {
          toDoDays.add(day);
        }
        int doDay = 0, failDay = 0;
        for (int i = 0; i < toDoDays.length; i++) {
          if (doneDay.contains(toDoDays[i])) {
            doDay++;
          } else
            failDay++;
        }
        setState(() {
          doDays = doDay.toString();
          dataMap['Done'] = doDay * 1.0;
          failDays = failDay.toString();
          dataMap['Miss'] = failDay * 1.0;
        });
      } else if (database[0]['LOAIHINH'] == 'Flexible') {
        // Đếm từng tuần của flexible
        // Lấy thứ của ngày bắt đầu
        String thu =
            DateFormat('EEEE').format(intToDateTime(database[0]['NGAYBATDAU']));
        List<String> daysofWeek = [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday'
        ];
        List<int> timesByWeek = [];
        int indexThu = daysofWeek.indexOf(thu);
        int times = database[0]['SOLAN'];
        int startDay = database[0]['NGAYBATDAU'];
        if (startDay + 6 - indexThu < dateTimeToInt(startTime)) {
          int plus = 0, count = 0;
          for (int i = indexThu; i < 7; i++) {
            if (doneDay.contains(startDay + plus)) {
              count++;
            }
            plus++;
          }
          if (count >= times) {
            timesByWeek.add(1);
          } else
            timesByWeek.add(0);
          print(timesByWeek);
          int changeWeek = 0;
          count = 0;
          for (int date = startDay + 7 - indexThu;
              date < dateTimeToInt(startTime);
              date++) {
            print('nextWeek');
            if (doneDay.contains(date)) count++;
            changeWeek++;
            if (changeWeek == 7) {
              changeWeek = 0;
              if (count >= times)
                timesByWeek.add(1);
              else
                timesByWeek.add(0);
              //print('count: $count, time: $times');
            }
          }
          int streak = 0;
          // đếm Streak
          for (int i = timesByWeek.length - 1; i >= 0; i--) {
            if (timesByWeek[i] == 1) {
              streak++;
            } else {
              break;
            }
          }
          setState(() {
            consecutiveDays = streak.toString();
          });
          //Đếm số lần fail lần done
          int doDay = 0, failDay = 0;
          for (int i = 0; i < timesByWeek.length; i++) {
            if (timesByWeek[i] == 1) {
              doDay++;
            } else
              failDay++;
          }
          setState(() {
            doDays = doDay.toString();
            dataMap['Done'] = doDay * 1.0;
            failDays = failDay.toString();
            dataMap['Miss'] = failDay * 1.0;
          });
        }
      }
    }
    setState(() {
      _markedDateMap.clear();
    });
    for (int i = 0; i < listDoneDay.length; i++) {
      setState(() {
        _markedDateMap.add(
          listDoneDay[i],
          new Event(
            date: listDoneDay[i],
            title: 'Event 5',
            icon: _presentIcon(
              listDoneDay[i].day.toString(),
            ),
          ),
        );
      });
    }
    for (int i = 0; i < listMissDay.length; i++) {
      setState(() {
        _markedDateMap.add(
          listMissDay[i],
          new Event(
            date: listMissDay[i],
            title: 'Event 5',
            icon: _absentIcon(
              listMissDay[i].day.toString(),
            ),
          ),
        );
      });
    }
    print('listDoneDay2: $listDoneDay');
    print(listMissDay);
  }

  void deleteActivity() {
    String key = widget.activityKey;
    dbHelper.rawQuery('''delete from MUCTIEU where MAMUCTIEU='$key' ''');
    dbHelper.rawQuery('''delete from THONGKE where MAMUCTIEU='$key' ''');
    Navigator.pop(context);
  }

  static Widget _absentIcon(String day) => CircleAvatar(
        radius: 10,
        backgroundColor: Colors.red,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );
  static Widget _presentIcon(String day) => CircleAvatar(
        radius: 10,
        backgroundColor: Colors.green,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );
  CalendarCarousel _calendarCarouselNoHeader;
  void markDays() {}
  Widget debugWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
      child: Center(
        child: Row(children: [
          Text(
            "To date: ",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            startTime.toString().substring(0, 10),
            style: TextStyle(fontSize: 20),
          ),
          FlatButton.icon(
            icon: Icon(Icons.date_range),
            onPressed: () async {
              await showDatePicker(
                      context: context,
                      initialDate: startTime,
                      firstDate: DateTime.utc(2020, 1, 1),
                      lastDate: DateTime.utc(2120, 31, 12))
                  .then((date) {
                setState(() {
                  if (date != null) startTime = date;
                });
              });
              getData();
            },
            label: Text(""),
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    cHeight = MediaQuery.of(context).size.height;
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      selectedDayButtonColor: Colors.purple,
      selectedDateTime: _selectedDateTime,
      targetDateTime: _targetedDateTime,
      height: cHeight * 0.54,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      selectedDayBorderColor: Colors.black38,
      showOnlyCurrentMonthDate: false,
      todayButtonColor: Colors.cyan,
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal:
          null, // null for not showing hidden events indicator
      onDayPressed: (date, event) {
        setState(() {
          _selectedDateTime = date;
          _targetedDateTime = date;
          if (date.year == 2021) {
            print('Fuck');
          }
        });
      },
      markedDateIconBuilder: (event) {
        return event.icon;
      },
    );
    return Container(
      child: Scaffold(
          body: ListView(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 15, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
              ),
              Text(name, style: TextStyle(fontSize: 30)),
              SizedBox(
                width: 20,
              ),
              InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditActivity(
                              activityKey: widget.activityKey,
                              activityName: widget.activityName)),
                    );
                    getData();
                  },
                  child: Icon(Icons.edit)),
              SizedBox(
                width: 20,
              ),
              InkWell(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text("Message"),
                              content: Text(
                                  "Are you sure to delete this activity ?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    deleteActivity();
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
                  },
                  child: Icon(Icons.delete)),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: 100,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    Container(
                      width: 300,
                      decoration: new BoxDecoration(
                          color: Color(0xffebe8e1),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: ListTile(
                          leading: Icon(
                            Icons.fireplace,
                            size: 60,
                            color: Color(0xffd40f23),
                          ),
                          title: Text(
                            "Streak",
                            style: TextStyle(fontSize: 23),
                          ),
                          subtitle: Text('$consecutiveDays Consecutive days'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 300,
                      decoration: new BoxDecoration(
                          color: Color(0xffebe8e1),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: ListTile(
                          leading: Icon(Icons.calendar_today,
                              color: Colors.cyan, size: 50),
                          title:
                              Text("Start day", style: TextStyle(fontSize: 23)),
                          subtitle: Text(activityStartDay),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 300,
                      decoration: new BoxDecoration(
                          color: Color(0xffebe8e1),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: ListTile(
                          leading: Icon(Icons.done_outlined,
                              color: Colors.green, size: 50),
                          title: Text(doDays),
                          subtitle: Text('Done times'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 300,
                      decoration: new BoxDecoration(
                          color: Color(0xffebe8e1),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: ListTile(
                          leading:
                              Icon(Icons.block, color: Colors.red, size: 50),
                          title: Text(failDays),
                          subtitle: Text('Missed Times'),
                        ),
                      ),
                    ),
                  ])),
        ),
        _calendarCarouselNoHeader,
        SizedBox(height: 30),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/chart.png',
                  width: 50,
                  height: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Chart',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            )),
        PieChart(
          chartRadius: 200,
          dataMap: dataMap,
          chartType: ChartType.disc,
        )
      ])),
    );
  }
}
