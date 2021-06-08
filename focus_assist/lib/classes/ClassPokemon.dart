import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';

/*class InfoPokemon{
  final String TenPokemon;
  final int Level;
  final Color rareColor;

  InfoPokemon(
      this.TenPokemon,
      this.Level,
      this.rareColor,
      );
}*/

class InfoPokemon {
  String TenPokemon;
  int Level;
  Color rareColor;
  int currentFrame = 1;
  String direction;
  double positionX;
  double positionY;

  InfoPokemon(
      this.TenPokemon,
      this.Level,
      this.rareColor,
      );

  void randomDirecAndPos(){
    Random rdPos = new Random();

    positionX = ((rdPos.nextInt(7) - 7) / 10);
    positionY = ((rdPos.nextInt(7) - 7) / 10);


    Random direc = new Random();
    int index = direc.nextInt(4);
    switch (index) {
      case 0 :
        direction = 'left';
        break;
      case 1:
        direction = 'right';
        break;
      case 2:
        direction = 'up';
        break;
      case 3:
        direction = 'down';
        break;
      default:
        break;
    }
  }

  void move() {
    currentFrame ++;
    if (direction == 'left') {
        positionX -= 0.05;
    } else if (direction == 'down') {
        positionY += 0.025;
    } else if (direction == 'up') {
        positionY -= 0.025;
    } else {
        positionX += 0.05;
    }

    if(positionX < -0.9) {
        direction = 'right';
    } else if(positionX > 0.9){
        direction  = 'left';
    } else if(positionY > 0.9) {
        direction = 'up';
    } else if(positionY < -0.9){
        direction = 'down';
    }

    if(currentFrame == 3) {
        currentFrame = 1;
    }

  }


  void changeDirection() {
    Random rd = new Random();
    int index = rd.nextInt(4);
    switch (index) {
      case 0 :
        direction = 'left';
        break;
      case 1:
        direction = 'right';
        break;
      case 2:
        direction = 'up';
        break;
      case 3:
        direction = 'down';
        break;
      default:
        break;
   };
  }
}