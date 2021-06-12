import 'package:flutter/material.dart';
import 'package:focus_assist/pages/timerScreen/Timer_Screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:numberpicker/numberpicker.dart';
import 'musicDialog.dart';

class SetTime extends StatefulWidget {
  @override
  _SetTimeState createState() => _SetTimeState();
}

class _SetTimeState extends State<SetTime> with TickerProviderStateMixin {
  List<int> value;

  TabController tb;
  int hour = 0;
  int min = 0;
  int sec = 0;
  String hour1 = "0", min1 = "0", sec1 = "0";
  bool started = true;
  bool stoped = true;
  int timeForTimer = 0;
  String timetoDisplay = "";
  bool checkTimer = true;

  @override
  void initState() {
    // TODO: implement initState
    tb = TabController(length: 1, vsync: this);
    super.initState();
  }
  void start(){
    setState(() {
      started = false;
      stoped = false;
    });
    timeForTimer = (hour*60 *60) + min*60 + sec;
    //debugPrint(timeForTimer.toString());
    Timer.periodic(
        Duration(seconds: 1), (Timer t){
      setState(() {
        if(timeForTimer < 1 || checkTimer == false) {
          t.cancel();
          if(timeForTimer  == 0) {
            // dùng để xử lý sau này khi kết thúc cần sự kiện
            debugPrint("Stopped by default");
          }
          checkTimer = true;
          timetoDisplay = "";
          started = true;
          stoped = true;
        }
        // xử lý chuyển đổi timer
        else if (timeForTimer < 60){
          timetoDisplay = "0:0:" + timeForTimer.toString();
          timeForTimer = timeForTimer - 1;
        }
        else if (timeForTimer < 3600){
          int m = timeForTimer ~/ 60;
          int s = timeForTimer - (60*m);
          timetoDisplay = "0:" + m.toString() + ":" + s.toString();
          timeForTimer = timeForTimer -1;
        }
        else {
          int h = timeForTimer ~/ 3600;
          int t = timeForTimer - (3600*h);
          int m = t ~/ 60;
          int s = t - (60*m);
          timetoDisplay = h.toString() + ":" + m.toString() + ":" + s.toString();
          timeForTimer = timeForTimer -1;
        }
      });
    });
  }
  void stop(){
    setState(() {
      started = true;
      stoped = true;
      checkTimer = false;
    });
  }
  String convertTimer(timerForTimer){
    String timeToDisplay;
    if (timeForTimer < 60){
      timeToDisplay = "0:0:" + timeForTimer.toString();
      timeForTimer = timeForTimer - 1;
    }
    else if (timeForTimer < 3600){
      int m = timeForTimer ~/ 60;
      int s = timeForTimer - (60*m);
      timeToDisplay = "0:" + m.toString() + ":" + s.toString();
      timeForTimer = timeForTimer -1;
    }
    else {
      int h = timeForTimer ~/ 3600;
      int t = timeForTimer - (3600*h);
      int m = t ~/ 60;
      int s = t - (60*m);
      timeToDisplay = h.toString() + ":" + m.toString() + ":" + s.toString();
      timeForTimer = timeForTimer -1;
    }
    return timeToDisplay;
  }
  void goToTimerScreen(String message1){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return TimerScreen(message: message1 ); 
        }
        )
        );
  }
  Widget timer(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(
                      bottom: 10.0,
                    ),
                      child: Text(
                        "HH",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                        initialValue: hour,           
                        minValue: 0,
                        maxValue: 23,
                        listViewWidth: 60,
                        onChanged: (val) {
                          setState(() {
                            hour = val;
                            hour1 = val.toString();
                          });
                        })
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(
                      bottom: 10.0,
                    ),
                      child: Text(
                        "MM",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                        initialValue: min,
                        minValue: 0,
                        maxValue: 59,
                        listViewWidth: 60.0,
                        onChanged: (val) {
                          setState(() {
                            min = val;
                            min1 = val.toString();
                          });
                        })
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(
                      bottom: 10.0,
                    ),
                      child: Text(
                        "SS",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                        initialValue: sec,
                        minValue: 0,
                        maxValue: 59,
                        listViewWidth: 60.0,
                        onChanged: (val) {
                          setState(() {
                            sec = val;
                            sec1 = val.toString();
                          });
                        })
                  ],
                ),

              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              timetoDisplay,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: (){
                    //timetoDisplay = hour1 + ":" + min1 + ":" + sec1;
                    //Navigator.of(context).pop(false);
                    //started? start() : null;
                    
                    // chỉ cần chuyển 3 thông số hour, min, sec qua là được
                    //goToTimerScreen(hour.toString()+":"+ min.toString()+":"+ sec.toString());
                    Navigator.pop(context, hour.toString()+":"+ min.toString()+":"+ sec.toString());
                    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TimerScreen(value : value = [hour, min, sec] ) ));
                  },
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  color: Colors.blue,
                  child: Text(
                    "Set",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                /*
                RaisedButton(
                  onPressed: (){
                    started? start() : null;
                  },
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 10.0,
                  ),
                  color: Colors.green,
                  child: Text(
                    "Start",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                RaisedButton(
                  onPressed: (){
                    stoped ? null : stop();
                  },
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 10.0,
                  ),
                  color: Colors.red,
                  child: Text(
                    "Stop",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                */
              ],
            ),
          )],
      ),
    );

    
  }
  @override

  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(30),
      margin: EdgeInsets.only(  left: 60, top: 150, right: 60, bottom: 160),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Center(
        child: timer(),
      ),
    );
  }
}