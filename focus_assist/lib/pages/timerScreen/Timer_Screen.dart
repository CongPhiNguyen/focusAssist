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
import 'package:focus_assist/pages/audio/soundControl.dart';

//
// Color kPrimaryColor = (!StaticData.isDarkMode)?Color(0xFF0C9869):Colors.grey;
// Color kTextColor = (!StaticData.isDarkMode)?Color(0xFF3C4046):Colors.black;
// Color kBackgroundColor = (!StaticData.isDarkMode)?Color(0xFFF9F8FD):Colors.grey[800];
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
  // GifController gifcontroller;
  IconData _controlIcon;
  bool timerRunning = false;

  // String duration = "00:00:00";
  final dbHelper = DbProvider.instance;
  void initState() {
    // TODO: implement initState
    tb = TabController(length: 1, vsync: this);
    super.initState();
    StaticData.gifcontroller= GifController(vsync: this);
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
        dbHelper.rawQuery(
            ''' update THONGTINNGUOIDUNG set VANG=$golds where MANGUOIDUNG='${StaticData.userID}' ''');
        loadGold();
    
  }
  void updateHistories(bool hoanThanh, String duration) async {
    DateTime now = DateTime.now();
    // String dateTime = now.year.toString() + "-" + now.month.toString()+ "-"+ now.day.toString()+ " "+ now.hour.toString()
    //     + ":" + now.minute.toString() + ":" + now.second.toString();
    String dateTime = DateTime.now().toString().split('.')[0];
    print(dateTime);
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
        backgroundColor: (!StaticData.isDarkMode)?Colors.amber:Colors.grey[850],
        // elevation: 1.0,
        title: Text(
          '     Focus Timer',
          style: TextStyle(
            color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[300],
            letterSpacing: 0.5
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.library_music_rounded),
            tooltip: 'Show Snackbar',
            onPressed: () {
              dialogHelper.musicList(context);
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
            child: IconButton(
              icon: const Icon(Icons.alarm),
              tooltip: 'Go to the next page',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(
                        backgroundColor: (!StaticData.isDarkMode)?Colors.amber:Colors.grey[850],
                        title: Text(
                          'Timer history',
                          style: TextStyle(
                            color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[100],
                          ),
                        ),
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
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          //background color here
            color: (!StaticData.isDarkMode)?Colors.orange:Colors.grey[900],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                IconButton (
                  icon: Icon(Icons.keyboard_arrow_down_sharp),
                  iconSize: 50,
                  color: (!StaticData.isDarkMode)?Colors.white:Colors.grey,
                  onPressed: () {
                    decrease();
                  }
                ),
                Text('${(hour < 10)?'0${hour.toString()}':hour.toString()}' + ':' + '${(min < 10)?'0${min.toString()}':min.toString()}' + ':00',
                style: TextStyle(fontSize: 40, color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[400]),
                ),
                IconButton (
                  icon: Icon(Icons.keyboard_arrow_up_sharp ),
                   color: (!StaticData.isDarkMode)?Colors.white:Colors.grey,
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
                style: TextStyle(color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[400], fontSize: 30),
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
                      controller: StaticData.gifcontroller,
                      image: (!StaticData.isDarkMode)?AssetImage("assets/images/clock.gif"):AssetImage("assets/images/clock_darkmode.gif"),
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
                      color: (!StaticData.isDarkMode)?Colors.yellow[100]:Colors.grey[850],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
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
                                StaticData.gifcontroller.repeat(min:0,max:99,period:Duration(milliseconds: 3000));
                              } else 
                              started = false;
                            }
                            _timerIsRunning =! _timerIsRunning;
                            StaticData.focusTimerIsRunning = _timerIsRunning;                            
                        },                      
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 70, left: 20),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            // backgroundColor: (!StaticData.isDarkMode)?Color(0xffffffff):Colors.grey[850],
                            backgroundColor: (!StaticData.isDarkMode)?Colors.yellow[100]:Colors.grey[850],
                            radius: 15,
                            child: Image.asset('assets/gold.png', width: 30, height: 30),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            StaticData.Vang.toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: (!StaticData.isDarkMode)?Colors.grey[800]:Colors.grey[300],
                            ),
                          ),
                          // SizedBox(
                          //   width: 30,
                          // ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 70, right: 30),
                          child: Text(
                            "Time Focus",
                            style: TextStyle(
                              fontSize: 17,
                              color: (!StaticData.isDarkMode)?Colors.grey[800]:Colors.grey[300],
                            ),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5, right: 30),
                          child: Text(
                            (timetoDisplay=="")? "00:00:00": timetoDisplay ,
                            style: TextStyle(
                              fontSize: 28,
                              color: (!StaticData.isDarkMode)?Colors.grey[800]:Colors.grey[300],
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
        // setState(() {
        //   if(min < 0) min = 0;
        //   if(min == 55 ) { hour = hour + 1 ; min = -5; }
        // min = min + 5;
        // if (hour >= 5 ){ hour= 5;}
        // print("Increase timer by 5 min : $min " );
        //     });
      setState(() {
        if (hour < 5) {
          min += 5;
          if (min >= 60) {
            min -= 60;
            hour++;
          }
        }
        else {
          hour = 5;
          min = 0;
        }
      });
    }
    void decrease(){
      setState(() {
        if (hour > 0) {
          min -= 5;
          if (min < 0)  {
            min += 60;
            hour--;
          }
        }
        else if (hour == 0) {
          min -= 5;
          if (min <= 5) min = 5;
        }


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

        // min = 1;
        // updateGold(50);
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
    int reward = (timeForTimer~/120);
    print("nếu hoàn thành thưởng "+reward.toString());
    StaticData.timer3 = Timer.periodic(
      Duration(seconds: 1), (Timer t){
      try{
          setState(() {
        if(timeForTimer < 1 || checkTimer == false) {
          t.cancel();
          if(timeForTimer == 0) {
            // dùng để xử lý sau này khi kết thúc cần sự kiện
            debugPrint("Completed the task");
            StaticData.focusTimerIsRunning = false;
            _controlIcon = Icons.play_arrow;
            StaticData.focusTimerIsRunning = false;
            control.audioPlayer.pause();
            // gifcontroller.repeat(min:0,max:0,period:Duration(milliseconds: 1));
            updateGold(reward);
            _showSuccess(this.context, " \n + $reward gold");
            StaticData.gifcontroller.repeat(min:0,max:0,period:Duration(milliseconds: 1));
            StaticData.gifcontroller.stop();
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
          timetoDisplay = "00:00:" + '${(timeForTimer < 10)?'0${timeForTimer.toString()}':timeForTimer.toString()}';
          timeForTimer = timeForTimer - 1;
        }
        else if (timeForTimer < 3600){
          int m = timeForTimer ~/ 60;
          int s = timeForTimer - (60*m);
          timetoDisplay = "00:" + '${(m < 10)?'0${m.toString()}':m.toString()}' + ":" + '${(s < 10)?'0${s.toString()}':s.toString()}';
          timeForTimer = timeForTimer -1;
        }
        else {
          int h = timeForTimer ~/ 3600;
          int t = timeForTimer - (3600*h);
          int m = t ~/ 60;
          int s = t - (60*m);
          timetoDisplay = '${(h < 10)?'0${h.toString()}':h.toString()}' + ":" + '${(m < 10)?'0${m.toString()}':m.toString()}' + ":" + '${(s < 10)?'0${s.toString()}':s.toString()}';
          timeForTimer = timeForTimer -1;
        }
      });

      } catch(e){ print("loi timer dong 397 timerScreen");}
      // finally {print("ko loi timer 397"); }
      
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
      title: "Congratulation",
      closeIcon: Icon(Icons.close),
      desc: message,
      style: AlertStyle(
        titleStyle: TextStyle(
          color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[400],
          fontWeight: FontWeight.w500,
        ),
        descStyle: TextStyle(
          color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[400],
          fontWeight: FontWeight.w500,
        ),
      ),
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[200], fontSize: 20),
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
        title: "Congratulation",
        closeIcon: Icon(Icons.close),
        desc: message,
        style: AlertStyle(
          titleStyle: TextStyle(
            color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[400],
            fontWeight: FontWeight.w500,
          ),
          descStyle: TextStyle(
            color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[400],
            fontWeight: FontWeight.w500,
          ),
        ),
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[200], fontSize: 20),
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
      title: 'Warning!',
      closeIcon: Icon(Icons.close),
      desc: message,
        style: AlertStyle(
          titleStyle: TextStyle(
            color: (!StaticData.isDarkMode)?Colors.red:Colors.red,
            fontWeight: FontWeight.w500,
          ),
          descStyle: TextStyle(
            color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[400],
            fontWeight: FontWeight.w500,
          ),
        ),
      buttons: [
              DialogButton(
                child: Text(
                  "Continue",
                  style: TextStyle(color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[200], fontSize: 20),
                ),
                onPressed: () {
                      checkThanhTuu();
                      if(!stoped) stop();
                      StaticData.gifcontroller.repeat(min:0,max:0,period:Duration(milliseconds: 1));
                      StaticData.gifcontroller.stop();
                        _controlIcon = Icons.play_arrow;
                      // duration = timetoDisplay;  
                      // print(timetoDisplay);
                      updateHistories(false, "00:10:00");
                      control.audioPlayer.pause();
                      Navigator.of(context).pop();
                },
                color: Color.fromRGBO(0, 179, 134, 1.0),
              ),
              DialogButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[200], fontSize: 20),
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



