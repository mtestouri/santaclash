import 'package:flutter/cupertino.dart';
import 'package:smashlike/game/assets/arenas_assets.dart';
import 'package:smashlike/game/assets/fighters_assets.dart';
import 'package:smashlike/game/assets/ui_assets.dart';
import 'package:smashlike/smash_engine/asset.dart';

class GameAssetsFactory {
  static GameAssets build(String gameAssetsId) {
    switch(gameAssetsId) {
      case "debug":
        return debug();
      default:
        return debug();
    }
  }

  static GameAssets debug() {
    String arenaPath = 'assets/images/arenas/debug/';
    // background assets
    List<Asset> backgroundAssets = List();
    backgroundAssets.add(Background(arenaPath + 'background.png'));

    // physical assets
    List<PhysicalAsset> physicalAssets = List();
    // invisible walls
    physicalAssets.add(ArenaObject('', 1, 100, 1, 100, 0, 50));
    physicalAssets.add(ArenaObject('', 1, 100, 1, 100, 100, 50));
    physicalAssets.add(ArenaObject('', 100, 1, 100, 1, 50, 100));
    // arena objects
    physicalAssets.add(ArenaObject(arenaPath + 'base.png', 100, 30, 100, 30, 50, 15));
    physicalAssets.add(ArenaObject(arenaPath + 'air_platform.png', 15, 14, 12, 11, 50, 50));
    physicalAssets.add(ArenaObject(arenaPath + 'rock.png', 8, 11, 6, 9, 28, 32));
    
    // fighters
    Fighter player = SantaClaus(Fighter.PLAYER, 10, 50);
    physicalAssets.add(player);
    
    // ui
    List<Asset> ui = List();
    ui.add(DamageIndicator(player, 18, 90));
    
    return SmashLikeAssets(
      backgroundAssets: backgroundAssets,
      physicalAssets: physicalAssets,
      player: player,
      ui: ui,
      drawHitboxes: true
    );
  }
}

class SmashLikeAssets extends GameAssets {
  List<Asset> _backgroundAssets;
  List<PhysicalAsset> _physicalAssets;
  Fighter _player;
  //Fighter _opponent;
  List<Asset> _ui;
  bool _drawHitboxes = false;

  SmashLikeAssets({
    @required List<Asset> backgroundAssets,
    @required List<PhysicalAsset> physicalAssets,
    @required Fighter player,
    //@required Fighter opponent,
    @required List<Asset> ui,
    bool drawHitboxes,
  }) {
    this._backgroundAssets = backgroundAssets;
    this._physicalAssets = physicalAssets;
    this._player = player;
    //this._opponent = opponent;
    this._ui = ui;
    if(drawHitboxes != null)
      _drawHitboxes = drawHitboxes;
  }

  @override
  List<PhysicalAsset> get physicalAssets => _physicalAssets;
  Fighter get player => _player;  
  //Fighter get opponent => _opponent;
  set drawHitboxes(bool drawHitboxes) => _drawHitboxes = drawHitboxes;

  @override
  List<Asset> toAssetList() {
    // concatenate the different asset lists
    List<Asset> assets = List();
    assets += _backgroundAssets;
    assets += _physicalAssets;
    assets.add(player);
    assets += _ui;
    // draw hitboxes and hurtboxes
    if(_drawHitboxes) {
      for(var asset in _physicalAssets)
        assets.add(asset.drawHitbox());
      assets += player.drawHurtboxes();
      // hitboxes += opponent.drawHurtboxes();
    }
    return assets;
  }
}