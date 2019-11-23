import 'package:smashlike/game/inputs_gestures.dart';
import 'package:smashlike/smash_engine/asset.dart';
import 'package:smashlike/smash_engine/gesture.dart';
import 'package:smashlike/game/assets.dart';

class AssetsFactory {
  static List<Asset> build(String assetsId) {
    switch(assetsId) {
      case "debug":
        return debug();
      default:
        return List();
    }
  }

  static List<Asset> debug() {
    List<Asset> assets = List();
    
    assets.add(Player(50,50));
    assets.add(Platform(50,15));
    return assets;
  }
}

class InputGesturesFactory {
  static List<InputGesture> build(String inputGesturesId) {
    switch(inputGesturesId) {
      case "debug":
        return debug();
      default:
        return List();
    }
  }

  static List<InputGesture>  debug() {
    List<InputGesture> inputGestures = List();
    inputGestures.add(ButtonLeft());
    inputGestures.add(ButtonRight());
    inputGestures.add(ButtonUp());
    inputGestures.add(ButtonA());
    inputGestures.add(ButtonB());
    inputGestures.add(ButtonFireball());
    return inputGestures;
  }
}
