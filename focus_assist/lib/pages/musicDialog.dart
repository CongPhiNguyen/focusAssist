import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_volume_slider/flutter_volume_slider.dart';
import 'audio/song1.dart';
import 'audio/song2.dart';

class musicDialog extends StatefulWidget {
  const musicDialog({Key key}) : super(key: key);

  @override
  _musicDialogState createState() => _musicDialogState();
}

class _musicDialogState extends State<musicDialog> {
  final fontFamily = "Roboto";
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only( left: 60, top: 150, right: 60, bottom: 160),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
        child: Container(
          child: Column(
            children: [
              Container(
                constraints: BoxConstraints.expand(height: 35.0),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight:Radius.circular(12) ),
                ),
                child: Center(
                  child: Text(
                      "White Noise",
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints.expand(height: 45.0),
                decoration: BoxDecoration(
                  color: Colors.amber[400],
                ),
                child: Center(
                  child: Text(
                    "Choose the song you want to stay focus better!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // this is music list
              // this is music list
              Container(
                padding: EdgeInsets.only(bottom: 190),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // song1(),
                    // song2(),
                    Text("song 1", style: TextStyle(fontSize: 30),),
                    Text("song 2" , style: TextStyle(fontSize: 30),),
                    ],
                ),
              
              ),
              SizedBox(height: 5,),
              Container(
                child: Material(
                  child: Container(
                    constraints: BoxConstraints.expand(height: 50.0, width: 290),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: FlutterVolumeSlider(
                       display: Display.HORIZONTAL,
                       sliderActiveColor: Colors.blue,
                       sliderInActiveColor: Colors.grey,
                     ),
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints.expand(height: 80.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight:Radius.circular(12) ),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [                 
                  RaisedButton(
                  onPressed: (){
                    print("button 1");
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
                    print("button 2");
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
                ],)
                ),
            ],
          ),
        ),
    );

  }
}
