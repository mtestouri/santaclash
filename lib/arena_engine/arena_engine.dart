import 'package:flutter/material.dart';
import 'package:smashlike/arena_engine/asset.dart';
import 'package:smashlike/arena_engine/arena.dart';

class ArenaEngine extends StatelessWidget {
  bool _isRunning;
  Arena arena;

  ArenaEngine(Arena arena) {
    this._isRunning = false;
    this.arena = arena;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: arena,
      ),
    );
  }

  // Game loop
  void run() {
    _isRunning = true;
    while(_isRunning) {
      update();
      render();
    }
  }

  void stop() {
    _isRunning = false;
    // reset arena
  }

  void update() {
    // read inputs
    // game logic update
    // engine update
  }

  void render() {
    // rebuild the widgets
  }
}
