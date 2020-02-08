import 'package:flutter/material.dart';
import 'package:santaclash/game/game_assets.dart';
import 'package:santaclash/game/game_logic.dart';
import 'package:santaclash/game/inputs_gestures.dart';
import 'package:santaclash/smash_engine/smash_engine.dart';
import 'package:santaclash/smash_engine/screen_util.dart';

class Game extends StatelessWidget {
  final int playerId;
  final int mapId;
  final int side;
  final bool multiplayer;
  final bool drawHitboxes;

  Game({
    @required this.playerId, 
    @required this.mapId, 
    @required this.side,
    @required this.multiplayer,
    @required this.drawHitboxes
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenUtil.screenHeight,
        width: ScreenUtil.screenWidth,
        child: SmashEngine(
          inputGestures: InputGesturesFactory.build(0),
          assets: GameAssetsFactory.build(mapId, playerId, side, drawHitboxes),
          gameLogic: SmashLikeLogic(useMultiplayer: multiplayer),
        ),
      ),
    );
  }
}