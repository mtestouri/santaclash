import 'package:smashlike/game/fighters_assets.dart';
import 'package:smashlike/game/inputs_gestures.dart';
import 'package:smashlike/smash_engine/asset.dart';
import 'package:smashlike/smash_engine/gesture.dart';
import 'package:smashlike/game/arenas_assets.dart';

class AssetsMap2 {
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
    // invisible walls
    assets.add(ArenaObject('', 1, 100, 1, 100, 0, 50));
    assets.add(ArenaObject('', 1, 100, 1, 100, 100, 50));
    assets.add(ArenaObject('', 100, 1, 100, 1, 50, 100));
    // assets
    assets.add(Background(arenaPath + 'grassy_background.png'));
    assets.add(ArenaObject(arenaPath + 'water.png', 12, 15, 0, 0, 6, 7));
    assets.add(ArenaObject(arenaPath + 'big_g_stone.png', 12, 22, 11, 21, 18, 10));
    assets.add(ArenaObject(arenaPath + 'water.png', 12, 15, 0, 0, 30, 7));
    //assets.add(ArenaObject(arenaPath + 'full_g_ground.png', 52, 30, 51, 28, 62, 15));
    assets.add(ArenaObject(arenaPath + 'g_ground.png', 21, 16, 20, 14, 46, 7));
    assets.add(ArenaObject(arenaPath + 'g_slope.png', 14, 30, 0, 0, 63, 15));
    for (double i = 1; i < 15; i++){
      assets.add(ArenaObject('', 1, (13+i), 1, (13+i), (55.5+i), (7+(i/2))));
    }
    assets.add(ArenaObject(arenaPath + 'long_g_dirt.png', 18, 11, 16, 9, 2, 55));
    assets.add(ArenaObject(arenaPath + 'long_g_dirt.png', 18, 11, 16, 9, 49, 64));
    assets.add(ArenaObject(arenaPath + 'water.png', 14, 15, 0, 0, 93, 7));
    assets.add(ArenaObject(arenaPath + 'bolc_g_ground.png', 17, 30, 16, 28, 78, 14));
    assets.add(SantaClaus(50,90));
    return assets;
  }
}

class InputGesturesMap2 {
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