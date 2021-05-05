import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  CalendarController controller = CalendarController();
  @override
  Widget build(BuildContext context) {
    //controller = CalendarController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
          child: ListView(
            children: <Widget>[
              TableCalendar(
                initialCalendarFormat: CalendarFormat.month,
                initialSelectedDay: DateTime.now(),
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarController: controller,
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
                        '1',
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
                        '30',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        'Minutes Spent',
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
                        children: [
                          Text(
                            '10%',
                            style: TextStyle(
                              fontSize: 18.0,
                              //color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            'Progress',
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
            ],
          ),
        ),
      ),
    );
  }
}
