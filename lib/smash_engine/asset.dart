import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:smashlike/smash_engine/screen_util.dart';

abstract class Asset {
  // visual properties
  String imageFile = '';
  double imageHeight = 0;
  double imageWidth = 0;
  double posX = 0;
  double posY = 0;
  // animations
  int _counter = 0;
  bool _animRepeat = false;
  Map<int, String> _framesMap;
  Map<String, Map<int, String>> _animationsMap;

  Map<String, Map<int, String>> animationsFactory();

  Asset() {
    this._animationsMap = animationsFactory();
  }
  
  void startAnimation(String animationId, {bool repeat}) {
    if(_animationsMap != null) {
      _counter = 0;
      if(repeat != null)
        _animRepeat = repeat;
      else
        _animRepeat = false;
      _framesMap = _animationsMap[animationId];
    }
  }

  Widget toWidget() {
    // animation
    if(_framesMap != null) {
      // get next frame
      String frame = _framesMap[_counter];
      if(frame != null)
        imageFile = frame;
      _counter++;
      // check end of animation
      if(_counter > _framesMap.keys.reduce(max)) {
        if(_animRepeat)
          _counter = 0;
        else
          _framesMap = null;
      }
    }
    // build widget
    if(imageFile != '') {
      return Positioned(
        bottom: ScreenUtil.blockSizeHeight*posY - imageHeight/2,
        left: ScreenUtil.blockSizeWidth*posX - imageWidth/2,
        child: Container(
          height: imageHeight,
          width: imageWidth,
          child: FittedBox(
            child: Image.asset(imageFile),
            fit: BoxFit.fill,
          ),
        ),
      );
    }
    return null;
  }
}

abstract class PhysicalAsset extends Asset {
  // physical properties
  static const STATIC = 0;
  static const DYNAMIC = 0;
  int type = STATIC;
  bool gravity = false;
  // velocities
  double velX = 0;
  double velY = 0;
  double hitboxX = 0;
  double hitboxY = 0;
  // hitboxes
  double get hitboxLeft => (posX - hitboxX/2);
  double get hitboxRight => (posX + hitboxX/2);
  double get hitboxTop => (posY + hitboxY/2);
  double get hitboxBottom => (posY - hitboxY/2);
}