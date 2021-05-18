import 'package:flutter/material.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'dart:math';

class AddNew extends StatefulWidget {
  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  final dbHelper = DbProvider.instance;
  String dropDownValue;
  DateTime startTime;
  List<String> dayOfWeek;
  List<bool> checkDay;

  // Những biến để get Text
  TextEditingController getActivity, getDescription;
  //Biến để getText của Flexible
  int dayPerWeek;
  TextEditingController getDayPerWeek;
  //Biến để gettext Repeating
  int repeatingDay;
  TextEditingController getRepeatingDay;

  //Dùng để debug
  String text = "FUCK";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropDownValue = 'Fixed';
    startTime = DateTime.now();
    dayOfWeek = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
    checkDay = [true, true, true, true, true, true, true];
    getActivity = TextEditingController();
    getDescription = TextEditingController();
    getDayPerWeek = TextEditingController();
    getRepeatingDay = TextEditingController();
  }

  String getRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  List<Widget> Flexible() {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
        child: Text(
          "How often do you want to perform the activity: ",
          style: TextStyle(fontSize: 18),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: TextField(
                controller: getDayPerWeek,
                decoration: InputDecoration(hintText: 'days'),
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
                flex: 1,
                child: SizedBox(
                  width: 10,
                )),
            Expanded(
                flex: 9,
                child: Text("per week", style: TextStyle(fontSize: 20)))
          ],
        ),
      ),
    ];
  }

  List<Widget> Fixed() {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
        child: Text("Select the day you want to do the activity:",
            style: TextStyle(fontSize: 17)),
      ),
      SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dayOfWeek.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      checkDay[index] = !checkDay[index];
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: checkDay[index]
                            ? Color(0xff8A2BE2)
                            : Color(0xffF0FFF0),
                        border: Border(
                            bottom: BorderSide(
                                color: !checkDay[index]
                                    ? Color(0xff8A2BE2)
                                    : Color(0xffF0FFF0),
                                width: 1),
                            top: BorderSide(
                                color: !checkDay[index]
                                    ? Color(0xff8A2BE2)
                                    : Color(0xffF0FFF0),
                                width: 1),
                            right: BorderSide(
                                color: !checkDay[index]
                                    ? Color(0xff8A2BE2)
                                    : Color(0xffF0FFF0),
                                width: 1),
                            left: BorderSide(
                                color: !checkDay[index]
                                    ? Color(0xff8A2BE2)
                                    : Color(0xffF0FFF0),
                                width: (index == 0) ? 1 : 0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(dayOfWeek[index],
                            style: TextStyle(
                                color: !checkDay[index]
                                    ? Color(0xff8A2BE2)
                                    : Color(0xffF0FFF0))),
                      )),
                );
              },
            )),
      ),
    ];
  }

  List<Widget> Repeating() {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
        child: Text("Repeating every: ", style: TextStyle(fontSize: 20)),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text("Every", style: TextStyle(fontSize: 20))),
              Expanded(
                  flex: 1,
                  child: TextField(
                    controller: getRepeatingDay,
                    decoration: InputDecoration(hintText: 'num'),
                    style: TextStyle(fontSize: 20),
                  )),
              Expanded(
                  flex: 4, child: Text("day", style: TextStyle(fontSize: 20))),
            ],
          ),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff8A2BE2),
          title: Text("Add new activity", style: TextStyle(fontSize: 25)),
          actions: [
            FlatButton(
                onPressed: () async {
                  Map<String, dynamic> row = {
                    'MAMUCTIEU': getRandomString(5),
                    'MANGUOIDUNG': (StaticData.userID == null)
                        ? 'MANGUOIDUNG'
                        : StaticData.userID,
                    'MANHOM': '1',
                    'TENMUCTIEU': (getActivity.text == null)
                        ? 'TENMUCTIEU'
                        : getActivity.text,
                    'MOTA': (getDescription.text == null)
                        ? 'MOTA'
                        : getDescription.text,
                    'NGAYBATDAU': startTime
                        .toString()
                        .substring(0, 10)
                        .replaceAll('-', '/'),
                    'LOAIHINH': dropDownValue,
                  };
                  if (dropDownValue == 'Fixed') {
                    String fixedDay = "";
                    for (int i = 0; i < dayOfWeek.length; i++) {
                      if (checkDay[i] == false) {
                        fixedDay += '0';
                      } else
                        fixedDay += '1';
                    }
                    row['CACNGAY'] = int.parse(fixedDay);
                  } else if (dropDownValue == 'Flexible') {
                    if (getDayPerWeek.text != null)
                      row['SOLAN'] = int.parse(getDayPerWeek.text);
                  } else if (dropDownValue == 'Repeating') {
                    if (getRepeatingDay.text != null)
                      row['KHOANGTHOIGIAN'] = getRepeatingDay.text;
                  }
                  setState(() {
                    text = row.toString();
                  });
                  final id = await dbHelper.insert('MUCTIEU', row);
                  print('inserted row id: $id');
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    "Create",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ))
          ],
          elevation: 1,
        ),
        body: ListView(
          shrinkWrap: true,
          //padding: EdgeInsets.all(20.0),
          children: <Widget>[
            // Thêm tên của activity và các description
            Container(
                decoration: BoxDecoration(
                    color: Color(0xff8A2BE2),
                    borderRadius: BorderRadius.all(Radius.circular(0))),
                // height: double.infinity,
                //width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: getActivity,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Activity Name',
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white),
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white)),
                        ),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Description
                      TextField(
                        controller: getDescription,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(28),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.white)),
                            border: OutlineInputBorder(),
                            labelText: 'Description',
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        maxLines: 3,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
              child: Row(children: [
                Text(
                  "Start date: ",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  startTime.toString().substring(0, 10),
                  style: TextStyle(fontSize: 20),
                ),
                FlatButton.icon(
                  icon: Icon(Icons.date_range),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: startTime,
                            firstDate: DateTime.utc(2020, 1, 1),
                            lastDate: DateTime.utc(2120, 31, 12))
                        .then((date) {
                      setState(() {
                        if (date != null) startTime = date;
                      });
                    });
                  },
                  label: Text(""),
                )
              ]),
            ),
            Divider(
              height: 10,
              color: Colors.black54,
            ),
            // Bảng chọn loại của cái activity
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Select type",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 30,
                ),
                DropdownButton<String>(
                  value: dropDownValue,
                  icon: const Icon(Icons.arrow_drop_down_outlined),
                  iconSize: 24,
                  elevation: 16,
                  style:
                      const TextStyle(color: Colors.deepPurple, fontSize: 20),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropDownValue = newValue;
                    });
                  },
                  items: <String>['Fixed', 'Flexible', 'Repeating']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ],
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (dropDownValue == 'Fixed')
                    ? Fixed()
                    : (dropDownValue == 'Flexible')
                        ? Flexible()
                        : Repeating()),
            Text(StaticData.userID == null ? "NGUOIDUNG" : StaticData.userID),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(text, style: TextStyle(fontSize: 30)),
            ),
            TextButton(
                onPressed: () {
                  dbHelper.delete('MUCTIEU', 'MANHOM', '1');
                },
                child: Text("DELETE", style: TextStyle(fontSize: 30)))
          ],
        ));
  }
}
