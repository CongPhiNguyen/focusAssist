import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

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
    audioPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: audioPlayer);
    audioPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });
    audioPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                  isplaying
                      ? _animationIconController.reverse()
                      : _animationIconController.forward();
                  isplaying = !isplaying;
                });
                if (issongplaying == false) {
                  audioCache.play("Song2.mp3");
                  setState(() {
                    issongplaying = true;
                  });
                } else {
                  audioPlayer.pause();
                  setState(() {
                    issongplaying = false;
                  });
                }
                  },
                  child: ClipOval(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(
                          width: 2.5,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      width: 50,
                      height: 50,
                      child: Center(
                        child: AnimatedIcon(
                          icon: AnimatedIcons.play_pause,
                          progress: _animationIconController,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ),
                // Slider(
                //   activeColor: Colors.blue,
                //   inactiveColor: Colors.grey,
                //   value: _position.inSeconds.toDouble(),
                //   max: _duration.inSeconds.toDouble(),
                //   onChanged: (double value) {
                //     setState(() {
                //       seekToSeconds(value.toInt());
                //       value = value;
                //     });
                //   },
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text("${_position.inSeconds.toDouble()}"+ "/"),
                //       Text("${_duration.inSeconds.toDouble()}"),
                //     ],
                //   ),
                // ),
                Text(
                    "Keyboard sound",
                     style: TextStyle(fontSize: 7, ),
                    textAlign: TextAlign.left,
                    textScaleFactor: 4.0,
                  ),  
              ],
            ),
            
          ],
        ),
      );
}


AnimationController _animationIconController;

AudioCache audioCache;

AudioPlayer audioPlayer;

Duration _duration = new Duration();
Duration _position = new Duration();

bool issongplaying = false;

bool isplaying = false;
void seekToSeconds(int second) {
  Duration newDuration = Duration(seconds: second);
  audioPlayer.seek(newDuration);
}
}