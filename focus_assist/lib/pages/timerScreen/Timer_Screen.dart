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

}

class _TimerScreenState extends State<TimerScreen> with TickerProviderStateMixin{
  bool isVisible = true;
  bool isNotVisible = false;
  GifController gifcontroller;
  IconData _controlIcon;
  bool timerRunning = false;

  String duration = "00:00:00";
  final dbHelper = DbProvider.instance;
  void initState() {
    // TODO: implement initState
    tb = TabController(length: 1, vsync: this);
    super.initState();
    gifcontroller= GifController(vsync: this);
    _controlIcon = Icons.play_arrow;
    loadGold();
  }
  void loadGold() async {
    String userID = StaticData.userID;
    List<Map<String, dynamic>> database = await dbHelper.rawQuery(
        ''' select * from THONGTINNGUOIDUNG where MANGUOIDUNG='$userID' ''');
    try {
      if (database.length > 0) {
      setState(() {
        StaticData.Vang = database[0]['VANG'];
      });
      }
    } catch(e) {print("error load gold");}
    finally {
      print("da cap nhat duoc gold");
    }
    
  }
  void updateGold(int reward) async {
    int golds = StaticData.Vang += reward;
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
    print("da add vao history!");

  }
  void clearHistory(){
    String userKey = StaticData.userID;
     dbHelper.rawQuery(
            ''' DELETE FROM LICHSUTIMER WHERE MANGUOIDUNG='$userKey'; ''');
  }
  void checkThanhTuu() async {
    String userKey = StaticData.userID;
    List<Map<String, dynamic>> database = await dbHelper.rawQuery(
            ''' SELECT COUNT(*) as count FROM LICHSUTIMER
            where MANGUOIDUNG='$userKey' and DAHOANTHANH = 'true' ''');
    print("da hoan thanh duoc "+ database[0]['count'].toString());
    switch(database[0]['count']){
      case 5: {
        _showSuccessThanhTuu(this.context, "Congrat, you focused 5 times!\n + 40 gold", 40);
        break;
      }
      case 10: {
        _showSuccessThanhTuu(this.context, "Congrat, you focused 10 times!\n + 100 gold",100);
        break;
      }
      case 20: {
        _showSuccessThanhTuu(this.context, "Congrat, you focused 20 times!\n + 200 gold",200);
        break;
      }
      case 30: {
        _showSuccessThanhTuu(this.context, "Congrat, you focused 30 times!\n + 300 gold", 300);
        break;
      }
      case 50: {
        _showSuccessThanhTuu(this.context, "Congrat, you focused 50 times!\n + 500 gold", 500);
        break;
      }
      default:
        break;
    }

  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                             print("cleared history");
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
          //background color here
            color: Colors.orange,
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
            SizedBox(height: 40,
            
              child: Text("Stay calm, stay focused!", 
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
             ),
            Expanded(
              flex: 4,
              // child: Container(
              //   margin: EdgeInsets.only(bottom: 10),
              //   alignment: Alignment.topCenter,
              //   height: MediaQuery.of(context).size.height* 0.3,
              //   width: MediaQuery.of(context).size.width*0.8,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     //color circle
              //     color: Colors.blue,
              //     border: Border.all(
              //       color: Colors.grey,
              //       width: 2,
              //     ),
              //   ),
                child: Container(
                height: MediaQuery.of(context).size.height* 0.8 + 100,
                width: MediaQuery.of(context).size.width*0.8 + 200,
                  margin: EdgeInsets.only(top: 10,),
                  child: GifImage(
                      controller: gifcontroller,
                      image: AssetImage("assets/images/clock.gif"),
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
                               //showAlertDialog(context);
                               showDialogResetTimer(context, "Reset timer?");
                            }
                            else {    
                              _controlIcon = Icons.pause;  
                                                 
                              //started? (start()): null;
                              if (started) {
                                start();
                                gifcontroller.repeat(min:0,max:95,period:Duration(milliseconds: 3000));
                              } else 
                              started = null;
                            }
                            _timerIsRunning =! _timerIsRunning;
                            StaticData.focusTimerIsRunning = _timerIsRunning;
                            
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
        // if (min <= 0) {
        //   if (hour > 0) {
        //     hour--;
        //     min = 60;
        //   }
        //   else if (hour == 0) min = 5;
        // }
        // if (min <= 15) min = 15;
        // min = min -5;
        // print("Decrease timer by 5 min : $min " );
        min = 1;
        updateGold(50);
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
    StaticData.timeToGold = timeForTimer;
    int reward = (StaticData.timeToGold~/150);
    print("nếu hoàn thành thưởng "+reward.toString());
    Timer.periodic(
      Duration(seconds: 1), (Timer t){
      try{
          setState(() {
        if(timeForTimer < 1 || checkTimer == false) {
          t.cancel();
          if(timeForTimer  == 0) {
            // dùng để xử lý sau này khi kết thúc cần sự kiện
            debugPrint("Completed the task");
            _controlIcon = Icons.play_arrow;
            // gifcontroller.repeat(min:0,max:0,period:Duration(milliseconds: 1));
            updateGold(reward);
            _showSuccess(this.context, "Hoàn thành nhiệm vụ \n + $reward gold");
            gifcontroller.stop();
            updateHistories(true, "00:10:00");
            checkThanhTuu();
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

      } catch(e){ print("loi timer dong 397 timerScreen");}
      finally {print("ko loi timer 397"); }
      
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
          "OK",
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
  void _showSuccessThanhTuu(context, String message, int reward){
  try { 
    Alert(
    context: context,
    type: AlertType.success,
    title: "Thông báo",
    closeIcon: Icon(Icons.cancel_outlined),
    desc: message,
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          updateGold(reward);
          Navigator.pop(context);
          //runApp(focus());
        },
        width: 120,
        color: Colors.green[400],
      )
    ],
  ).show();
  }
  catch(e) {print("loi o show thanh tuu");}
  }
  void showDialogResetTimer(context,String message){
    Alert(
      context: context,
      type: AlertType.warning,
      title: 'Warning!!!',
      closeIcon: Icon(Icons.close_outlined),
      desc: message,
      buttons: [
              DialogButton(
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                      checkThanhTuu();
                      stoped ? null : stop();
                      gifcontroller.repeat(min:0,max:0,period:Duration(milliseconds: 1));
                        _controlIcon = Icons.play_arrow;
                      // duration = timetoDisplay;  
                      // print(timetoDisplay);
                      updateHistories(false, "00:10:00");
                      Navigator.of(context).pop();
                },
                color: Color.fromRGBO(0, 179, 134, 1.0),
              ),
              DialogButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () { 
                    _controlIcon = Icons.pause;
                  StaticData.focusTimerIsRunning = true;
                  Navigator.of(context).pop(); 
                  },
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(116, 116, 191, 1.0),
                  Color.fromRGBO(52, 138, 199, 1.0)
                ]),
              )
            ]
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



