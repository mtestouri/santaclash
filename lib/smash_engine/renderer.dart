import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/asset.dart';
import 'package:smashlike/smash_engine/physics.dart';
import 'package:smashlike/smash_engine/screen_util.dart';
import 'package:smashlike/smash_engine/smash_engine.dart';
import 'package:smashlike/game/fighters_assets.dart';
// TODO Fighter shouldn't be here
// add hurtbox in game logic ?

class Renderer extends StatefulWidget {
  final Physics _physics;
  final List<Asset> _assets;
  final GameLogic _gameLogic;

  Renderer({@required Physics physics, 
            @required List<Asset> assets, 
            @required GameLogic gameLogic})
    : this._physics = physics,
      this._assets = assets,
      this._gameLogic = gameLogic;

  @override
  RendererState createState() => RendererState();
}

class RendererState extends State<Renderer> with SingleTickerProviderStateMixin {
  Physics _physics;
  List<Asset> _assets;
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
    List<PhysicalAsset> physicalAssets = new List();
    for(var asset in _assets) {
      if(asset is PhysicalAsset)
        physicalAssets.add(asset);
    }
    _physics.update(physicalAssets);

    // display assets
    List<Widget> assetWidgets = new List();
    for(var asset in _assets)
      assetWidgets.add(asset.toWidget());

    // draw hitboxes and hurtboxes
    _drawHitboxes(_assets, assetWidgets);
    _drawHurtboxes(_assets, assetWidgets);

    // display FPS
    assetWidgets.add(Positioned(
      left: ScreenUtil.blockSizeWidth*5,
      bottom: ScreenUtil.blockSizeHeight*90,
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

  void _drawHitboxes(List<Asset> assets, List<Widget> assetWidgets) {
    for(var a in assets) {
      if(a is PhysicalAsset) {
        assetWidgets.add(Box(
          posX: a.posX,
          posY: a.posY,
          width: a.hitboxX,
          height: a.hitboxY,
          color: Colors.redAccent,
        ));
      }
    }
  }

  void _drawHurtboxes(List<Asset> assets, List<Widget> assetWidgets) {
    for(var asset in assets) {
      if(asset is Fighter) {
        Fighter a = asset;
        assetWidgets.add(Box( // basic attack
          posX: a.posX + a.hurtBasicOffsetX,
          posY: a.posY + a.hurtBasicOffsetY,
          width: a.hurtBasicX,
          height: a.hurtBasicY,
          color: Colors.blueAccent,
        ));
        assetWidgets.add(Box( // smash attack
          posX: a.posX + a.hurtSmashOffsetX,
          posY: a.posY + a.hurtSmashOffsetY,
          width: a.hurtSmashX,
          height: a.hurtSmashY,
          color: Colors.blueAccent,
        ));
      }
    }
  }
}

class Box extends StatelessWidget {
  final double _posX;
  final double _posY;
  final double _width;
  final double _height;
  final MaterialAccentColor _color;

  Box({
    @required double posX,
    @required double posY,
    @required double width,
    @required double height,
    @required MaterialAccentColor color
  }) : this._posX = ScreenUtil.blockSizeWidth*posX,
       this._posY = ScreenUtil.blockSizeHeight*posY,
       this._width = ScreenUtil.blockSizeWidth*width,
       this._height = ScreenUtil.blockSizeHeight*height,
       this._color = color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _posX - _width/2,
      bottom: _posY - _height/2,
      child: Container(
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          border: Border.all(color: _color)
        ),
      ),
    );
  }
}
