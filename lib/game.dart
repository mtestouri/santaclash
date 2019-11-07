import 'package:flutter/material.dart';
import 'package:smashlike/arena_engine/arena_engine.dart';
import 'package:smashlike/assets/arena_factory.dart';

class Game extends StatelessWidget {
  final ArenaEngine _arenaEngine = new ArenaEngine();

  @override
  Widget build(BuildContext context) {
    return _arenaEngine.widgetDisplay();
  }

  void play() {
    _arenaEngine.run(ArenaFactory().build("debug"));
  }
}