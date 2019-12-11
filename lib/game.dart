import 'package:flutter/material.dart';
import 'package:smashlike/game/game_assets.dart';
import 'package:smashlike/game/game_logic.dart';
import 'package:smashlike/game/inputs_gestures.dart';
import 'package:smashlike/smash_engine/smash_engine.dart';
import 'package:smashlike/smash_engine/screen_util.dart';

class Game extends StatelessWidget {
  final int playerId;
  final int mapId;
  final int side;
  static const int LEFT = 0;
  static const int RIGHT = 1;

  Game({@required this.playerId, @required this.mapId,@required this.side});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenUtil.screenHeight,
        width: ScreenUtil.screenWidth,
        child: SmashEngine(
          inputGestures: InputGesturesFactory.build("debug"),
          assets: GameAssetsFactory.build(mapId, playerId, side),
          gameLogic: SmashLikeLogic(),
        ),
      ),
    );
  }
}