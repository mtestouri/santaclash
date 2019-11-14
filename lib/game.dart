import 'package:flutter/material.dart';
import 'package:smashlike/assets/assets_factory.dart';
import 'package:smashlike/smash_engine/smash_engine.dart';
import 'package:smashlike/smash_engine/screen_util.dart';

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenUtil.screenHeight, // TODO check singleton
        width: ScreenUtil.screenWidth,
        child: SmashEngine(
          assets: AssetsFactory.build("debug"),
        ),
      ),
    );
  }
}