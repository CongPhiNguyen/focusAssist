import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:table_calendar/table_calendar.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int dropdownValue;
  List<Widget> activitiesWidgetList = [];
  CalendarFormat _calendarFormat;
  DateTime currentDayTime;
  int totalActivityCompletedCount;
  int totalActivityMissedCount;
  int overallPercentage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = 1;
    _calendarFormat = CalendarFormat.week;
    currentDayTime = DateTime.now();
    totalActivityCompletedCount = 0;
    totalActivityMissedCount = 0;
    overallPercentage = 100;
    LoadActivityList();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
          child: ListView(
            children: <Widget>[
              TableCalendar(
                calendarFormat: _calendarFormat,
                focusedDay: currentDayTime,
                startingDayOfWeek: StartingDayOfWeek.monday,
                availableCalendarFormats: {
                  CalendarFormat.week: 'Week',
                  CalendarFormat.month: 'Month',
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                  LoadActivityList();
                },
                onPageChanged: (day) {
                  setState(() {
                    currentDayTime = day;
                  });
                  LoadActivityList();
                },
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
              ),
              Divider(height: 15.0, thickness: 2.0, indent: 0),
              SizedBox(height: 15.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        '$totalActivityCompletedCount',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        'Activities Completed',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        '$totalActivityMissedCount',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        'Activities Uncompleted',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(20.0),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blue,
                        width: 5.0,
                      ),
                    ),
                    height: 100.0,
                    width: 100.0,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '$overallPercentage%',
                            style: TextStyle(
                              fontSize: 20.0,
                              //color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            'Overall',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Divider(height: 15.0, thickness: 2.0, indent: 0),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Activities',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: Colors.grey[800],
                      ),
                    ),
                    DropdownButton(
                      value: dropdownValue,
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value;
                        });
                        LoadActivityList();
                      },
                      items: <DropdownMenuItem>[
                        DropdownMenuItem(
                          value: 1,
                          child: Text(
                            'Completion Rate',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text(
                            'Calendar',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(height: 15.0, thickness: 2.0, indent: 0),
              Column(
                // children: <Widget>[
                //   ListTile(
                //     tileColor: Colors.white,
                //     title: Text('Đọc sách'),
                //     trailing: WeeklyProgressCalendar(),
                //   ),
                //   Divider(height: 5.0, thickness: 2.0, indent: 0),
                // ],
                children: (activitiesWidgetList == null)?[]:activitiesWidgetList,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<List<Map<String, dynamic>>> GetActivityList() async {
  //   Database db = await DbProvider.instance.database;
  //   List<dynamic> whereArgsList = ['ND001'];
  //   List<Map<String, dynamic>> queryRows = await db.query('MUCTIEU', where: 'MANGUOIDUNG = ?', whereArgs: whereArgsList);
  //   return queryRows;
  // }

  Future<void> LoadActivityList() async {
    print('Start LoadActivitiesList');
    int totalCompleted = 0;
    int totalMissed = 0;
    List<Widget> widgetList = [];
    DateTime firstDay, lastDay, previousFirstDay, previousLastDay;
    if (_calendarFormat == CalendarFormat.week) {
      firstDay = currentDayTime.subtract(Duration(days: currentDayTime.weekday - 1));
      firstDay = new DateTime(firstDay.year, firstDay.month, firstDay.day);
      lastDay = firstDay.add(Duration(days: 6));
      previousFirstDay = firstDay.subtract(Duration(days: 7));
      previousLastDay = lastDay.subtract(Duration(days: 7));
    }
    else if (_calendarFormat == CalendarFormat.month) {
      firstDay = currentDayTime.subtract(Duration(days: currentDayTime.day - 1));
      firstDay = new DateTime(firstDay.year, firstDay.month, firstDay.day);
      lastDay = firstDay.add(Duration(days: NumberOfDaysInMonth(currentDayTime.month, currentDayTime.year) - 1));
      previousLastDay = firstDay.subtract(Duration(days: 1));
      previousFirstDay = previousLastDay.subtract(Duration(days: previousLastDay.day - 1));
    }
    print('firstDay: $firstDay');
    print('lastDay: $lastDay');
    print('previousFirstDay: $previousFirstDay');
    print('previousLastDay: $previousLastDay');
    Database db = await DbProvider.instance.database;
    List<dynamic> whereArgsList = ['ND001'];
    List<Map<String, dynamic>> activitiesList = await db.query('MUCTIEU',
        where: 'MANGUOIDUNG = ?', whereArgs: whereArgsList);
    for (int i = 0; i < activitiesList.length; i++) {
      // print('element: ${activitiesList[i]}');
      // //Database activityData = await DbProvider.instance.database;
      //
      // List<dynamic> whereArgs = [
      //   '${activitiesList[i]['MAMUCTIEU'].toString()}',
      //   DateTimeToInt(firstDay),
      //   DateTimeToInt(lastDay),
      // ];
      //
      // print('WhereArgs: $whereArgs');
      //
      // List<Map<String, dynamic>> activitiesDataList = await db.query('THONGKE',
      //     where: 'MAMUCTIEU = ? AND NGAYHOANTHANH >= ? AND NGAYHOANTHANH <= ?', whereArgs: whereArgs);
      // print('activitiesDataList: $activitiesDataList');
      //
      // List<bool> activitiesDataListBool = [];
      // int boolListLength = (_calendarFormat == CalendarFormat.week)?7:NumberOfDaysInMonth(currentDayTime.month, currentDayTime.year);
      // for (int i = 0; i < boolListLength; i++) {
      //   activitiesDataListBool.add(false);
      // }
      // for (int i = 0; i < activitiesDataList.length; i++) {
      //   // String dateString = activitiesDataList[i]['NGAYHOANTHANH'].toString();
      //   // List<String> dateStringSplit = dateString.split('/');
      //   // DateTime dateTime = DateTime(int.parse(dateStringSplit[2]), int.parse(dateStringSplit[1]), int.parse(dateStringSplit[0]));
      //   DateTime dateTime = IntToDateTime(activitiesDataList[i]['NGAYHOANTHANH']);
      //   print('dateTime: $dateTime');
      //   if (_calendarFormat == CalendarFormat.week) activitiesDataListBool[dateTime.difference(firstDay).inDays] = true;
      //   else if (_calendarFormat == CalendarFormat.month) activitiesDataListBool[dateTime.day - 1] = true;
      // }
      // print(activitiesDataListBool);
      if (DateTimeToInt(lastDay) < activitiesList[i]['NGAYBATDAU']) continue;
      List<bool> activityDataListBool = await GetActivityListBool(activitiesList[i], firstDay, lastDay);
      List<bool> previousActivityListBool = await GetActivityListBool(activitiesList[i], previousFirstDay, previousLastDay);

      ListTile listTile = new ListTile(
        title: Text('${activitiesList[i]['TENMUCTIEU'].toString()}', overflow: TextOverflow.ellipsis,),
        trailing: _getActivityDetail(activitiesList[i], activityDataListBool, previousActivityListBool, firstDay, lastDay, previousFirstDay, previousLastDay),
      );
      Divider divider = new Divider(
        height: 10.0,
        thickness: 1.0,
        indent: 0,
      );
      widgetList.add(listTile);
      widgetList.add(divider);

      List<int> activityCompleteMissCount = GetActivityCompletedMissedCount(activitiesList[i], activityDataListBool, firstDay, lastDay);
      print('Activity: ${activitiesList[i]['TENMUCTIEU']}');
      print('ActivityCompletedCount: ${activityCompleteMissCount[0]}');
      print('ActivityMissedCount: ${activityCompleteMissCount[1]}');
      totalCompleted += activityCompleteMissCount[0];
      totalMissed += activityCompleteMissCount[1];
    }
    setState(() {
      activitiesWidgetList = widgetList;
      totalActivityCompletedCount = totalCompleted;
      totalActivityMissedCount = totalMissed;
      overallPercentage = ((totalCompleted + totalMissed) != 0)?((totalActivityCompletedCount.toDouble() / (totalActivityMissedCount + totalActivityCompletedCount).toDouble() * 100).round()):100;
    });
    print('End LoadActivitiesList');
  }

  Future<List<bool>> GetActivityListBool(Map<String, dynamic> activity, DateTime firstDay, DateTime lastDay) async {
    print('element: $activity');
    Database activityData = await DbProvider.instance.database;

    List<dynamic> whereArgs = [
      '${activity['MAMUCTIEU'].toString()}',
      DateTimeToInt(firstDay),
      DateTimeToInt(lastDay),
    ];

    print('WhereArgs: $whereArgs');

    List<Map<String, dynamic>> activitiesDataList = await activityData.query('THONGKE',
        where: 'MAMUCTIEU = ? AND NGAYHOANTHANH >= ? AND NGAYHOANTHANH <= ?', whereArgs: whereArgs);
    print('activitiesDataList: $activitiesDataList');

    List<bool> activitiesDataListBool = [];
    print('NumberOfDaysInMonth: ${NumberOfDaysInMonth(firstDay.month, firstDay.year)}');
    int boolListLength = (_calendarFormat == CalendarFormat.week)?7:NumberOfDaysInMonth(firstDay.month, firstDay.year);
    print('boolListLength: $boolListLength');
    for (int i = 0; i < boolListLength; i++) {
      activitiesDataListBool.add(false);
    }
    print('activitiesDataListBool.length: ${activitiesDataListBool.length}');
    for (int i = 0; i < activitiesDataList.length; i++) {
      DateTime dateTime = IntToDateTime(activitiesDataList[i]['NGAYHOANTHANH']);
      print('dateTime: $dateTime');
      if (_calendarFormat == CalendarFormat.week) activitiesDataListBool[dateTime.difference(firstDay).inDays] = true;
      else if (_calendarFormat == CalendarFormat.month) activitiesDataListBool[dateTime.day - 1] = true;
    }
    print(activitiesDataListBool);
    return activitiesDataListBool;
  }

  Widget _getActivityDetail(Map<String, dynamic> activity, List<bool> completedDayList, List<bool> previousCompledtedDayList, DateTime firstDay, DateTime lastDay, DateTime previousFirstDay, DateTime previousLastDay) {
    if (dropdownValue == 1) {
      if (_calendarFormat == CalendarFormat.week) return ActivityWeeklyPercentage(activity, completedDayList, previousCompledtedDayList, firstDay, lastDay, previousFirstDay, previousLastDay);
      else if (_calendarFormat == CalendarFormat.month) {
        return ActivityMonthlyPercentage(activity, completedDayList, previousCompledtedDayList, firstDay, lastDay, previousFirstDay, previousLastDay);
        // return Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: <Widget>[
        //     Text(
        //       '70%',
        //     ),
        //     Icon(
        //       Icons.arrow_drop_up,
        //       size: 24.0,
        //     ),
        //     Text(
        //       '20%',
        //       style: TextStyle(
        //         color: Colors.blue,
        //       ),
        //     ),
        //   ],
        // );
      }
    } else if (dropdownValue == 2) {
      if (_calendarFormat == CalendarFormat.week) {
        return ActivityWeeklyProgressCalendar(completedDayList, 12);
      }
      else if (_calendarFormat == CalendarFormat.month) return ActivityMonthlyProgressCalendar(completedDayList);
    };
  }

  Widget ActivityWeeklyProgressCalendar(List<bool> completedDayList, double boxSize) {
    Row row = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[],
    );
    for (int i = 0; i < completedDayList.length; i++) {
      SizedBox sizedBox;
      if (completedDayList[i]) {
        sizedBox = new SizedBox(
          height: boxSize,
          width: boxSize,
          child: Container(color: Colors.blue[300],),
        );
      }
      else {
        sizedBox = new SizedBox(
          height: boxSize,
          width: boxSize,
          child: Container(color: Colors.grey[200],),
        );
      }
      row.children.add(sizedBox);
    }
    return Wrap(
      children: <Widget>[
        SizedBox(
          width: (completedDayList.length == 7)?110:(completedDayList.length * boxSize + (completedDayList.length - 1) * 2),
          child: row,
        ),
      ],
    );
  }

  Widget ActivityMonthlyProgressCalendar(List<bool> completedDayList) {
    Column column = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [],
    );
    List<bool> subList = completedDayList.sublist(0, 10);
    column.children.add(ActivityWeeklyProgressCalendar(subList, 8));
    subList = completedDayList.sublist(11, 21);
    column.children.add(ActivityWeeklyProgressCalendar(subList, 8));
    subList = completedDayList.sublist(22);
    column.children.add(ActivityWeeklyProgressCalendar(subList, 8));
    Wrap wrap = new Wrap(
      children: <Widget>[
        SizedBox(
          height: 28,
          width: 108,
          child: column,
        ),
      ],
    );
    return wrap;
    // int numberOfDays = NumberOfDaysInMonth(month, year);
    // for (int i = 0; i < 2; i++) {
    //   Wrap wrap = new Wrap(
    //     children: <Widget>[
    //       SizedBox(
    //         width: 108,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //             SizedBox(
    //               height: 8,
    //               width: 8,
    //               child: Container(color: Colors.grey[200],),
    //             ),
    //             SizedBox(
    //               height: 8,
    //               width: 8,
    //               child: Container(color: Colors.grey[200],),
    //             ),
    //             SizedBox(
    //               height: 8,
    //               width: 8,
    //               child: Container(color: Colors.grey[200],),
    //             ),
    //             SizedBox(
    //               height: 8,
    //               width: 8,
    //               child: Container(color: Colors.grey[200],),
    //             ),
    //             SizedBox(
    //               height: 8,
    //               width: 8,
    //               child: Container(color: Colors.grey[200],),
    //             ),
    //             SizedBox(
    //               height: 8,
    //               width: 8,
    //               child: Container(color: Colors.grey[200],),
    //             ),
    //             SizedBox(
    //               height: 8,
    //               width: 8,
    //               child: Container(color: Colors.grey[200],),
    //             ),
    //             SizedBox(
    //               height: 8,
    //               width: 8,
    //               child: Container(color: Colors.grey[200],),
    //             ),
    //             SizedBox(
    //               height: 8,
    //               width: 8,
    //               child: Container(color: Colors.grey[200],),
    //             ),
    //             SizedBox(
    //               height: 8,
    //               width: 8,
    //               child: Container(color: Colors.grey[200],),
    //             ),
    //             SizedBox(
    //               height: 8,
    //               width: 8,
    //               child: Container(color: Colors.grey[200],),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   );
    //   widgetList.add(wrap);
    // }
    // Row row = new Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: <Widget>[],
    // );
    // for (int i = 0; i < numberOfDays - 22; i++) {
    //   SizedBox sizedBox = new SizedBox(
    //     height: 8,
    //     width: 8,
    //     child: Container(color: Colors.grey[200],),
    //   );
    //   row.children.add(sizedBox);
    // }
    // Wrap wrap = new Wrap(
    //   children: <Widget>[
    //     SizedBox(
    //       width: ((numberOfDays - 22) * 8.0 + (numberOfDays - 23) * 2),
    //       child: row,
    //     ),
    //   ],
    // );
    // widgetList.add(wrap);
    // wrap = new Wrap(
    //   children: <Widget>[
    //     SizedBox(
    //       height: 28,
    //       width: 108,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: widgetList,
    //       ),
    //     ),
    //   ],
    // );
    // return wrap;
    // return Wrap(
    //   children: <Widget>[
    //     SizedBox(
    //       width: 108,
    //       height: 28,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: <Widget>[
    //           MonthlyRowProgressCalendar(),
    //           MonthlyRowProgressCalendar(),
    //           MonthlyRowProgressCalendar(),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }

  // Widget MonthlyRowProgressCalendar() {
  //   return Wrap(
  //     children: <Widget>[
  //       SizedBox(
  //         width: 108,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             SizedBox(
  //               height: 8,
  //               width: 8,
  //               child: Container(color: Colors.grey[200],),
  //             ),
  //             SizedBox(
  //               height: 8,
  //               width: 8,
  //               child: Container(color: Colors.grey[200],),
  //             ),
  //             SizedBox(
  //               height: 8,
  //               width: 8,
  //               child: Container(color: Colors.grey[200],),
  //             ),
  //             SizedBox(
  //               height: 8,
  //               width: 8,
  //               child: Container(color: Colors.grey[200],),
  //             ),
  //             SizedBox(
  //               height: 8,
  //               width: 8,
  //               child: Container(color: Colors.grey[200],),
  //             ),
  //             SizedBox(
  //               height: 8,
  //               width: 8,
  //               child: Container(color: Colors.grey[200],),
  //             ),
  //             SizedBox(
  //               height: 8,
  //               width: 8,
  //               child: Container(color: Colors.grey[200],),
  //             ),
  //             SizedBox(
  //               height: 8,
  //               width: 8,
  //               child: Container(color: Colors.grey[200],),
  //             ),
  //             SizedBox(
  //               height: 8,
  //               width: 8,
  //               child: Container(color: Colors.grey[200],),
  //             ),
  //             SizedBox(
  //               height: 8,
  //               width: 8,
  //               child: Container(color: Colors.grey[200],),
  //             ),
  //             SizedBox(
  //               height: 8,
  //               width: 8,
  //               child: Container(color: Colors.grey[200],),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  int NumberOfDaysInMonth(int month, int year) {
    List<int> numberOfDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (month != 2) return numberOfDays[month - 1];
    if (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)) return 29;
    return 28;
  }

  Widget ActivityWeeklyPercentage(Map<String, dynamic> activity, List<bool> completedDayList, List<bool> previousCompletedDayList, DateTime firstDay, DateTime lastDay, DateTime previousFirstDay, DateTime previousLastDay) {
    int weekPercentage = CalculateActivityWeekPercentage(activity, completedDayList, firstDay, lastDay);
    int previousWeekPercentage;
    if ((DateTimeToInt(currentDayTime) > DateTimeToInt(DateTime.now()))
        || (DateTimeToInt(currentDayTime) <= DateTimeToInt(IntToDateTime(activity['NGAYBATDAU']).add(Duration(days: 7 - IntToDateTime(activity['NGAYBATDAU']).weekday))))) {
      previousWeekPercentage = -1;
    }
    else previousWeekPercentage = CalculateActivityWeekPercentage(activity, previousCompletedDayList, previousFirstDay, previousLastDay);
    print('weekPercentage: $weekPercentage');
    print('previousWeekPercentage: $previousWeekPercentage');

    Row row = new Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '$weekPercentage%',
        ),
      ],
    );

    if (previousWeekPercentage != -1) {
      Icon icon = new Icon(
        (weekPercentage >= previousWeekPercentage)?Icons.arrow_drop_up:Icons.arrow_drop_down,
        color: (weekPercentage >= previousWeekPercentage)?Colors.green:Colors.red,
        size: 24.0,
      );
      SizedBox sizedBox = new SizedBox(
        width: 35,
        child: Text(
          '$previousWeekPercentage%',
          style: TextStyle(
            color: (weekPercentage >= previousWeekPercentage)?Colors.green:Colors.red,
          ),
        ),
      );
      row.children.add(icon);
      row.children.add(sizedBox);
    }
    else {
      SizedBox emptySizedBox = new SizedBox(width: 20,);
      row.children.add(emptySizedBox);
    }

    return row;
  }

  int CalculateActivityWeekPercentage(Map<String, dynamic> activity, List<bool> completedDayList, DateTime firstDay, DateTime lastDay) {
    int percentage;
    // if ((_calendarFormat == CalendarFormat.week) && (DateTimeToInt(currentDayTime) > DateTimeToInt(DateTime.now().add(Duration(days: 7 - DateTime.now().weekday))))) {
    //   return 0;
    // }
    List<int> activityCompletedMissedCount = GetActivityCompletedMissedCount(activity, completedDayList, firstDay, lastDay);
    int activityCompletedCount = activityCompletedMissedCount[0];
    int activityMissedCount = activityCompletedMissedCount[1];
    if (activityCompletedCount + activityMissedCount != 0) percentage = ((activityCompletedCount.toDouble() / (activityCompletedCount + activityMissedCount).toDouble()) * 100).round();
    else percentage = 100;
    return percentage;
  }

    // if (activity['LOAIHINH'] == 'FIXED') {
    //   String activityDayString = activity['CACNGAY'].toString();
    //   int activityDayCount = 0;
    //   int completedDayCount = 0;
    //   DateTime firstDayOfWeek = currentDayTime.subtract(Duration(days: currentDayTime.weekday - 1));
    //   if (DateTimeToInt(firstDayOfWeek) >= activity['NGAYBATDAU']) {
    //     for (int i = 0; i < activityDayString.length; i++) {
    //       if (activityDayString[i] == '1') activityDayCount++;
    //     }
    //   }
    //   else {
    //     DateTime startDay = IntToDateTime(activity['NGAYBATDAU']);
    //     int startWeekday = startDay.weekday - 1;
    //     for (int i = startWeekday; i < activityDayString.length; i++) {
    //       if (activityDayString[i] == '1') activityDayCount++;
    //     }
    //   }
    //   for (int i = 0; i < completedDayList.length; i++) {
    //     if (completedDayList[i] == true) completedDayCount++;
    //   }
    //   percentage = (completedDayCount / activityDayCount * 100).round();
    // }
    // else if (activity['LOAIHINH'] == 'FLEXIBLE') {
    //   int completedDayCount = 0;
    //   for (int i = 0; i < completedDayList.length; i++) {
    //     if (completedDayList[i] == true) completedDayCount++;
    //   }
    //   percentage = (completedDayCount / activity['SOLAN'] * 100).round();
    // }
    // else if (activity['LOAIHINH'] == 'REPEATING') {
    //   int activityDayCount = 0;
    //   int completedDayCount = 0;
    //   for (int i = 0; i < completedDayList.length; i++) {
    //     if (completedDayList[i] == true) completedDayCount++;
    //   }
    //   DateTime dateTime = currentDayTime.add(Duration(days: 7 - currentDayTime.weekday));
    //   dateTime = new DateTime(dateTime.year, dateTime.month, dateTime.day);
    //   int dayDifference = dateTime.difference(IntToDateTime(activity['NGAYBATDAU'])).inDays;
    //   dayDifference = dayDifference % activity['KHOANGTHOIGIAN'];
    //   if (dayDifference < 7) {
    //     DateTime weekLastCompletedDay = dateTime.subtract(Duration(days: dayDifference));
    //     activityDayCount++;
    //     int weekDay = weekLastCompletedDay.weekday;
    //     while (weekDay > 1 && weekDay > activity['KHOANGTHOIGIAN']) {
    //       weekDay -= activity['KHOANGTHOIGIAN'];
    //       activityDayCount++;
    //     }
    //   }
    //   if (activityDayCount == 0) percentage = 100;
    //   percentage = (completedDayCount / activityDayCount * 100).round();
    // }


  // int CalculateActivityPreviousWeekPercentage(Map<String, dynamic> activity, List<bool> completedDayList) {
  //   int percentage;
  //   if (activity['LOAIHINH'] == 'FIXED') {
  //     String activityDayString = activity['CACNGAY'].toString();
  //     int activityDayCount = 0;
  //     int completedDayCount = 0;
  //     DateTime firstDayOfWeek = currentDayTime.subtract(Duration(days: currentDayTime.weekday - 1));
  //     firstDayOfWeek = firstDayOfWeek.subtract(Duration(days: 7));
  //     if (DateTimeToInt(firstDayOfWeek) >= activity['NGAYBATDAU']) {
  //       for (int i = 0; i < activityDayString.length; i++) {
  //         if (activityDayString[i] == '1') activityDayCount++;
  //       }
  //     }
  //     else {
  //       DateTime startDay = IntToDateTime(activity['NGAYBATDAU']);
  //       int startWeekday = startDay.weekday - 1;
  //       for (int i = startWeekday; i < activityDayString.length; i++) {
  //         if (activityDayString[i] == '1') activityDayCount++;
  //       }
  //     }
  //     for (int i = 0; i < completedDayList.length; i++) {
  //       if (completedDayList[i] == true) completedDayCount++;
  //     }
  //     percentage = (completedDayCount / activityDayCount * 100).round();
  //   }
  //   else if (activity['LOAIHINH'] == 'FLEXIBLE') {
  //     int completedDayCount = 0;
  //     for (int i = 0; i < completedDayList.length; i++) {
  //       if (completedDayList[i] == true) completedDayCount++;
  //     }
  //     percentage = (completedDayCount / activity['SOLAN'] * 100).round();
  //   }
  //   else if (activity['LOAIHINH'] == 'REPEATING') {
  //     int activityDayCount = 0;
  //     int completedDayCount = 0;
  //     for (int i = 0; i < completedDayList.length; i++) {
  //       if (completedDayList[i] == true) completedDayCount++;
  //     }
  //     DateTime dateTime = currentDayTime.add(Duration(days: 7 - currentDayTime.weekday));
  //     dateTime = new DateTime(dateTime.year, dateTime.month, dateTime.day);
  //     int dayDifference = dateTime.difference(IntToDateTime(activity['NGAYBATDAU'])).inDays;
  //     dayDifference = dayDifference % activity['KHOANGTHOIGIAN'];
  //     if (dayDifference < 7) {
  //       DateTime weekLastCompletedDay = dateTime.subtract(Duration(days: dayDifference));
  //       activityDayCount++;
  //       int weekDay = weekLastCompletedDay.weekday;
  //       while (weekDay > 1 && weekDay > activity['KHOANGTHOIGIAN']) {
  //         weekDay -= activity['KHOANGTHOIGIAN'];
  //         activityDayCount++;
  //       }
  //     }
  //     if (activityDayCount == 0) percentage = 100;
  //     percentage = (completedDayCount / activityDayCount * 100).round();
  //   }
  //   return percentage;
  // }

  // List<int> GetActivityCompletedMissedCount(Map<String, dynamic> activity, List<bool> completedDayList) {
  //   List<int> listInt = [];
  //   int activityDayCount = 0;
  //   int activityCompletedCount = 0;
  //
  //
  //   if (_calendarFormat == CalendarFormat.week) {
  //     if (DateTimeToInt(currentDayTime) < DateTimeToInt(IntToDateTime(activity['NGAYBATDAU']).subtract(Duration(days: IntToDateTime(activity['NGAYBATDAU']).weekday - 1)))
  //       || DateTimeToInt(currentDayTime) > DateTimeToInt(DateTime.now().add(Duration(days: 7 - DateTime.now().weekday)))) {
  //       activityDayCount = 0;
  //       activityCompletedCount = 0;
  //     }
  //     else {
  //       if (activity['LOAIHINH'] == 'FIXED') {
  //         String activityDayString = activity['CACNGAY'].toString();
  //         DateTime firstDayOfWeek = currentDayTime.subtract(Duration(days: currentDayTime.weekday - 1));
  //         if (DateTimeToInt(firstDayOfWeek) >= activity['NGAYBATDAU']) {
  //           for (int i = 0; i < activityDayString.length; i++) {
  //             if (activityDayString[i] == '1') activityDayCount++;
  //           }
  //         }
  //         else {
  //           DateTime startDay = IntToDateTime(activity['NGAYBATDAU']);
  //           int startWeekday = startDay.weekday - 1;
  //           for (int i = startWeekday; i < activityDayString.length; i++) {
  //             if (activityDayString[i] == '1') activityDayCount++;
  //           }
  //         }
  //       }
  //       else if (activity['LOAIHINH'] == 'FLEXIBLE') {
  //         DateTime firstDayOfWeek = currentDayTime.subtract(Duration(days: currentDayTime.weekday - 1));
  //         if (DateTimeToInt(firstDayOfWeek) >= activity['NGAYBATDAU']) activityDayCount = activity['SOLAN'];
  //         else {
  //           DateTime startDay = IntToDateTime(activity['NGAYBATDAU']);
  //           activityDayCount = (((7 - startDay.weekday + 1).toDouble() / 7.0) * activity['SOLAN']).floor();
  //         }
  //
  //       }
  //       else if (activity['LOAIHINH'] == 'REPEATING') {
  //         DateTime dateTime = currentDayTime.add(Duration(days: 7 - currentDayTime.weekday));
  //         dateTime = new DateTime(dateTime.year, dateTime.month, dateTime.day);
  //         int dayDifference = dateTime.difference(IntToDateTime(activity['NGAYBATDAU'])).inDays;
  //         dayDifference = dayDifference % activity['KHOANGTHOIGIAN'];
  //         if (dayDifference < 7) {
  //           DateTime weekLastCompletedDay = dateTime.subtract(Duration(days: dayDifference));
  //           activityDayCount++;
  //           int weekDay = weekLastCompletedDay.weekday;
  //           while (weekDay > 1 && weekDay > activity['KHOANGTHOIGIAN']) {
  //             weekDay -= activity['KHOANGTHOIGIAN'];
  //             activityDayCount++;
  //           }
  //         }
  //       }
  //       for (int i = 0; i < completedDayList.length; i++) {
  //         if (completedDayList[i] == true) activityCompletedCount++;
  //       }
  //     }
  //   }
  //   else if (_calendarFormat == CalendarFormat.month) {
  //
  //     if (DateTimeToInt(currentDayTime) < DateTimeToInt(IntToDateTime(activity['NGAYBATDAU']).subtract(Duration(days: IntToDateTime(activity['NGAYBATDAU']).day - 1)))
  //         || DateTimeToInt(currentDayTime) > DateTimeToInt(DateTime.now().add(Duration(days: NumberOfDaysInMonth(DateTime.now().month, DateTime.now().year) - DateTime.now().day)))) {
  //       activityDayCount = 0;
  //       activityCompletedCount = 0;
  //     }
  //     else {
  //       if (activity['LOAIHINH'] == 'FIXED') {
  //         String activityDayString = activity['CACNGAY'].toString();
  //         // int timesPerWeek = 0;
  //         // for (int i = 0; i < activityDayString.length; i++) {
  //         //   if (activityDayString[i] == '1') timesPerWeek++;
  //         // }
  //         DateTime firstDayOfMonth = currentDayTime.subtract(Duration(days: currentDayTime.day - 1));
  //         DateTime lastDayOfMonth = firstDayOfMonth.add(Duration(days: NumberOfDaysInMonth(firstDayOfMonth.month, firstDayOfMonth.year) - 1));
  //         DateTime firstDayOfWeek = firstDayOfMonth;
  //         DateTime lastDayOfWeek = firstDayOfWeek.add(Duration(days: 7 - firstDayOfWeek.weekday));
  //
  //         while((DateTimeToInt(lastDayOfWeek) < activity['NGAYBATDAU']) && (DateTimeToInt(lastDayOfWeek) < DateTimeToInt(lastDayOfMonth))) {
  //           lastDayOfWeek = lastDayOfWeek.add(Duration(days: 7));
  //           if (DateTimeToInt(lastDayOfWeek) > DateTimeToInt(lastDayOfMonth)) lastDayOfWeek = lastDayOfMonth;
  //           firstDayOfWeek = lastDayOfWeek.subtract(Duration(days: lastDayOfWeek.weekday - 1));
  //         }
  //         while(DateTimeToInt(lastDayOfWeek) <= DateTimeToInt(lastDayOfMonth)) {
  //           for (int i = firstDayOfWeek.weekday - 1; i < lastDayOfWeek.weekday; i++) {
  //             if (activityDayString[i] == '1') activityDayCount++;
  //           }
  //           lastDayOfWeek = lastDayOfWeek.add(Duration(days: 7));
  //           firstDayOfWeek = lastDayOfWeek.subtract(Duration(days: lastDayOfWeek.weekday - 1));
  //         }
  //         if (DateTimeToInt(firstDayOfWeek) <= DateTimeToInt(lastDayOfMonth)) {
  //           if (DateTimeToInt(lastDayOfWeek) > DateTimeToInt(lastDayOfMonth)) lastDayOfWeek = lastDayOfMonth;
  //           for (int i = firstDayOfWeek.weekday - 1; i < lastDayOfWeek.weekday; i++) {
  //             if (activityDayString[i] == '1') activityDayCount++;
  //           }
  //         }
  //       }
  //       else if (activity['LOAIHINH'] == 'FLEXIBLE') {
  //         DateTime firstDayOfMonth = currentDayTime.subtract(Duration(days: currentDayTime.day - 1));
  //         if (DateTimeToInt(firstDayOfMonth) >= activity['NGAYBATDAU']) activityDayCount = ((NumberOfDaysInMonth(firstDayOfMonth.month, firstDayOfMonth.year).toDouble() / 7.0) * activity['SOLAN']).floor();
  //         else {
  //           DateTime startDay = IntToDateTime(activity['NGAYBATDAU']);
  //           activityDayCount = (((NumberOfDaysInMonth(firstDayOfMonth.month, firstDayOfMonth.year) - startDay.day + 1).toDouble() / 7.0) * activity['SOLAN']).floor();
  //         }
  //       }
  //       else if (activity['LOAIHINH'] == 'REPEATING') {
  //         DateTime firstDayOfMonth = currentDayTime.subtract(Duration(days: currentDayTime.day - 1));
  //         firstDayOfMonth = new DateTime(firstDayOfMonth.year, firstDayOfMonth.month, firstDayOfMonth.day);
  //
  //         if (DateTimeToInt(firstDayOfMonth) >= activity['NGAYBATDAU']) {
  //           int dayDifference = firstDayOfMonth.difference(IntToDateTime(activity['NGAYBATDAU'])).inDays;
  //           dayDifference = dayDifference % activity['KHOANGTHOIGIAN'];
  //           DateTime firstActivityDay;
  //           if (dayDifference > 0) firstActivityDay = firstDayOfMonth.add(Duration(days: activity['KHOANGTHOIGIAN'] - dayDifference));
  //           else firstActivityDay = firstDayOfMonth;
  //           activityDayCount = ((NumberOfDaysInMonth(firstDayOfMonth.month, firstDayOfMonth.year) - firstActivityDay.day).toDouble() / 3).floor() + 1;
  //         }
  //         else {
  //           DateTime firstActivityDay;
  //           firstActivityDay = IntToDateTime(activity['NGAYBATDAU']);
  //           activityDayCount = ((NumberOfDaysInMonth(firstDayOfMonth.month, firstDayOfMonth.year) - firstActivityDay.day).toDouble() / 3).floor() + 1;
  //         }
  //       }
  //       for (int i = 0; i < completedDayList.length; i++) {
  //         if (completedDayList[i] == true) activityCompletedCount++;
  //       }
  //     }
  //   }
  //   if ((activity['LOAIHINH'] == 'FLEXIBLE') && activityCompletedCount > activityDayCount ) {
  //     activityCompletedCount = activityDayCount;
  //   }
  //   listInt.add(activityCompletedCount);
  //   listInt.add(activityDayCount - activityCompletedCount);
  //   return listInt;
  // }

  List<int> GetActivityCompletedMissedCount(Map<String, dynamic> activity, List<bool> completedDayList, DateTime firstDay, DateTime lastDay) {
    List<int> listInt = [];
    int activityDayCount = 0;
    int activityCompletedCount = 0;

    if (_calendarFormat == CalendarFormat.week) {
      // if (DateTimeToInt(currentDayTime) < DateTimeToInt(IntToDateTime(activity['NGAYBATDAU']).subtract(Duration(days: IntToDateTime(activity['NGAYBATDAU']).weekday - 1)))
      //     || DateTimeToInt(currentDayTime) > DateTimeToInt(DateTime.now().add(Duration(days: 7 - DateTime.now().weekday)))) {
      //   activityDayCount = 0;
      //   activityCompletedCount = 0;
      // }
      if (DateTimeToInt(currentDayTime) < DateTimeToInt(IntToDateTime(activity['NGAYBATDAU']).subtract(Duration(days: IntToDateTime(activity['NGAYBATDAU']).weekday - 1)))) {
        activityDayCount = 0;
        activityCompletedCount = 0;
      }
      else {
        if (activity['LOAIHINH'] == 'FIXED') {
          String activityDayString = activity['CACNGAY'].toString();
          //DateTime firstDayOfWeek = currentDayTime.subtract(Duration(days: currentDayTime.weekday - 1));
          if (DateTimeToInt(firstDay) >= activity['NGAYBATDAU']) {
            for (int i = 0; i < activityDayString.length; i++) {
              if (activityDayString[i] == '1') activityDayCount++;
            }
          }
          else {
            DateTime startDay = IntToDateTime(activity['NGAYBATDAU']);
            int startWeekday = startDay.weekday - 1;
            for (int i = startWeekday; i < activityDayString.length; i++) {
              if (activityDayString[i] == '1') activityDayCount++;
            }
          }
        }
        else if (activity['LOAIHINH'] == 'FLEXIBLE') {
          // DateTime firstDayOfWeek = currentDayTime.subtract(Duration(days: currentDayTime.weekday - 1));
          if (DateTimeToInt(firstDay) >= activity['NGAYBATDAU']) activityDayCount = activity['SOLAN'];
          else {
            DateTime startDay = IntToDateTime(activity['NGAYBATDAU']);
            activityDayCount = (((7 - startDay.weekday + 1).toDouble() / 7.0) * activity['SOLAN']).floor();
          }

        }
        else if (activity['LOAIHINH'] == 'REPEATING') {
          // DateTime dateTime = currentDayTime.add(Duration(days: 7 - currentDayTime.weekday));
          // dateTime = new DateTime(dateTime.year, dateTime.month, dateTime.day);
          int dayDifference = lastDay.difference(IntToDateTime(activity['NGAYBATDAU'])).inDays;
          dayDifference = dayDifference % activity['KHOANGTHOIGIAN'];
          if (dayDifference < 7) {
            DateTime weekLastCompletedDay = lastDay.subtract(Duration(days: dayDifference));
            activityDayCount++;
            int weekDay = weekLastCompletedDay.weekday;
            while (weekDay > 1 && weekDay > activity['KHOANGTHOIGIAN']) {
              weekDay -= activity['KHOANGTHOIGIAN'];
              activityDayCount++;
            }
          }
        }
        for (int i = 0; i < completedDayList.length; i++) {
          if (completedDayList[i] == true) activityCompletedCount++;
        }
      }
    }
    else if (_calendarFormat == CalendarFormat.month) {
      // if (DateTimeToInt(currentDayTime) < DateTimeToInt(IntToDateTime(activity['NGAYBATDAU']).subtract(Duration(days: IntToDateTime(activity['NGAYBATDAU']).day - 1)))
      //     || DateTimeToInt(currentDayTime) > DateTimeToInt(DateTime.now().add(Duration(days: NumberOfDaysInMonth(DateTime.now().month, DateTime.now().year) - DateTime.now().day)))) {
      //   activityDayCount = 0;
      //   activityCompletedCount = 0;
      // }
      if (DateTimeToInt(currentDayTime) < DateTimeToInt(IntToDateTime(activity['NGAYBATDAU']).subtract(Duration(days: IntToDateTime(activity['NGAYBATDAU']).day - 1)))) {
        activityDayCount = 0;
        activityCompletedCount = 0;
      }
      else {
        if (activity['LOAIHINH'] == 'FIXED') {
          String activityDayString = activity['CACNGAY'].toString();
          // int timesPerWeek = 0;
          // for (int i = 0; i < activityDayString.length; i++) {
          //   if (activityDayString[i] == '1') timesPerWeek++;
          // }
          // DateTime firstDayOfMonth = currentDayTime.subtract(Duration(days: currentDayTime.day - 1));
          // DateTime lastDayOfMonth = firstDayOfMonth.add(Duration(days: NumberOfDaysInMonth(firstDayOfMonth.month, firstDayOfMonth.year) - 1));
          DateTime firstDayOfWeek = firstDay;
          DateTime lastDayOfWeek = firstDayOfWeek.add(Duration(days: 7 - firstDayOfWeek.weekday));

          while((DateTimeToInt(lastDayOfWeek) < activity['NGAYBATDAU']) && (DateTimeToInt(lastDayOfWeek) < DateTimeToInt(lastDay))) {
            lastDayOfWeek = lastDayOfWeek.add(Duration(days: 7));
            if (DateTimeToInt(lastDayOfWeek) > DateTimeToInt(lastDay)) lastDayOfWeek = lastDay;
            firstDayOfWeek = lastDayOfWeek.subtract(Duration(days: lastDayOfWeek.weekday - 1));
          }
          while(DateTimeToInt(lastDayOfWeek) <= DateTimeToInt(lastDay)) {
            for (int i = firstDayOfWeek.weekday - 1; i < lastDayOfWeek.weekday; i++) {
              if (activityDayString[i] == '1') activityDayCount++;
            }
            lastDayOfWeek = lastDayOfWeek.add(Duration(days: 7));
            firstDayOfWeek = lastDayOfWeek.subtract(Duration(days: lastDayOfWeek.weekday - 1));
          }
          if (DateTimeToInt(firstDayOfWeek) <= DateTimeToInt(lastDay)) {
            if (DateTimeToInt(lastDayOfWeek) > DateTimeToInt(lastDay)) lastDayOfWeek = lastDay;
            for (int i = firstDayOfWeek.weekday - 1; i < lastDayOfWeek.weekday; i++) {
              if (activityDayString[i] == '1') activityDayCount++;
            }
          }
        }
        else if (activity['LOAIHINH'] == 'FLEXIBLE') {
          // DateTime firstDayOfMonth = currentDayTime.subtract(Duration(days: currentDayTime.day - 1));
          if (DateTimeToInt(firstDay) >= activity['NGAYBATDAU']) activityDayCount = ((NumberOfDaysInMonth(firstDay.month, firstDay.year).toDouble() / 7.0) * activity['SOLAN']).floor();
          else {
            DateTime startDay = IntToDateTime(activity['NGAYBATDAU']);
            activityDayCount = (((NumberOfDaysInMonth(firstDay.month, firstDay.year) - startDay.day + 1).toDouble() / 7.0) * activity['SOLAN']).floor();
          }
        }
        else if (activity['LOAIHINH'] == 'REPEATING') {
          // DateTime firstDayOfMonth = currentDayTime.subtract(Duration(days: currentDayTime.day - 1));
          // firstDayOfMonth = new DateTime(firstDayOfMonth.year, firstDayOfMonth.month, firstDayOfMonth.day);

          if (DateTimeToInt(firstDay) >= activity['NGAYBATDAU']) {
            int dayDifference = firstDay.difference(IntToDateTime(activity['NGAYBATDAU'])).inDays;
            dayDifference = dayDifference % activity['KHOANGTHOIGIAN'];
            DateTime firstActivityDay;
            if (dayDifference > 0) firstActivityDay = firstDay.add(Duration(days: activity['KHOANGTHOIGIAN'] - dayDifference));
            else firstActivityDay = firstDay;
            activityDayCount = ((NumberOfDaysInMonth(firstDay.month, firstDay.year) - firstActivityDay.day).toDouble() / activity['KHOANGTHOIGIAN']).floor() + 1;
          }
          else {
            DateTime firstActivityDay;
            firstActivityDay = IntToDateTime(activity['NGAYBATDAU']);
            activityDayCount = ((NumberOfDaysInMonth(firstDay.month, firstDay.year) - firstActivityDay.day).toDouble() / activity['KHOANGTHOIGIAN']).floor() + 1;
          }
        }
        for (int i = 0; i < completedDayList.length; i++) {
          if (completedDayList[i] == true) activityCompletedCount++;
        }
      }
    }
    if ((activity['LOAIHINH'] == 'FLEXIBLE') && activityCompletedCount > activityDayCount ) {
      activityCompletedCount = activityDayCount;
    }
    listInt.add(activityCompletedCount);
    listInt.add(activityDayCount - activityCompletedCount);
    return listInt;
  }

  Widget ActivityMonthlyPercentage(Map<String, dynamic> activity, List<bool> completedDayList, List<bool> previousCompletedDayList, DateTime firstDay, DateTime lastDay, DateTime previousFirstDay, DateTime previousLastDay) {

    int monthPercentage = CalculateActivityMonthPercentage(activity, completedDayList, firstDay, lastDay);
    int previousMonthPercentage;
    if ((DateTimeToInt(currentDayTime) > DateTimeToInt(DateTime.now().add(Duration(days: NumberOfDaysInMonth(DateTime.now().month, DateTime.now().year) - DateTime.now().day))))
        || (DateTimeToInt(currentDayTime) <= DateTimeToInt(IntToDateTime(activity['NGAYBATDAU']).add(Duration(days: NumberOfDaysInMonth(IntToDateTime(activity['NGAYBATDAU']).month, IntToDateTime(activity['NGAYBATDAU']).year) - IntToDateTime(activity['NGAYBATDAU']).day))))) {
      previousMonthPercentage = -1;
    }
    else previousMonthPercentage = CalculateActivityMonthPercentage(activity, previousCompletedDayList, previousFirstDay, previousLastDay);
    print('monthPercentage: $monthPercentage');
    print('previousMonthPercentage: $previousMonthPercentage');

    Row row = new Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '$monthPercentage%',
        ),
      ],
    );

    if (previousMonthPercentage != -1) {
      Icon icon = new Icon(
        (monthPercentage >= previousMonthPercentage)?Icons.arrow_drop_up:Icons.arrow_drop_down,
        color: (monthPercentage >= previousMonthPercentage)?Colors.green:Colors.red,
        size: 24.0,
      );
      SizedBox sizedBox = new SizedBox(
        width: 35,
        child: Text(
          '$previousMonthPercentage%',
          style: TextStyle(
            color: (monthPercentage >= previousMonthPercentage)?Colors.green:Colors.red,
          ),
        ),
      );
      row.children.add(icon);
      row.children.add(sizedBox);
    }
    else {
      SizedBox emptySizedBox = new SizedBox(width: 20,);
      row.children.add(emptySizedBox);
    }
    return row;
  }

  int CalculateActivityMonthPercentage(Map<String, dynamic> activity, List<bool> completedDayList, DateTime firstDay, DateTime lastDay) {
    int percentage;
    // if ((_calendarFormat == CalendarFormat.month) && (DateTimeToInt(currentDayTime) > DateTimeToInt(DateTime.now().add(Duration(days: NumberOfDaysInMonth(DateTime.now().month, DateTime.now().year) - DateTime.now().day))))) {
    //   return 0;
    // }
    List<int> activityCompletedMissedCount = GetActivityCompletedMissedCount(activity, completedDayList, firstDay, lastDay);
    int activityCompletedCount = activityCompletedMissedCount[0];
    int activityMissedCount = activityCompletedMissedCount[1];
    if (activityCompletedCount + activityMissedCount != 0) percentage = ((activityCompletedCount.toDouble() / (activityCompletedCount + activityMissedCount).toDouble()) * 100).round();
    else percentage = 100;
    return percentage;
  }

  int DateTimeToInt(DateTime dateTime) {
    return dateTime.year * 10000 + dateTime.month * 100 + dateTime.day;
  }

  DateTime IntToDateTime(int dateTimeInt) {
    int year = (dateTimeInt / 10000).floor();
    int month = (dateTimeInt / 100).floor() % 100;
    int day = dateTimeInt % 100;
    return DateTime(year, month, day);
  }

}
