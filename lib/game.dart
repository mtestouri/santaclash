import 'package:flutter/material.dart';
import 'package:smashlike/arena_engine/arena_engine.dart';
import 'package:smashlike/arena_engine/arena.dart';

class Game extends StatelessWidget { // TODO might be stateful
  ArenaEngine arenaEngine;

  Game() {
    this.arenaEngine = new ArenaEngine(new DebugArena());
  }

  @override
  Widget build(BuildContext context) {
    return arenaEngine;
  }

  void play() {
    arenaEngine.run();
  }
}