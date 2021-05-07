import 'package:flutter/material.dart';
import 'package:focus_assist/pages/view_activity.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:focus_assist/pages/add_screen.dart';

class ToDo {
  bool check;
  String task;
  ToDo({this.check, this.task});
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
  List<String> allActivity;

  Map<String, double> dataMap;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _calendarFormat = CalendarFormat.week;
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    items1 = ["Chơi cờ vua", "Luyện tập code", "Cày game"];
    toDos = [
      ToDo(check: false, task: "Chơi cờ vua 30p"),
      ToDo(check: false, task: "Cày game 15p"),
      ToDo(check: false, task: "Luyện tập code 1h")
    ];
    items = [];
    dataMap = {"Skip": 500, "Done": 322, "Fail": 112};
    allActivity = ["Luyện cờ vua", "Luyện code", "Luyện cờ caro", "Luyện vẽ"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: ListView(children: <Widget>[
        SizedBox(
          height: 30,
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
                child: SizedBox(
                  width: 30,
                )),
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
        //Hiển thị các hoạt động trong ngày
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
              //padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.greenAccent, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xff865693),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  child: Row(children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 8, 4),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.calendar_today,
                                size: 22, color: Colors.white)),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 8, 4),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "${_selectedDay.day} / ${_selectedDay.month} / ${_selectedDay.year}",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white)),
                        ),
                      ),
                    )
                  ]),
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: items.length != 0
                      ? items.map((task) {
                          return Column(children: <Widget>[
                            ListTile(
                              //tileColor: Colors.greenAccent,
                              leading: CircleAvatar(
                                backgroundColor: Colors.cyan,
                              ),
                              title: Text(task),
                              trailing: Icon(Icons.more_vert),
                              subtitle: Text("Nguyễn Công Phi"),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black, width: 7),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            Divider(
                              height: 3.0,
                            )
                          ]);
                        }).toList()
                      : <Widget>[
                          Center(
                              child: Text("Nothing to show here",
                                  style: TextStyle(fontSize: 20))),
                          SizedBox(
                            height: 12,
                          )
                        ],
                ),
              ])),
        ),
        //Hiển thị tất cả các hoạt động(hoàn thành và chưa hoàn thành)
        SizedBox(
          height: 12,
        ),
        Padding(
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
                                "All activity",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewAllActivity()),
                            );
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
        ),
        SizedBox(
          height: 12,
        ),
        //Hiển thị các cái to do list
        Padding(
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
                              child: Icon(
                                Icons.playlist_add_check,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                "To do",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
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
                          onChanged: (bool value) {
                            setState(() {
                              toDos[index].check = value;
                            });
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
        ),
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddNew()),
            );
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
