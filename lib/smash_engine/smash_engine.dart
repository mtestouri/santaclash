import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/asset.dart';
import 'package:smashlike/smash_engine/screen_util.dart';

// TODO 
// excepction
// ScreenUtil
// Interface and inputs
// physics

class SmashEngine extends StatefulWidget {
  final List<Asset> _assets;

  SmashEngine({List<Asset> assets}) :
    this._assets = assets;

  @override
  SmashEngineState createState() => SmashEngineState();
}

class SmashEngineState extends State<SmashEngine> with SingleTickerProviderStateMixin {
  bool _isRunning = false;
  List<Asset> _assets; // TODO add UI and separate static and dynamics ?
  AnimationController _controller;
  Animation _animation;
  
  // current FPS
  DateTime _prevTime;
  double _currFps = 60;
  // average FPS
  int _counter = 0;
  int _sumFps = 0;
  int _avgFps = 0;

  @override
  void initState() {
    super.initState();

    _assets = widget._assets;

    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _animation.addListener(gameLoop);
    _animation.addStatusListener((animationStatus) {
      if (animationStatus == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
    
    _prevTime = DateTime.now();
    _controller.forward();
  }

  @override
  Widget build(BuildContext inContext) {
    
    // display assets
    List<Widget> assetWidgets = new List();
    for(var asset in _assets)
      assetWidgets.add(asset.toWidget());

    // display FPS
    assetWidgets.add(Positioned(
      top: ScreenUtil.blockSizeHeight*5,
      left: ScreenUtil.blockSizeWidth*5,
      child: Text(_avgFps.round().toString()),
    ));

    return Stack(
      children: assetWidgets,
    );
  }

  void gameLoop() {
    // update assets
    //_updateAssets();
    
    // current FPS
    DateTime currTime = DateTime.now();
    int diff = currTime.difference(_prevTime).inMicroseconds;
    _prevTime = currTime;
    _currFps = 1000000/diff;
    if(_currFps > 65)
      _currFps = 60; // avoid aberrant values
    
    // average FPS
    _sumFps += _currFps.round();
    _counter++;
    if(_counter == 30) {
      _avgFps = (_sumFps/30).round();
      _counter = 0;
      _sumFps = 0;
    }

    // render the frame
    setState((){});
  }

  // Run game
    
    //_arena.run();
    //_isRunning = true;
    //_currFps = 60;
    
    /*while(_isRunning) {
      DateTime startTime = DateTime.now();
      _update();
      _render();
      DateTime endTime = DateTime.now();
      int diff = -(startTime.difference(endTime).inMilliseconds - 16);
      if(diff > 0)
        sleep(Duration(milliseconds: diff));
      _currFps = 1/diff;
    }*/

  void stop() {
    _isRunning = false;
  }

  void _updateAssets() {
    // read inputs
    // game logic update
    _physicsUpdate(); // physics update
  }

  void _physicsUpdate() {
    for(int i=0; i<_assets.length; i++) {
      if(_assets[i].type == 1) { // static assets don't move
        var a1 = _assets[i];

        // velocities
        if(a1.gravity) // gravity
          a1.velY -= 1/_currFps;
        // TODO inputs and adjust gravity

        // collisions
        for(int j=0; j<_assets.length; j++) {
          if(j != i && (_assets[j].type == 0)){
            // dynamic to static collisions only
            // TODO add dynamic to dynamic collisions ?
            var a2 = _assets[j];
            if(max(a1.hitboxLeft + a1.velX, a2.hitboxLeft + a2.velX) 
              < min(a1.hitboxRight + a1.velX, a2.hitboxRight + a2.velX) &&
              max(a1.hitboxBottom + a1.velY, a2.hitboxBottom + a2.velY) 
              < min(a1.hitboxTop + a1.velY, a2.hitboxTop + a2.velY)) {
              a1.velX = 0;
              a1.velY = 0;
              // TODO update position so that it is just before collision
            }
          }
        }

        // positions
        a1.posX += a1.velX;//_currFps;
        a1.posY += a1.velY;//_currFps;
      }
    }
  }
}
