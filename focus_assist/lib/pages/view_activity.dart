import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pie_chart/pie_chart.dart';

class ViewAllActivity extends StatelessWidget {
  String name;
  ViewAllActivity({this.name});

  // Các biến dùng trong cái lịch
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  Map<String, double> dataMap = {
    "Done": 5,
    "Skip": 3,
    "Miss": 20,
  };

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
                          leading: Icon(Icons.fireplace),
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
