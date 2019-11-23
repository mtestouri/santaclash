import 'dart:collection';
import 'package:smashlike/game/assets.dart';
import 'package:smashlike/smash_engine/asset.dart';
import 'package:smashlike/smash_engine/smash_engine.dart';

class SmashLike extends GameLogic {
  String playerOrientation = "right";

  @override
  void update(Queue<String> inputs, List<Asset> assets) {
    Player player = assets.singleWhere((asset) => asset is Player);

    while(inputs.length > 0) {
      switch(inputs.removeFirst()) {
        case "press_left_start": {
          playerOrientation = "left";
          player.velX = -20;
          player.startAnimation("move_left", repeat: true);
        }
        break;

        case "press_left_end": {
          player.velX = 0;
          player.startAnimation("idle_left");
        }
        break;

        case "press_right_start": {
          playerOrientation = "right";
          player.velX = 20;
          player.startAnimation("move_right", repeat: true);
        }
        break;

        case "press_right_end": {
          player.velX = 0;
          player.startAnimation("idle_right");
        }
        break;

        case "press_up": {
          player.velY += 50;
          if(playerOrientation == "left")
            player.startAnimation("jump_left");
          else
            player.startAnimation("jump_right");  
        }
        break;

        case "press_a": {
          if(playerOrientation == "left")
            player.startAnimation("attack_left");
          else
            player.startAnimation("attack_right");  
        }
        break;

        case "long_press_a": {
          if(playerOrientation == "left")
            player.startAnimation("smash_attack_left");
          else
            player.startAnimation("smash_attack_right");  
        }
        break;
        
        case "press_b_start": {
          if(playerOrientation == "left")
            player.startAnimation("block_left");
          else
            player.startAnimation("block_right");  
        }
        break;

        case "press_b_end": {
          if(playerOrientation == "left")
            player.startAnimation("idle_left");
          else
            player.startAnimation("idle_right");  
        }
        break;
        
        case "press_fireball": {
          if(playerOrientation == "left")
            player.startAnimation("fireball_left");
          else
            player.startAnimation("fireball_right");  
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