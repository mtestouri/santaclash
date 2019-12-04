import 'package:flutter/material.dart';
import 'package:smashlike/game/game_assets.dart';
import 'package:smashlike/game/game_logic.dart';
import 'package:smashlike/game/inputs_gestures.dart';
import 'package:smashlike/smash_engine/smash_engine.dart';
import 'package:smashlike/smash_engine/screen_util.dart';

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenUtil.screenHeight,
        width: ScreenUtil.screenWidth,
        child: SmashEngine(
          inputGestures: InputGesturesFactory.build("debug"),
          assets: GameAssetsFactory.build("debug"),
          gameLogic: SmashLikeLogic(),
        ),
      ),
    );
  }
}