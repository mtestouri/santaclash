import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/screen_util.dart';

class Asset {
  // physical properties
  int type = 0; // static or dynamic
  // TODO const type
  bool gravity = false;
  // position and velocity
  double velX = 0;
  double velY = 0;
  double posX = 0;
  double posY = 0;
  double hitboxX = 0;
  double hitboxY = 0;
  // image file
  String imageFile = '';
  double imageHeight = 0;
  double imageWidth = 0;

  double get hitboxLeft => (posX + hitboxX/2);
  double get hitboxRight => (posX - hitboxX/2);
  double get hitboxTop => (posY + hitboxY/2);
  double get hitboxBottom => (posY - hitboxY/2);

  Widget toWidget() {
    return Positioned( // TODO check
        bottom: ScreenUtil.blockSizeHeight*posY - imageHeight/2,
        left: ScreenUtil.blockSizeWidth*posX - imageWidth/2,
        child: Container(
          height: imageHeight,
          width: imageWidth,
          child: FittedBox(
            child: Image.asset(imageFile),
            fit: BoxFit.fill,
          ),
          /*decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageFile),
            fit: BoxFit.fill,
            )
          ),*/
        ),
    );
  }
}
