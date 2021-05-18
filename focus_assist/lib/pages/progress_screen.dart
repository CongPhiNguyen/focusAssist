import 'package:flutter/material.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:table_calendar/table_calendar.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  CalendarController controller = CalendarController();
  int dropdownValue;
  List<Widget> activitiesWidgetList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = 1;
    //LoadActivityList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
          child: ListView(
            children: <Widget>[
              TableCalendar(
                initialCalendarFormat: CalendarFormat.week,
                initialSelectedDay: DateTime.now(),
                startingDayOfWeek: StartingDayOfWeek.monday,
                availableCalendarFormats: {CalendarFormat.week: 'Week', CalendarFormat.month: 'Month'},
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
              SizedBox(height: 15.0,),
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
              // Wrap(
              //   children: [
              //     GridView.count(
              //       shrinkWrap: true,
              //       crossAxisCount: 7,
              //       crossAxisSpacing: 10.0,
              //       children: <Widget>[
              //         Wrap(
              //           children: <Widget>[
              //             SizedBox(
              //               height: 15.0,
              //               width: 15.0,
              //               child: Container(
              //                 color: Colors.blue,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ],
              // ),

              CustomScrollView(
                shrinkWrap: true,
                primary: false,
                slivers: <Widget>[
                  SliverGrid.count(
                    crossAxisCount: 7,
                    crossAxisSpacing: 0.0,
                    children: <Widget>[
                      Wrap(
                        children: [
                          SizedBox(
                            height: 15.0,
                            width: 15.0,
                            child: Container(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          SizedBox(
                            height: 15.0,
                            width: 15.0,
                            child: Container(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),
                ],
              ),

              Column(
                children: <Widget>[
                  ListTile(
                    tileColor: Colors.amber,
                    title: Text('Đọc sách'),
                    // trailing: Container(
                    //   child: GridView.count(
                    //     crossAxisCount: 7,
                    //     children: <Widget>[
                    //       Container(
                    //         height: 1.0,
                    //         width: 1.0,
                    //         color: Colors.blue,
                    //       ),
                    //       Container(
                    //         height: 1.0,
                    //         width: 1.0,
                    //         color: Colors.blue,
                    //       ),
                    //       Container(
                    //         height: 5.0,
                    //         width: 5.0,
                    //         color: Colors.grey[200],
                    //       ),
                    //       Container(
                    //         height: 5.0,
                    //         width: 5.0,
                    //         color: Colors.blue,
                    //       ),
                    //       Container(
                    //         height: 5.0,
                    //         width: 5.0,
                    //         color: Colors.grey[200],
                    //       ),
                    //       Container(
                    //         height: 5.0,
                    //         width: 5.0,
                    //         color: Colors.grey[200],
                    //       ),
                    //       Container(
                    //         height: 5.0,
                    //         width: 5.0,
                    //         color: Colors.grey[200],
                    //       ),
                    //     ],
                    //   ),
                    // ),

                  ),
                ],
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
    List<Widget> widgetList;
    Database db = await DbProvider.instance.database;
    List<dynamic> whereArgsList = ['ND001'];
    List<Map<String, dynamic>> activitiesList = await db.query('MUCTIEU', where: 'MANGUOIDUNG = ?', whereArgs: whereArgsList);
    activitiesList.forEach((element) {
      ListTile listTile = ListTile(
        title: element['TENMUCTIEU'],
        trailing: _getActivityDetail(element),
      );
      widgetList.add(listTile);
    });
    setState(() {
      activitiesWidgetList = widgetList;
    });
  }

  Widget _getActivityDetail(Map<String, dynamic> activity) {
    if (dropdownValue == 1) {
      return Row(
        children: <Widget>[
          Text(
            '70%',
          ),
          Icon(
            Icons.arrow_drop_up,
            size: 24.0,
          ),
          Text(
            '20%',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ],
      );
    }
    else if (dropdownValue == 2) {
      return GridView.count(
        crossAxisCount: 7,
        children: <Widget>[
          Container(
            height: 2.0,
            width: 2.0,
            color: Colors.blue,
          ),
          Container(
            height: 2.0,
            width: 2.0,
            color: Colors.blue,
          ),
          Container(
            height: 2.0,
            width: 2.0,
            color: Colors.grey[200],
          ),
          Container(
            height: 2.0,
            width: 2.0,
            color: Colors.blue,
          ),
          Container(
            height: 2.0,
            width: 2.0,
            color: Colors.grey[200],
          ),
          Container(
            height: 2.0,
            width: 2.0,
            color: Colors.grey[200],
          ),
          Container(
            height: 2.0,
            width: 2.0,
            color: Colors.grey[200],
          ),
        ],
      );
    };
  }
}
