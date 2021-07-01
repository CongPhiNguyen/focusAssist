import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:focus_assist/classes/Data.dart';
import 'soundControl.dart';

class song2 extends StatefulWidget {
  @override
  _song2State createState() => _song2State();
}

class _song2State extends State<song2>  with TickerProviderStateMixin {
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
    //audioPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: control.audioPlayer);
    // control.audioPlayer.durationHandler = (d) => setState(() {
    //       _duration = d;
    //     });
    // control.audioPlayer.positionHandler = (p) => setState(() {
    //       _position = p;
    //     });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // GestureDetector(
                //   onTap: () {
                //     setState(() {
                //   isplaying
                //       ? _animationIconController.reverse()
                //       : _animationIconController.forward();
                //   isplaying = !isplaying;
                // });
                // if (issongplaying == false) {
                //   audioCache.play("Song2.mp3");
                //   setState(() {
                //     issongplaying = true;
                //   });
                // } else {
                //   control.audioPlayer.pause();
                //   setState(() {
                //     issongplaying = false;
                //   });
                // }
                //   },
                //   child: ClipOval(
                //     child: Container(
                //       decoration: BoxDecoration(
                //         color: Colors.blue,
                //         border: Border.all(
                //           width: 2.5,
                //           color: Colors.white,
                //         ),
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(50.0),
                //         ),
                //       ),
                //       width: 50,
                //       height: 50,
                //       child: Center(
                //         child: AnimatedIcon(
                //           icon: AnimatedIcons.play_pause,
                //           progress: _animationIconController,
                //           color: Colors.white,
                //           size: 35,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(width: 10,),
                MaterialButton(      
                  onPressed: () {
                    control.audioPlayer.pause();
                    setState(() {
                      audioCache.play("Song2.mp3");
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
                  "Keyboard sound",
                  style: TextStyle(fontSize: 20, color: (!StaticData.isDarkMode)?Colors.black:Colors.grey[400]),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            
          ],
        ),
      );
}


AnimationController _animationIconController;

AudioCache audioCache;


Duration _duration = new Duration();
Duration _position = new Duration();

bool issongplaying = false;

bool isplaying = false;
void seekToSeconds(int second) {
  Duration newDuration = Duration(seconds: second);
  control.audioPlayer.seek(newDuration);
}
}