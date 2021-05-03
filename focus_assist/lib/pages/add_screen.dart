import 'package:flutter/material.dart';

class AddNew extends StatefulWidget {
  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  String dropDownValue;
  DateTime startTime;
  List<String> dayOfWeek;
  List<bool> checkDay;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropDownValue = 'Fixed';
    startTime = DateTime.now();
    dayOfWeek = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
    checkDay = [false, false, false, false, false, false, false];
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
      Container(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dayOfWeek.length,
            itemBuilder: (context, index) {
              return RaisedButton(
                onPressed: () {
                  setState(() {
                    checkDay[index] = !checkDay[index];
                  });
                },
                color: checkDay[index] ? Colors.cyan : Colors.white12,
                child: Text(dayOfWeek[index]),
              );
            },
          )),
    ];
  }

  List<Widget> Repeating() {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
        child: Text("Repeating every: ", style: TextStyle(fontSize: 20)),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
        child: Row(
          children: [
            Expanded(
                flex: 1, child: Text("Every", style: TextStyle(fontSize: 20))),
            Expanded(
                flex: 1,
                child: TextField(
                  decoration: InputDecoration(hintText: 'num'),
                  style: TextStyle(fontSize: 20),
                )),
            Expanded(
                flex: 1, child: Text("day", style: TextStyle(fontSize: 20))),
          ],
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(20.0),
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        // Tiêu đề
        Center(
            child: Container(
          color: Colors.green,
          // decoration: BoxDecoration(
          //     border: Border.all(color: Colors.black)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Add new Activity',
              style: TextStyle(fontSize: 40, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        )),
        SizedBox(
          height: 10,
        ),
        // Thêm tên của activity
        Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter name of new activity'),
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // Description
        Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Add description'),
            style: TextStyle(fontSize: 15),
          ),
        ),
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
                    startTime = date;
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
              style: const TextStyle(color: Colors.deepPurple, fontSize: 20),
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
        Center(
          child: RaisedButton(
            onPressed: () {},
            child: Text("Add"),
          ),
        )
      ],
    ));
  }
}
