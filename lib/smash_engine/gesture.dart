import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/smash_engine.dart';

class Gesture extends StatelessWidget {
  final List<InputGesture> _inputGestures;

  Gesture({List<InputGesture> inputGestures})
    : this._inputGestures = inputGestures;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _inputGestures,
    );
  }
}

abstract class InputGesture extends StatelessWidget {
  void pushInput(BuildContext context, Input input) {
    SmashEngine.of(context).inputs.add(input);
  }
}

class Input {
  String id;
  String action;
  Input(this.id, this.action);
}