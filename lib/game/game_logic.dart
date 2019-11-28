import 'dart:collection';
import 'package:smashlike/game/assets/fighters_assets.dart';
import 'package:smashlike/game/game_assets.dart';
import 'package:smashlike/smash_engine/asset.dart';
import 'package:smashlike/smash_engine/physics.dart';
import 'package:smashlike/smash_engine/smash_engine.dart';

// TODO
// improve animation system and action and fix animations timing
// add opponent
// game logic
// update inputs
// bluetooth or AI

class SmashLikeLogic extends GameLogic {
  Physics _physics = Physics();

  @override
  void update(Queue<String> inputs, GameAssets gameAssets) {
    SmashLikeAssets assets = gameAssets;
    List<PhysicalAsset> physicalAssets = assets.physicalAssets;
    Fighter player = assets.player;

    while(inputs.length > 0) {
      switch(inputs.removeFirst()) {
        case "press_left_start": {
          player.orientation = Fighter.LEFT;
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
          player.orientation = Fighter.RIGHT;
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
          if(player.orientation == Fighter.LEFT)
            player.startAnimation("jump_left");
          else
            player.startAnimation("jump_right");
        }
        break;

        case "press_a": {
          if(player.orientation == Fighter.LEFT)
            player.startAnimation("attack_left");
          else
            player.startAnimation("attack_right");  
        }
        break;

        case "long_press_a": {
          if(player.orientation == Fighter.LEFT)
            player.startAnimation("smash_attack_left");
          else
            player.startAnimation("smash_attack_right");  
        }
        break;
        
        case "press_b_start": {
          if(player.orientation == Fighter.LEFT)
            player.startAnimation("block_left");
          else
            player.startAnimation("block_right");  
        }
        break;

        case "press_b_end": {
          if(player.orientation == Fighter.LEFT)
            player.startAnimation("idle_left");
          else
            player.startAnimation("idle_right");
        }
        break;
        
        case "press_fireball":
          assets.physicalAssets.add(player.launchFireball());
        break;

        default:
          break;
      }
    }
  }
}