import 'package:smashlike/game/fighters_assets.dart';
import 'package:smashlike/game/inputs_gestures.dart';
import 'package:smashlike/game/ui_assets.dart';
import 'package:smashlike/smash_engine/asset.dart';
import 'package:smashlike/smash_engine/gesture.dart';
import 'package:smashlike/game/arenas_assets.dart';

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
    String arenaPath = 'assets/images/arenas/debug/';
    List<Asset> assets = List();
    // background
    assets.add(Background(arenaPath + 'background.png'));
    // invisible walls
    assets.add(ArenaObject('', 1, 100, 1, 100, 0, 50));
    assets.add(ArenaObject('', 1, 100, 1, 100, 100, 50));
    assets.add(ArenaObject('', 100, 1, 100, 1, 50, 100));
    // arena objects
    assets.add(ArenaObject(arenaPath + 'base.png', 100, 30, 100, 30, 50, 15));
    assets.add(ArenaObject(arenaPath + 'air_platform.png', 15, 14, 12, 11, 50, 50));
    assets.add(ArenaObject(arenaPath + 'rock.png', 8, 11, 6, 9, 28, 32));
    // fighters
    Fighter santaclaus = SantaClaus(Fighter.PLAYER, 10, 50);
    assets.add(santaclaus);
    // ui
    assets.add(DamageIndicator(santaclaus, 18, 90));
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
