import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/gesture.dart';
import 'package:smashlike/smash_engine/renderer.dart';


class SmashEngine extends InheritedWidget {
  final List<Input> inputs = new List();

  static SmashEngine of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(SmashEngine) as SmashEngine;
  }

  SmashEngine({@required List<InputGesture> inputGestures, 
               @required List<Asset> assets})
    : super(child : Stack(children : [
      Renderer(assets : assets),
      Gesture(inputGestures : inputGestures)
  ]));

  @override
  bool updateShouldNotify(SmashEngine old) => false;
}
