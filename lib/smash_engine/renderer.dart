import 'dart:math';
import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/screen_util.dart';

class Renderer extends StatefulWidget {
  final List<Asset> _assets;

  Renderer({List<Asset> assets})
    : this._assets = assets;

  @override
  RendererState createState() => RendererState();
}

class RendererState extends State<Renderer> with SingleTickerProviderStateMixin {
  List<Asset> _assets;
  
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
  Widget build(BuildContext context) {
    
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void gameLoop() {
    // read inputs
    
    // update assets
    // game logic update
    _physicsUpdate(); // physics update
    
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

  void _physicsUpdate() {
    // TODO better optimize ?
    List<PhysicalAsset> physicalAssets = new List();
    for(var asset in _assets) {
      if(asset is PhysicalAsset)
        physicalAssets.add(asset);
    }

    for(int i=0; i<physicalAssets.length; i++) {
      if(physicalAssets[i].type == PhysicalAsset.DYNAMIC) {
        PhysicalAsset a1 = physicalAssets[i];

        // gravity
        if(a1.gravity)
          a1.velY -= 1/_currFps; // TODO adjust

        // collisions
        for(int j=0; j<physicalAssets.length; j++) {
          if(j != i && (physicalAssets[j].type == 0)){
            // dynamic to static collisions only
            var a2 = physicalAssets[j];
            if(max(a1.hitboxLeft + a1.velX, a2.hitboxLeft + a2.velX) 
              < min(a1.hitboxRight + a1.velX, a2.hitboxRight + a2.velX) &&
              max(a1.hitboxBottom + a1.velY, a2.hitboxBottom + a2.velY) 
              < min(a1.hitboxTop + a1.velY, a2.hitboxTop + a2.velY)) {
              a1.velX = 0;
              a1.velY = 0;
              // TODO update position so that it is just before collision
              // TODO don't cancel both speed
            }
          }
        }

        // positions
        a1.posX += a1.velX;
        a1.posY += a1.velY;
      }
    }
  }
}

class Asset {
  // visual properties
  String imageFile = '';
  double imageHeight = 0;
  double imageWidth = 0;
  double posX = 0;
  double posY = 0;

  // TODO animation

  Widget toWidget() {
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

class PhysicalAsset extends Asset {
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
