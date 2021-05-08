import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ViewAllActivity extends StatelessWidget {
  String name;
  ViewAllActivity({this.name});

  // Các biến dùng trong cái lịch
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

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
          ])),
    );
  }
}
