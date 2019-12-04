import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/asset.dart';
import 'package:smashlike/smash_engine/physics.dart';
import 'package:smashlike/smash_engine/screen_util.dart';
import 'package:smashlike/smash_engine/smash_engine.dart';

class Renderer extends StatefulWidget {
  final Physics _physics;
  final GameAssets _assets;
  final GameLogic _gameLogic;

  Renderer({@required Physics physics, 
            @required GameAssets assets, 
            @required GameLogic gameLogic})
    : this._physics = physics,
      this._assets = assets,
      this._gameLogic = gameLogic;

  @override
  RendererState createState() => RendererState();
}

class RendererState extends State<Renderer> with SingleTickerProviderStateMixin {
  Physics _physics;
  GameAssets _assets;
  GameLogic _gameLogic;
  
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

    _physics = widget._physics;
    _assets = widget._assets;
    _gameLogic = widget._gameLogic;
    
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    //_animation.addListener(_gameLoop);
    _animation.addListener(_render);
    _animation.addStatusListener((animationStatus) {
      if (animationStatus == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
    
    _prevTime = DateTime.now();
    _controller.forward();
  }

  void _render() {
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

    // update FPS in physics
    _physics.currFps = _currFps;

    // render the frame
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // game logic update
    _gameLogic.update(SmashEngine.of(context).inputs, _assets);
    
    // physics update
    _physics.update(_assets.physicalAssets);

    // display assets
    List<Widget> assetWidgets = List();
    for(var asset in _assets.toAssetList()) {
      assetWidgets.add(asset.toWidget());
    }

    // display FPS
    assetWidgets.add(Positioned(
      left: ScreenUtil.unitWidth*5,
      bottom: ScreenUtil.unitHeight*90,
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
}