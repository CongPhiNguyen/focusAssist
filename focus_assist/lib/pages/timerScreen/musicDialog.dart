import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_volume_slider/flutter_volume_slider.dart';
import 'package:focus_assist/classes/Data.dart';
import 'package:focus_assist/pages/audio/song1.dart';
import 'package:focus_assist/pages/audio/song2.dart';

class musicDialog extends StatefulWidget {
  const musicDialog({Key key}) : super(key: key);

  @override
  _musicDialogState createState() => _musicDialogState();
}

class _musicDialogState extends State<musicDialog> with AutomaticKeepAliveClientMixin {
  final fontFamily = "Roboto";
  @override
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Container(
          // color: Colors.white,
          decoration: BoxDecoration(
            color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: BoxConstraints.expand(height: 35.0),
                decoration: BoxDecoration(
                  color: (!StaticData.isDarkMode)?Colors.amber:Colors.grey[800],
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight:Radius.circular(12) ),
                ),
                child: Center(
                  child: Text(
                    "White Noise",
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1.5,
                      color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[200],
                    ),
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints.expand(height: 45.0),
                decoration: BoxDecoration(
                  color: (!StaticData.isDarkMode)?Colors.amber[800]:Colors.grey[850],
                ),
                child: Center(
                  child: Text(
                    "Play a song to help you stay focus!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 1,
                      color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[300],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20, ),
              // this is music list
              SizedBox(
                height: 200,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          color: (!StaticData.isDarkMode)?Colors.grey[50]:Colors.grey[900],
                          child: Column(
                            children: <Widget>[
                              song1(),
                              song1(),
                              song2(),
                              song2(),
                              // song1(),
                              // song1(),
                              // song1(),
                              // song1(),
                              // song1(),
                              // song1(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Material(
                child: Container(
                  constraints: BoxConstraints.expand(height: 50.0, width: 290),
                  decoration: BoxDecoration(
                    color: (!StaticData.isDarkMode)?Colors.grey[50]:Colors.grey[850],
                  ),
                  child: FlutterVolumeSlider(
                    display: Display.HORIZONTAL,
                    sliderActiveColor: Colors.blue,
                    sliderInActiveColor: Colors.grey,
                  ),
                ),
              ),
              Container(
                  constraints: BoxConstraints.expand(height: 80.0),
                  decoration: BoxDecoration(
                    color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[900],
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight:Radius.circular(12) ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: (){
                          print("button ok");
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                          // textStyle: TextStyle(
                          //   color: Colors.white,
                          //   fontSize: 18,
                          // ),
                          backgroundColor: (!StaticData.isDarkMode)?Colors.amber:Colors.grey[800],
                        ),
                        // padding: EdgeInsets.symmetric(
                        //   horizontal: 30.0,
                        //   vertical: 10.0,
                        // ),
                        // color: Colors.amber,
                        child: Text(
                          "OK",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[300],
                          ),
                        ),
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(15.0),
                        // ),
                      ),
                      // RaisedButton(
                      //   onPressed: (){
                      //     print("Cancle Music");
                      //     Navigator.pop(context);
                      //   },
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: 40.0,
                      //     vertical: 10.0,
                      //   ),
                      //   color: Colors.red,
                      //   child: Text(
                      //     "Cancle",
                      //     style: TextStyle(
                      //       fontSize: 18.0,
                      //       color: Colors.white,
                      //     ),),
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(15.0),
                      //   ),
                      // ),
                    ],)
              ),
            ],
          ),
        ),
      ),
    );

  }
}
