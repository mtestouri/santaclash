import 'dart:collection';
import 'dart:math';
import 'package:smashlike/game/assets/fighters_assets.dart';
import 'package:smashlike/game/game_assets.dart';
import 'package:smashlike/smash_engine/asset.dart';
import 'package:smashlike/smash_engine/smash_engine.dart';

// TODO
// update inputs buttons
// check blocking with attacks
// stunt when hit
// further improve animation and action system (quicker blocking)
// adjust animations timing and other parameters (hitboxes, hurtboxes, ...)
// private variables and functions

class SmashLikeLogic extends GameLogic {
  @override
  void update(Queue<String> inputs, GameAssets gameAssets) {
    SmashLikeAssets assets = gameAssets;
    Fighter player = assets.player;
    Fighter opponent = assets.opponent;
    List<Fireball> fireballs = assets.fireballs;
  
    // player inputs
    while(inputs.length > 0) {
      switch(inputs.removeFirst()) {
        case "press_left_start":
          player.move(Fighter.LEFT);
        break;

        case "press_left_end":
          player.stopMove();
        break;

        case "press_right_start":
          player.move(Fighter.RIGHT);
        break;

        case "press_right_end":
          player.stopMove();
        break;

        case "press_up":
          player.jump(); 
        break;

        case "press_a":
          player.basicAttack();
        break;

        case "long_press_a":
          player.smashAttack();
        break;
        
        case "press_b_start":
          player.block();
        break;

        case "press_b_end":
          player.stopBlock();
        break;
        
        case "press_fireball":
          player.fireball();
        break;
      }
    }

    // opponent inputs
    // TODO bluetooth or AI   

    // basic attacks
    if(checkHurtBasic(player, opponent) && (opponent.damage < 100))
      opponent.damage += 0.1;
    if(checkHurtBasic(opponent, player) && (player.damage < 100))
      player.damage += 0.1;
    
    // smash attacks
    bool ejectOpponent = checkHurtSmash(player, opponent);
    bool ejectPlayer = checkHurtSmash(opponent, player);
    if(ejectPlayer)
      ejectFighter(player, opponent.orientation, 3, 8);
    if(ejectOpponent)
      ejectFighter(opponent, player.orientation, 3, 8);

    // remove useless fireballs
    fireballs.removeWhere((fireball) => fireball.velX == 0);
    // check fireballs ready to be launched
    if(player.fireballReady())
      fireballs.add(player.launchFireball());
    if(opponent.fireballReady())
      fireballs.add(opponent.launchFireball());
    // check fireballs hits
    for(Fireball fireball in fireballs) {
      if(checkHurtFireball(player, fireball)) {
        ejectFighter(player, fireball.direction, 20, 60);
        fireball.velX = 0;
        continue;
      }
      if(checkHurtFireball(opponent, fireball)) {
        ejectFighter(opponent, fireball.direction, 20, 60);
        fireball.velX = 0;
      }
    }

    // TODO check out of the arena limits
  }
}

bool checkHurtBasic(Fighter att, Fighter def) {
  return (max(att.hurtBasicLeft, def.hitboxLeft) 
  < min(att.hurtBasicRight, def.hitboxRight) 
  && max(att.hurtBasicBottom, def.hitboxBottom) 
  < min(att.hurtBasicTop, def.hitboxTop));
}

bool checkHurtSmash(Fighter att, Fighter def) {
  return (max(att.hurtSmashLeft, def.hitboxLeft) 
  < min(att.hurtSmashRight, def.hitboxRight) 
  && max(att.hurtSmashBottom, def.hitboxBottom) 
  < min(att.hurtSmashTop, def.hitboxTop));
}

bool checkHurtFireball(Fighter fighter, Fireball fireball) {
  return((fireball.id != fighter.id)
  && (max(fighter.hitboxLeft, fireball.hitboxLeft) 
  < min(fighter.hitboxRight, fireball.hitboxRight) 
  && max(fighter.hitboxBottom, fireball.hitboxBottom) 
  < min(fighter.hitboxTop, fireball.hitboxTop)));
}

void ejectFighter(Fighter fighter, int orientation, 
                  double intensityX, double intensityY) {
  if(orientation == Fighter.LEFT)
    fighter.velX -= intensityX*(fighter.damage/100);
  else
    fighter.velX += intensityX*(fighter.damage/100);
  fighter.velY += intensityY*(fighter.damage/100);
}