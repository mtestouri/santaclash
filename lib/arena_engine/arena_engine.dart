import 'package:flutter/material.dart';
import 'package:smashlike/arena_engine/scale.dart';
import 'package:smashlike/arena_engine/arena.dart';
import 'package:smashlike/arena_engine/asset.dart';

class ArenaEngine {
  bool _isRunning = false;
  Arena _arena;

  // Game loop
  void run(Arena arena) {
    this._arena = arena;
    this._isRunning = true;
    while(_isRunning) {
      _update();
      _render();
    }
  }

  void stop() {
    _isRunning = false;
    // reset arena
  }

  void _update() {
    // read inputs
    // game logic update
    // engine update
  }

  void _render() {
    // rebuild the widgets
  }

  Widget widgetDisplay() {
    return Scaffold(
      body: Container(
          height: Scale.screenHeight, // TODO check scaling init
          width: Scale.screenWidth,
          child: _arena,
      ),
    );
  }
}
