import 'dart:collection';
import 'package:smashlike/game/assets.dart';
import 'package:smashlike/smash_engine/asset.dart';
import 'package:smashlike/smash_engine/physics.dart';
import 'package:smashlike/smash_engine/smash_engine.dart';

class SmashLike extends GameLogic {
  Physics _physics = Physics();

  // 1. read apply inputs
  // 2. game updates

  @override
  void update(Queue<String> inputs, List<Asset> assets) {
    Player player = assets.singleWhere((asset) => asset is Player);

    // TODO might change
    List<PhysicalAsset> physicalAssets = new List();
    for(var asset in assets) {
      if(asset is PhysicalAsset)
        physicalAssets.add(asset);
    }

    while(inputs.length > 0) {
      switch(inputs.removeFirst()) {
        case "press_left_start": {
          player.orientation = Player.LEFT;
          player.velX = -20;
          player.isMoving = true;
          if(_physics.isOnGround(player, physicalAssets))
            player.startAnimation("move_left", repeat: true);
          else
            player.startAnimation("jump_left", repeat: true);
        }
        break;

        case "press_left_end": {
          player.velX = 0;
          player.isMoving = false;
          player.startAnimation("idle_left");
        }
        break;

        case "press_right_start": {
          player.orientation = Player.RIGHT;
          player.velX = 20;
          player.isMoving = true;
          if(_physics.isOnGround(player, physicalAssets))
            player.startAnimation("move_right", repeat: true);
          else
            player.startAnimation("jump_right", repeat: true);
        }
        break;

        case "press_right_end": {
          player.velX = 0;
          player.isMoving = false;
          player.startAnimation("idle_right");
        }
        break;

        case "press_up": {
          player.velY += 50;
          if(player.orientation == Player.LEFT)
            player.startAnimation("jump_left");
          else
            player.startAnimation("jump_right");
        }
        break;

        case "press_a": {
          if(player.orientation == Player.LEFT)
            player.startAnimation("attack_left");
          else
            player.startAnimation("attack_right");  
        }
        break;

        case "long_press_a": {
          if(player.orientation == Player.LEFT)
            player.startAnimation("smash_attack_left");
          else
            player.startAnimation("smash_attack_right");  
        }
        break;
        
        case "press_b_start": {
          if(player.orientation == Player.LEFT)
            player.startAnimation("block_left");
          else
            player.startAnimation("block_right");  
        }
        break;

        case "press_b_end": {
          if(player.orientation == Player.LEFT)
            player.startAnimation("idle_left");
          else
            player.startAnimation("idle_right");
        }
        break;
        
        case "press_fireball": {
          // TODO wait for animation
          if(player.orientation == Player.LEFT) {
            player.startAnimation("fireball_left");
            assets.add(Fireball(player.posX - 1, player.posY, -20, 0));
          }
          else {
            player.startAnimation("fireball_right");
            assets.add(Fireball(player.posX + 1, player.posY, 20, 0));
          }
        }
        break;

        default: { 
          // nothing for now
        }
        break;
      }
    }
  }
}