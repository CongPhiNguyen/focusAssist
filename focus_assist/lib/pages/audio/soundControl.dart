import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'song1.dart';
import 'song2.dart';



class control {
  static bool issongplaying ;
  static AudioCache audioCache;
  static AudioPlayer audioPlayer  = new AudioPlayer();
}