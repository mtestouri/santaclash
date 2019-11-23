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
    // invisible walls
    assets.add(Platform('', 1, 100, 1, 100, 0, 50));
    assets.add(Platform('', 1, 100, 1, 100, 100, 50));
    assets.add(Platform('', 100, 1, 100, 1, 50, 100));
    // assets
    assets.add(Background('assets/images/background.png'));
    assets.add(Platform('assets/images/base.png', 100, 30, 100, 30, 50, 15));
    assets.add(Platform('assets/images/air_platform.png', 15, 14, 12, 11, 50, 50));
    assets.add(Platform('assets/images/rock.png', 8, 11, 6, 9, 28, 32));
    assets.add(Player(10,50));
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
