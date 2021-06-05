import 'package:flutter/material.dart';
import 'package:focus_assist/pages/edit_activity_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:focus_assist/classes/DbProvider.dart';

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
    "Skip": 3,
    "Miss": 20,
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    database = [];
    name = widget.activityName;
    keyname = widget.activityKey;
  }

  void getData() async {
    String key = widget.activityKey;
    // Cập nhật lại sau khi chỉnh sửa
    database = await dbHelper
        .rawQuery('''select * from MUCTIEU where MAMUCTIEU='$key' ''');
    if (database.length > 0) {
      setState(() {
        name = database[0]['TENMUCTIEU'];
      });
    }
  }

  void deleteActivity() {
    String key = widget.activityKey;
    dbHelper.rawQuery('''delete from MUCTIEU where MAMUCTIEU='$key' ''');
    dbHelper.rawQuery('''delete from THONGKE where MAMUCTIEU='$key' ''');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  label: Text(""))
            ],
            title: Text(name),
            centerTitle: true,
            backgroundColor: Color(0xffe66771),
          ),
          body: ListView(children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditActivity(
                              activityKey: widget.activityKey,
                              activityName: widget.activityName)),
                    );
                    getData();
                  },
                  child: Text("Edit")),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                  onPressed: () async {
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
                  child: Text("Delete")),
            ),
            Container(
                height: 50,
                child: Row(children: [
                  Expanded(
                      flex: 1,
                      child: Center(
                          child: FlatButton(
                        color: Colors.cyan,
                        onPressed: () {},
                        child: Text(
                          "Thống kê",
                          style: TextStyle(fontSize: 27, color: Colors.white),
                        ),
                      ))
                      //FlatButton(onPress:(){},child: Text("Thống kê", style: TextStyle(fontSize: 30))),
                      ),
                  Expanded(
                      flex: 1,
                      child: Center(
                          child: FlatButton(
                        color: Colors.cyan,
                        onPressed: () {},
                        child: Text(
                          "Ghi chú",
                          style: TextStyle(fontSize: 27, color: Colors.white),
                        ),
                      )))
                ])),
            Container(
                height: 100,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      Container(
                        width: 300,
                        decoration: new BoxDecoration(color: Colors.red),
                        child: ListTile(
                          leading: Icon(
                            Icons.fireplace,
                            size: 60,
                          ),
                          title: Text("Streak"),
                          subtitle: Text('Consecutive days'),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 300,
                        decoration: new BoxDecoration(color: Colors.red),
                        child: ListTile(
                          leading: Icon(Icons.lightbulb),
                          title: Text("0 times"),
                          subtitle: Text('Average a day'),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 300,
                        decoration: new BoxDecoration(color: Colors.red),
                        child: ListTile(
                          leading: Icon(Icons.calendar_today),
                          title: Text("Ngày bắt đầu"),
                          subtitle: Text('01/01/2021'),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 300,
                        decoration: new BoxDecoration(color: Colors.red),
                        child: ListTile(
                          leading: Icon(Icons.calendar_today),
                          title: Text("0"),
                          subtitle: Text('Lần hoàn thành'),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 300,
                        decoration: new BoxDecoration(color: Colors.red),
                        child: ListTile(
                          leading: Icon(Icons.calendar_today),
                          title: Text("0"),
                          subtitle: Text('Lần bỏ qua'),
                        ),
                      ),
                    ])),
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            SizedBox(height: 30),
            PieChart(dataMap: dataMap)
          ])),
    );
  }
}
