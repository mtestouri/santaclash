import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'package:smashlike/game/assets/fighters_assets.dart';
import 'package:smashlike/game/game_assets.dart';
import 'package:smashlike/game/multiplayer/multiplayer.dart';
import 'package:smashlike/menu/endscreen.dart';
import 'package:smashlike/smash_engine/asset.dart';
import 'package:smashlike/smash_engine/smash_engine.dart';

// TODO
// Check mulitplayer start fail

// stunt when hit (use animation)
// further improve animation and action system (quicker blocking)
// ui life, out of border

// bluetooth (sync)
// check blocking with attacks
// adjust animations timing and other parameters (hitboxes, hurtboxes, ...)
// restructure menus & clean code
// private variables and functions

class SmashLikeLogic extends GameLogic {
  Multiplayer multiplayer = Multiplayer();

  @override
  Future<int> update(Queue<String> inputs, GameAssets gameAssets) async {
    // check connection failure
    if(await multiplayer.isConnected == false) {
      endGameScreen = EndScreen(status: EndScreen.CONNECTION_LOST);
      return GameLogic.FINISHED;
    }
    
    // extract the assets
    SmashLikeAssets assets = gameAssets;
    Fighter player = assets.player;
    Fighter opponent = assets.opponent;
    List<Fireball> fireballs = assets.fireballs;
  
    // player inputs
    if(inputs.length > 0) {
      switch(inputs.removeFirst()) { // one input per frame
        case "press_left_start": {
          player.move(Fighter.LEFT);
          multiplayer.send(Multiplayer.LEFT_START);
        }
        break;

        case "press_left_end": {
          player.stopMove();
          multiplayer.send(Multiplayer.LEFT_END);
        }
        break;

        case "press_right_start": {
          player.move(Fighter.RIGHT);
          multiplayer.send(Multiplayer.RIGHT_START);
        }
        break;

        case "press_right_end": {
          player.stopMove();
          multiplayer.send(Multiplayer.RIGHT_END);
        }
        break;

        case "press_up": {
          player.jump(); 
          multiplayer.send(Multiplayer.UP);
        }
        break;

        case "press_a": {
          player.basicAttack();
          multiplayer.send(Multiplayer.A);
        }
        break;

        case "long_press_a": {
          player.smashAttack();
          multiplayer.send(Multiplayer.LONG_A);
        }
        break;
        
        case "press_b_start": {
          player.block();
          multiplayer.send(Multiplayer.B_START);
        }
        break;

        case "press_b_end": {
          player.stopBlock();
          multiplayer.send(Multiplayer.B_END);
        }
        break;
        
        case "press_fireball": {
          player.fireball();
          multiplayer.send(Multiplayer.FIREBALL);
        }
        break;

        default:
          multiplayer.send(Multiplayer.NONE);
        break;
      }
    }
    else
      multiplayer.send(Multiplayer.NONE);

    // opponent inputs
    switch(await multiplayer.receive()) {
      case Multiplayer.LEFT_START:
        opponent.move(Fighter.LEFT);
      break;

      case Multiplayer.LEFT_END:
        opponent.stopMove();
      break;

      case Multiplayer.RIGHT_START:
        opponent.move(Fighter.RIGHT);
      break;

      case Multiplayer.RIGHT_END:
        opponent.stopMove();
      break;

      case Multiplayer.UP:
        opponent.jump(); 
      break;

      case Multiplayer.A:
        opponent.basicAttack();
      break;

      case Multiplayer.LONG_A:
        opponent.smashAttack();
      break;
        
      case Multiplayer.B_START:
        opponent.block();
      break;

      case Multiplayer.B_END:
        opponent.stopBlock();
      break;
        
      case Multiplayer.FIREBALL:
        opponent.fireball();
      break;
    }

    // basic attacks
    if(checkHurtBasic(player, opponent) && (opponent.damage < 100)) {
      opponent.damage += 0.1;
      opponent.hit();
    }
    if(checkHurtBasic(opponent, player) && (player.damage < 100)) {
      player.damage += 0.1;
      player.hit();
    }
    
    // smash attacks
    bool ejectOpponent = checkHurtSmash(player, opponent);
    bool ejectPlayer = checkHurtSmash(opponent, player);
    if(ejectPlayer){
      player.eject();
      ejectFighter(player, opponent.orientation, 3, 8);
    }
    if(ejectOpponent){
      opponent.eject();
      ejectFighter(opponent, player.orientation, 3, 8);
    }

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
        player.hit();
        if(player.damage < 100) {
          player.damage += 5;
        }
        fireball.velX = 0;
        continue;
      }
      if(checkHurtFireball(opponent, fireball)) {
        opponent.hit();
        if(opponent.damage < 100) {
          opponent.damage += 5;
        }
        fireball.velX = 0;
      }
    }

    if(outOfLimits(player)) {
      player.posX = player.respawnPosX;
      player.posY = player.respawnPosY;
      player.velX = 0;
      player.velY = 0;
      player.damage = 0;
      player.lifes--;
      if(player.lifes == 0) {
        endGameScreen = EndScreen(status: EndScreen.DEFEAT);
        return GameLogic.FINISHED;
      }
    }
    if(outOfLimits(opponent)) {
      opponent.posX = opponent.respawnPosX;
      opponent.posY = opponent.respawnPosY;
      opponent.velX = 0;
      opponent.velY = 0;
      opponent.damage = 0;
      opponent.lifes--;
      if(opponent.lifes == 0) {
        endGameScreen = EndScreen(status: EndScreen.VICTORY);
        return GameLogic.FINISHED;
      }
    }
    
    return GameLogic.ON_GOING;
  }
}

bool outOfLimits (Fighter fighter){
  if(fighter.posX < -10 || fighter.posX > 110 || fighter.posY < -8)
    return true;
  return false;
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