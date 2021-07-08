import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:focus_assist/classes/Data.dart';
import 'soundControl.dart';
class song4 extends StatefulWidget {
  @override
  _song4State createState() => _song4State();
}

class _song4State extends State<song4>  with TickerProviderStateMixin {
   _song4State(){}
  @override
 void initState() {
    super.initState();

    initPlayer();
  }

  void initPlayer() {
    _animationIconController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
      reverseDuration: Duration(milliseconds: 750),
    );

    //1
    //control.audioPlayer = new AudioPlayer();
    audioCache = AudioCache(fixedPlayer: control.audioPlayer);
    // control.audioPlayer.durationHandler = (d) => setState(() {
    //       _duration = d;
    //     });
    // control.audioPlayer.positionHandler = (p) => setState(() {
    //       _position = p;
    //     });

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        
        SizedBox(width: 10,),
        MaterialButton(

          onPressed: () {
            control.audioPlayer.pause();
            setState(() {
              audioCache.play("guitar.mp3");
            });
          },
          minWidth: 0,
          elevation: 2.0,
          color: (!StaticData.isDarkMode)?Colors.amber:Colors.grey[800],
          child: Icon(
            Icons.play_arrow,
            size: 22.0,
            color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[400],
          ),
          padding: EdgeInsets.all(10.0),
          shape: CircleBorder(),

        ),
        MaterialButton(
          onPressed: () {
            control.audioPlayer.pause();
            setState(() {
            issongplaying = false;
            });
          },
          elevation: 2.0,
          color: (!StaticData.isDarkMode)?Colors.amber:Colors.grey[800],
          minWidth: 0,
          child: Icon(
            Icons.pause,
            size: 22.0,
            color: (!StaticData.isDarkMode)?Colors.white:Colors.grey[400],
          ),
          padding: EdgeInsets.all(10.0),
          shape: CircleBorder(),
        ),
        SizedBox(width: 30,),
        Text(
          "For work 2",
          style: TextStyle(fontSize: 20, color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[400]),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
        ),
      ],
    );
}


AnimationController _animationIconController;

AudioCache audioCache;

//AudioPlayer audioPlayer;

Duration _duration = new Duration();
Duration _position = new Duration();

 bool issongplaying = false;

bool isplaying = false;
void seekToSeconds(int second) {
  Duration newDuration = Duration(seconds: second);
  control.audioPlayer.seek(newDuration);
}
}