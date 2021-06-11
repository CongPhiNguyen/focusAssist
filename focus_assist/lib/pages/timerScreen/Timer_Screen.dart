import 'package:flutter/material.dart';
import 'package:flutter_volume_slider/flutter_volume_slider.dart';
import 'package:focus_assist/classes/DbProvider.dart';
import 'package:focus_assist/pages/dialogHelperToSetTime.dart';
import 'package:focus_assist/pages/timerScreen/timerHistory.dart';
import 'package:path/path.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:simple_timer/simple_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'PlayPauseButton.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:focus_assist/classes/Data.dart';
import 'setTimer.dart' as st;
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
  static int showAlert(){
    print("this is alert");
  }
}

class _TimerScreenState extends State<TimerScreen> with TickerProviderStateMixin{
  bool isVisible = true;
  bool isNotVisible = false;
  TimerController _timerController;
  GifController gifcontroller;
  IconData _controlIcon;
  bool timerRunning = false;
  String duration = "00:00:00";
  final dbHelper = DbProvider.instance;
  void initState() {
    // TODO: implement initState
    tb = TabController(length: 1, vsync: this);
    super.initState();
    _timerController = TimerController(this);
    gifcontroller= GifController(vsync: this);
    _controlIcon = Icons.play_arrow;
    loadGold();
  }
  void loadGold() async {
    String userID = StaticData.userID;
    List<Map<String, dynamic>> database = await dbHelper.rawQuery(
        ''' select * from THONGTINNGUOIDUNG where MANGUOIDUNG='$userID' ''');
    if (database.length > 0) {
      setState(() {
        StaticData.Vang = database[0]['VANG'];
      });
    }
  }
  void updateGold() async {
    int golds = StaticData.Vang += 50;
        //Add vào database
        String userKey = StaticData.userID;
        dbHelper.rawQuery(
            ''' update THONGTINNGUOIDUNG set VANG=$golds where MANGUOIDUNG='$userKey' ''');
        loadGold();
    
  }
  void updateHistories(bool hoanThanh, String duration) async {
    DateTime now = DateTime.now();
    String dateTime = now.year.toString() + "-" + now.month.toString()+ "-"+ now.day.toString()+ " "+ now.hour.toString() 
        + ":" + now.minute.toString() + ":" + now.second.toString();
    String userKey = StaticData.userID;
        dbHelper.rawQuery(
            ''' INSERT INTO LICHSUTIMER (THOIGIAN, DAHOANTHANH, MANGUOIDUNG)
            VALUES ('$dateTime', '$hoanThanh', '$userKey' ) ''');
    print("da ADD vao history");
    print(duration==""?"null duration":duration);

  }
  void clearHistory(){
    String userKey = StaticData.userID;
     dbHelper.rawQuery(
            ''' DELETE FROM LICHSUTIMER WHERE MANGUOIDUNG='$userKey'; ''');
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Focus Timer'),
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
                      backgroundColor: Colors.amber,
                      title: const Text('Timer history'),
                      actions: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.delete),
                          tooltip: 'Clear History',
                          onPressed: () {
                             print("clear history");
                             clearHistory();
                             _showSuccess(context, "Timer history deleted!");
                          },
                        ),
                      ]
                    ),
                    body: timerHistory(),
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
                colors: [Color(0xffffba42),Color(0xffFFD358)],
                begin: FractionalOffset(0.5,1)
            )
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton (
                  icon: Icon(Icons.keyboard_arrow_down_sharp),
                  iconSize: 50,
                  color: Colors.white,
                  onPressed: () {
                    decrease();
                  }
                ),
                Text( '0$hour : $min : 00',
                style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                IconButton (
                  icon: Icon(Icons.keyboard_arrow_up_sharp ),
                   color: Colors.white,
                  iconSize: 50,
                  onPressed: () {
                    increase();
                    //_showSuccess(context, "Đăng ký thành công!");
                  }
                ),
              ],
            ),
            SizedBox(height: 10,),
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height* 0.3,
                width: MediaQuery.of(context).size.width*0.8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                /////////////////////////////////
                // child: SimpleTimer(
                //   duration: Duration(hours: hour, minutes: min),
                //   backgroundColor: Colors.white,
                //   controller: _timerController,
                //   progressTextStyle: TextStyle(
                //     color: Colors.white,
                //     fontSize: 50,
                //   ),
                //   strokeWidth: 10,
                // ),
                child: Container(
                  margin: EdgeInsets.only(top: 60,),
                  height: 350.0,
                  width: 350.0,
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     image: AssetImage(
                  //         'assets/images/focusTime_background.png'),
                  //     fit: BoxFit.fill,
                  //   ),
                  //   shape: BoxShape.circle,
                  // ),
                  child: GifImage(
                      controller: gifcontroller,
                      image: AssetImage("assets/images/clock.gif"),
                    ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Stack(
              children: <Widget>[
                Container(
                    height: 90,  // height of white range
                    margin: EdgeInsets.only(top: 60),
                    decoration: BoxDecoration(
                      color: Colors.yellow[100],
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
                        pauseIcon: Icon(_controlIcon, color: Colors.white, size: 60, ),   //Icons.pause
                        playIcon: Icon(_controlIcon, color: Colors.white, size: 60),     //Icons.play_arrow
                        onPressed: () {
                            
                            if(_timerIsRunning) {
                               //stoped ? null : stop();
                               showAlertDialog(context);
                            }
                            else {    
                              _controlIcon = Icons.pause;  
                                                 
                              //started? (start()): null;
                              if (started) {
                                start();
                                gifcontroller.repeat(min:0,max:4,period:Duration(milliseconds: 300));
                              } else 
                              started = null;
                            }
                            _timerIsRunning =! _timerIsRunning;
                            
                            
                        },
                        
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 70, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xffffffff),
                            radius: 15,
                            child: Image.asset('assets/gold.png', width: 30, height: 30),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            StaticData.Vang.toString(),
                            style: TextStyle(fontSize: 30),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 150, top: 70),
                          child: Text(
                            "Time Focus",
                            style: TextStyle(
                              fontSize: 17,
                            ),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 170, top: 5),
                          child: Text(
                            (timetoDisplay=="")? "00:00:00": timetoDisplay ,
                            style: TextStyle(
                              fontSize: 28,
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

  //for alert 
  void showAlertDialog(BuildContext context) {
      // set up the buttons
      Widget cancelButton = FlatButton(
        child: Text("Cancel"),
        onPressed:  () {
          _controlIcon = Icons.pause;
          Navigator.of(context).pop(); 
        },
      );
      Widget continueButton = FlatButton(
        child: Text("Continue"),
        onPressed:  () {
          stoped ? null : stop();
          gifcontroller.repeat(min:0,max:0,period:Duration(milliseconds: 1));
            _controlIcon = Icons.play_arrow;
          // duration = timetoDisplay;  
          // print(timetoDisplay);
          updateHistories(false, "00:10:00");
          updateGold();   // để test
          Navigator.of(context).pop();
          
          },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Alert"),
        content: Text("Would you like reset the timer?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
  }
  // for timer set up
  bool _timerIsRunning = false;

  TabController tb;
  int hour = 0;
  int min = 10;
  int sec = 0;
  String hour1 = "0", min1 = "0", sec1 = "0";
  bool started = true;
  bool stoped = true;
  int timeForTimer = 0;
  String timetoDisplay = "00:00:00";
  bool checkTimer = true;

    void increase(){           
        setState(() {
          if(min < 0) min = 0;
          if(min == 55 ) { hour = hour + 1 ; min = -5; }         
        min = min + 5;
        if (hour >= 5 ){ hour= 5;}
        print("Increase timer by 5 min : $min " );
            });
    }
    void decrease(){
      setState(() {
        if (min <= 0) {
          if (hour > 0) {
            hour--;
            min = 60;
          }
          else if (hour == 0) min = 5;
        }
        if (min <= 15) min = 15;
        min = min -5;
        print("Decrease timer by 5 min : $min " );
        //min = 1;
        
      });
    }
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
            debugPrint("Completed the task");
            _controlIcon = Icons.play_arrow;
            gifcontroller.repeat(min:0,max:0,period:Duration(milliseconds: 1));
            updateGold();
            _showSuccess(this.context, "Hoàn thành nhiệm vụ \n + 50 gold");

            updateHistories(true, "00:10:00");

            // cập nhật số gold vào text
            // setState(() {
            //     stoped ? null : stop();
            //     gifcontroller.repeat(min:0,max:0,period:Duration(milliseconds: 1));
            // });
            // cập nhật số gold vào database
          }
          checkTimer = true;
          timetoDisplay = "";
          started = true;
          stoped = true;
        }

        // xử lý chuyển đổi timer
        else if (timeForTimer < 60){
          timetoDisplay = "00:00:" + timeForTimer.toString();
          timeForTimer = timeForTimer - 1;
        }
        else if (timeForTimer < 3600){
          int m = timeForTimer ~/ 60;
          int s = timeForTimer - (60*m);
          timetoDisplay = "00:" + m.toString() + ":" + s.toString();
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
  void _showSuccess(context, String message){
  Alert(
    context: context,
    type: AlertType.success,
    title: "Thông báo",
    closeIcon: Icon(Icons.error),
    desc: message,
    buttons: [
      DialogButton(
        child: Text(
          "ACCEPT",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
          //runApp(focus());
        },
        width: 120,
        color: Colors.green[400],
      )
    ],
  ).show();
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

  // move to set timer screen
  void _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => st.SetTime()),
    );

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));

    String message = result!= null ? result: '0:0:0';
    var time = message.split(':');
    hour = int.parse(time[0]);
    min =int.parse(time[1]);
    sec = int.parse(time[2]);
  }
  
}



