import 'package:smashlike/smash_engine/asset.dart';

abstract class Fighter extends PhysicalAsset {
  // physical properties
  int type = PhysicalAsset.DYNAMIC;
  bool gravity = true;
  // motion
  static const int RIGHT = 0;
  static const int LEFT = 1;
  int orientation = RIGHT;
  bool isMoving = false;
  // combat
  double damage = 0;
  double ultimate = 0;
  // basic attack hurtboxe
  double _hurtBasicOffsetX = 0;
  double hurtBasicOffsetY = 0;
  double hurtBasicX = 0;
  double hurtBasicY = 0;
  double get hurtBasicOffsetX {
    if(orientation == LEFT)
      return -1*_hurtBasicOffsetX;
    return _hurtBasicOffsetX;
  }
  double get hurtBasicLeft => (posX + hurtBasicOffsetX - hurtBasicX/2);
  double get hurtBasicRight => (posX + hurtBasicOffsetX + hurtBasicX/2);
  double get hurtBasicTop => (posY + hurtBasicOffsetY + hurtBasicY/2);
  double get hurtBasicBottom => (posY + hurtBasicOffsetY - hurtBasicY/2);
  // smash attack hurtboxe
  double _hurtSmashOffsetX = 0;
  double hurtSmashOffsetY = 0;
  double hurtSmashX = 0;
  double hurtSmashY = 0;
  double get hurtSmashOffsetX {
    if(orientation == LEFT)
      return -1*_hurtSmashOffsetX;
    return _hurtSmashOffsetX;
  }
  double get hurtSmashLeft => (posX + hurtSmashOffsetX - hurtSmashX/2);
  double get hurtSmashRight => (posX + hurtSmashOffsetX + hurtSmashX/2);
  double get hurtSmashTop => (posY + hurtSmashOffsetY + hurtSmashY/2);
  double get hurtSmashBottom => (posY + hurtSmashOffsetY - hurtSmashY/2);
}

class SantaClaus extends Fighter {
  // sprites path
  String spritesPath = 'assets/images/fighters/santaclaus/';
  
  SantaClaus(double posX, double posY) {
    // visual properties
    this.imageFile = spritesPath + 'idle_r_1.png';
    imageWidth = 8;
    imageHeight = 17;
    this.posX = posX;
    this.posY = posY;
    // hitboxe
    hitboxX = 6;
    hitboxY = 11;
    // basic attack hurtboxe
    _hurtBasicOffsetX = 2;
    hurtBasicOffsetY = 0.25;
    hurtBasicX = 4;
    hurtBasicY = 4;
    // smash attack hurtboxe
    _hurtSmashOffsetX = 2;
    hurtSmashOffsetY = -2;
    hurtSmashX = 4;
    hurtSmashY = 4;
  }

  @override
  Map<String, Map<int, String>> animationsFactory() {
    Map<String, Map<int, String>> animationsMap = new Map();
    var framesMap;

    // idle left
    framesMap = {
      0:spritesPath + 'idle_l_1.png'
    };
    animationsMap["idle_left"] = framesMap;

    // idle right
    framesMap = {
      0:spritesPath + 'idle_r_1.png'
    };
    animationsMap["idle_right"] = framesMap;

    // move left
    framesMap = {
      0:spritesPath + 'move_l_1.png',
      5:spritesPath + 'move_l_2.png',
      10:spritesPath + 'move_l_3.png',
      15:spritesPath + 'move_l_4.png',
      20:spritesPath + 'move_l_5.png',
      25:spritesPath + 'move_l_6.png',
      30:spritesPath + 'move_l_7.png',
      35:spritesPath + 'move_l_8.png'
    };
    animationsMap["move_left"] = framesMap;
    
    // move right
    framesMap = {
      0:spritesPath + 'move_r_1.png',
      5:spritesPath + 'move_r_2.png',
      10:spritesPath + 'move_r_3.png',
      15:spritesPath + 'move_r_4.png',
      20:spritesPath + 'move_r_5.png',
      25:spritesPath + 'move_r_6.png',
      30:spritesPath + 'move_r_7.png',
      35:spritesPath + 'move_r_8.png'
    };
    animationsMap["move_right"] = framesMap;
    
    // jump left
    framesMap = {
      0:spritesPath + 'jump_l_1.png',
      5:spritesPath + 'jump_l_2.png',
      10:spritesPath + 'jump_l_3.png',
      15:spritesPath + 'jump_l_4.png',
      20:spritesPath + 'jump_l_5.png',
      25:spritesPath + 'jump_l_6.png'
    };
    animationsMap["jump_left"] = framesMap;
    
    // jump right
    framesMap = {
      0:spritesPath + 'jump_r_1.png',
      5:spritesPath + 'jump_r_2.png',
      10:spritesPath + 'jump_r_3.png',
      15:spritesPath + 'jump_r_4.png',
      20:spritesPath + 'jump_r_5.png',
      25:spritesPath + 'jump_r_6.png'
    };
    animationsMap["jump_right"] = framesMap;

    // attack left
    framesMap = {
      0:spritesPath + 'attack_l_1.png',
      5:spritesPath + 'attack_l_2.png',
      10:spritesPath + 'attack_l_3.png',
      15:spritesPath + 'attack_l_4.png',
      20:spritesPath + 'attack_l_5.png'
    };
    animationsMap["attack_left"] = framesMap;

    // attack right
    framesMap = {
      0:spritesPath + 'attack_r_1.png',
      5:spritesPath + 'attack_r_2.png',
      10:spritesPath + 'attack_r_3.png',
      15:spritesPath + 'attack_r_4.png',
      20:spritesPath + 'attack_r_5.png'
    };
    animationsMap["attack_right"] = framesMap;

    // smash attack left
    framesMap = {
      0:spritesPath + 'smash_attack_l_1.png',
      5:spritesPath + 'smash_attack_l_2.png',
      10:spritesPath + 'smash_attack_l_3.png',
      15:spritesPath + 'smash_attack_l_4.png',
      20:spritesPath + 'smash_attack_l_5.png',
      25:spritesPath + 'smash_attack_l_6.png',
      30:spritesPath + 'smash_attack_l_7.png',
      35:spritesPath + 'smash_attack_l_8.png',
      40:spritesPath + 'smash_attack_l_9.png'
    };
    animationsMap["smash_attack_left"] = framesMap;

    // smash attack right
    framesMap = {
      0:spritesPath + 'smash_attack_r_1.png',
      5:spritesPath + 'smash_attack_r_2.png',
      10:spritesPath + 'smash_attack_r_3.png',
      15:spritesPath + 'smash_attack_r_4.png',
      20:spritesPath + 'smash_attack_r_5.png',
      25:spritesPath + 'smash_attack_r_6.png',
      30:spritesPath + 'smash_attack_r_7.png',
      35:spritesPath + 'smash_attack_r_8.png',
      40:spritesPath + 'smash_attack_r_9.png'
    };
    animationsMap["smash_attack_right"] = framesMap;

    // block left
    framesMap = {
      0:spritesPath + 'block_l_1.png'
    };
    animationsMap["block_left"] = framesMap;

    // block right
    framesMap = {
      0:spritesPath + 'block_r_1.png'
    };
    animationsMap["block_right"] = framesMap;

    // fireball left
    framesMap = {
      0:spritesPath + 'fireball_l_1.png',
      5:spritesPath + 'fireball_l_2.png',
      10:spritesPath + 'fireball_l_3.png',
      15:spritesPath + 'fireball_l_4.png',
      20:spritesPath + 'fireball_l_5.png',
      25:spritesPath + 'fireball_l_6.png',
      30:spritesPath + 'fireball_l_7.png',
      35:spritesPath + 'fireball_l_8.png',
      40:spritesPath + 'fireball_l_9.png',
      45:spritesPath + 'fireball_l_10.png'
    };
    animationsMap["fireball_left"] = framesMap;

    // fireball right
    framesMap = {
      0:spritesPath + 'fireball_r_1.png',
      5:spritesPath + 'fireball_r_2.png',
      10:spritesPath + 'fireball_r_3.png',
      15:spritesPath + 'fireball_r_4.png',
      20:spritesPath + 'fireball_r_5.png',
      25:spritesPath + 'fireball_r_6.png',
      30:spritesPath + 'fireball_r_7.png',
      35:spritesPath + 'fireball_r_8.png',
      40:spritesPath + 'fireball_r_9.png',
      45:spritesPath + 'fireball_r_10.png'
    };
    animationsMap["fireball_right"] = framesMap;
  
    return animationsMap;
  }
}

class SantaClausFireball extends PhysicalAsset {
  SantaClausFireball(double posX, double posY, double velX, double velY) {
    // visual properties
    imageFile = 'assets/images/fighters/santaclaus/fireball.png';
    imageWidth = 2;
    imageHeight = 4;
    this.posX = posX;
    this.posY = posY;
    // physical properties
    type = PhysicalAsset.DYNAMIC;
    gravity = false;
    // velocities
    this.velX = velX;
    this.velY = velY;
    // hitbox
    hitboxX = 2;
    hitboxY = 4;
  }

  @override
  Map<String, Map<int, String>> animationsFactory() {
    return null;
  }
}