import 'package:smashlike/arena_engine/arena.dart';
import 'package:smashlike/arena_engine/asset.dart';
import 'package:smashlike/assets/player.dart';
import 'package:smashlike/assets/platform.dart';

class ArenaFactory {
  Arena build(String arenaId) {
    switch(arenaId) {
      case "debug":
        return debugArena();
      default:
        return defaultArena();
    }
  }

  Arena defaultArena() {
    return Arena(List());
  }

  Arena debugArena() {
    List<Asset> assets = new List();
    assets.add(Player(50,28));
    assets.add(Platform(50,10));
    return Arena(assets);
  }
}
