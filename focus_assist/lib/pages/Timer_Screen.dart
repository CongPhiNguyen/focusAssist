import 'package:flutter/material.dart';
import 'package:flutter_volume_slider/flutter_volume_slider.dart';
import 'package:focus_assist/pages/dialogHelperToSetTime.dart';
import 'package:path/path.dart';
import 'package:simple_timer/simple_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:async';
import 'PlayPauseButton.dart';

//
const kPrimaryColor = Color(0xFF0C9869);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);
const double kDefaultPadding = 20.0;
//

class TimerScreen extends StatefulWidget {
  @override
  final String message ;
    TimerScreen({this.message});
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> with TickerProviderStateMixin{
  bool isVisible = true;
  bool isNotVisible = false;
  TimerController _timerController;
  bool timerRunning = false;
  void initState() {
    // TODO: implement initState
    tb = TabController(length: 1, vsync: this);
    super.initState();
    _timerController = TimerController(this);
  }
  @override
  Widget build(BuildContext context) {
    String message = widget.message != null ? widget.message : '0:0:0';
    var time = message.split(':');
    hour = int.parse(time[0]);
    min =int.parse(time[1]);
    sec = int.parse(time[2]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acitivity name'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.library_music_rounded),
            tooltip: 'Show Snackbar',
            onPressed: () {
              dialogHelper.musicList(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.alarm),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Timer history'),
                    ),
                    body:  Center(
                      child: Container(
                        constraints: BoxConstraints.expand(height: 50.0, width: 250),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                        ),
                        child: FlutterVolumeSlider(
                          display: Display.HORIZONTAL,
                          sliderActiveColor: Colors.blue,
                          sliderInActiveColor: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ));
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff1542bf),Color(0xff51a8ff)],
                begin: FractionalOffset(0.5,1)
            )
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: RaisedButton(
                onPressed: () {
                  // set time here
                  dialogHelper.exit(context);
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors:  <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.body1,
                      children: [
                        TextSpan(text: 'Set time ', style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 1.3,
                        )),
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Icon(Icons.alarm),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height* 0.3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: SimpleTimer(
                  duration: Duration(hours: hour, minutes: min),
                  backgroundColor: Colors.white,
                  controller: _timerController,
                  progressTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                  ),
                  strokeWidth: 10,
                ),
                
              ),
            ),
            SizedBox(height: 10,),
            Stack(
              children: <Widget>[
                Container(
                    height: 80,  // height of white range
                    margin: EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, -12),
                          blurRadius: 12,
                        ),
                      ],
                      borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(
                              MediaQuery.of(context).size.width * 2, 50)),
                    )),
                Center(
                  child: Container(
                    child: SizedBox(
                      height: 90,
                      width: 90,
                      child: PlayButton(
                        pauseIcon: Icon(Icons.pause, color: Colors.white, size: 60, ),
                        playIcon: Icon(Icons.play_arrow, color: Colors.white, size: 60),
                        onPressed: () {
                          if(timerRunning == false){
                              _timerController.start();
                              timerRunning = true;
                           }
                           else {
                             _timerController.reset();
                             timerRunning = false;
                           }
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 10, top: 65),
                            child: Text(
                              "Focus level:",
                              style: TextStyle(
                                fontSize: 14,
                              ),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            "   A B C D    ",  // lưu ý khi chỉnh sửa
                            style: TextStyle(
                              fontSize: 20,
                            ),),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 230, top: 65),
                          child: Text(
                            "Recent Focus",
                            style: TextStyle(
                              fontSize: 14,
                            ),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 230, top: 5),
                          child: Text(
                            "00:00:00",
                            style: TextStyle(
                              fontSize: 25,
                            ),),
                        ),

                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // for timer set up

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
  // hàm reset
  void restart(){
    setState(() {
      started = true;
      stoped = true;
      timetoDisplay = "00:00:00";
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

  
}



