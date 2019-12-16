import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/asset.dart';
import 'package:smashlike/smash_engine/gesture.dart';
import 'package:smashlike/smash_engine/physics.dart';
import 'package:smashlike/smash_engine/renderer.dart';


class SmashEngine extends InheritedWidget {
  final Queue<String> inputs = new Queue();

  static SmashEngine of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(SmashEngine) as SmashEngine;
  }

  SmashEngine({
    @required List<InputGesture> inputGestures, 
    @required GameAssets assets,
    @required GameLogic gameLogic,
  })  : super(child : Stack(
        children : [
          Renderer(
            physics: Physics(),
            assets : assets, 
            gameLogic: gameLogic
          ),
          Gesture(inputGestures : inputGestures)
        ]));

  @override
  bool updateShouldNotify(SmashEngine old) => false;
}

abstract class GameLogic {
  // game status
  static const int ON_GOING = 0;
  static const int FINISHED = 1;
  
  // shown at the end of the game
  Widget endGameScreen = Container();

  // game logic update
  Future<int> update (Queue<String> inputs, GameAssets gameAssets);
}
