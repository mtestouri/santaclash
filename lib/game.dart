import 'package:flutter/material.dart';
import 'package:smashlike/game/factory.dart';
import 'package:smashlike/game/map_1.dart';
import 'package:smashlike/game/map_2.dart';
import 'package:smashlike/game/game_logic.dart';
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
          inputGestures: InputGesturesMap2.build("debug"),
          assets: AssetsMap2.build("debug"),
          gameLogic: SmashLike(),
        ),
      ),
    );
  }
}