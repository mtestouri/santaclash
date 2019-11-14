import 'package:smashlike/smash_engine/asset.dart';
import 'package:smashlike/assets/player.dart';
import 'package:smashlike/assets/platform.dart';

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
    assets.add(Platform(50,10));
    return assets;
  }
}
