import 'package:smashlike/smash_engine/asset.dart';
import 'package:smashlike/smash_engine/screen_util.dart';

class Player extends PhysicalAsset {
  double damage = 0;
  double ultimate = 0;

  Player(double initPosX, double initPosY) {
    // physical properties
    type = PhysicalAsset.DYNAMIC;
    gravity = true;
    // position
    posX = initPosX;
    posY = initPosY;
    // image file
    imageFile = 'assets/images/player/idle_r_1.png';
    // dimensions
    imageWidth = ScreenUtil.blockSizeWidth*8;
    imageHeight = ScreenUtil.blockSizeHeight*17;
    hitboxX = 6;
    hitboxY = 11;
  }

  @override
  Map<String, Map<int, String>> animationsFactory() {
    Map<String, Map<int, String>> animationsMap = new Map();
    var framesMap;

    // TODO directory value ?

    // idle left
    framesMap = {
      0:'assets/images/player/idle_l_1.png'
    };
    animationsMap["idle_left"] = framesMap;

    // idle right
    framesMap = {
      0:'assets/images/player/idle_r_1.png'
    };
    animationsMap["idle_right"] = framesMap;

    // move left
    framesMap = {
      0:'assets/images/player/move_l_1.png',
      5:'assets/images/player/move_l_2.png',
      10:'assets/images/player/move_l_3.png',
      15:'assets/images/player/move_l_4.png',
      20:'assets/images/player/move_l_5.png',
      25:'assets/images/player/move_l_6.png',
      30:'assets/images/player/move_l_7.png',
      35:'assets/images/player/move_l_8.png'
    };
    animationsMap["move_left"] = framesMap;
    
    // move right
    framesMap = {
      0:'assets/images/player/move_r_1.png',
      5:'assets/images/player/move_r_2.png',
      10:'assets/images/player/move_r_3.png',
      15:'assets/images/player/move_r_4.png',
      20:'assets/images/player/move_r_5.png',
      25:'assets/images/player/move_r_6.png',
      30:'assets/images/player/move_r_7.png',
      35:'assets/images/player/move_r_8.png'
    };
    animationsMap["move_right"] = framesMap;
    
    // jump left
    framesMap = {
      0:'assets/images/player/jump_l_1.png',
      5:'assets/images/player/jump_l_2.png',
      10:'assets/images/player/jump_l_3.png',
      15:'assets/images/player/jump_l_4.png',
      20:'assets/images/player/jump_l_5.png',
      25:'assets/images/player/jump_l_6.png'
    };
    animationsMap["jump_left"] = framesMap;
    
    // jump right
    framesMap = {
      0:'assets/images/player/jump_r_1.png',
      5:'assets/images/player/jump_r_2.png',
      10:'assets/images/player/jump_r_3.png',
      15:'assets/images/player/jump_r_4.png',
      20:'assets/images/player/jump_r_5.png',
      25:'assets/images/player/jump_r_6.png'
    };
    animationsMap["jump_right"] = framesMap;

    // attack left
    framesMap = {
      0:'assets/images/player/attack_l_1.png',
      5:'assets/images/player/attack_l_2.png',
      10:'assets/images/player/attack_l_3.png',
      15:'assets/images/player/attack_l_4.png',
      20:'assets/images/player/attack_l_5.png'
    };
    animationsMap["attack_left"] = framesMap;

    // attack right
    framesMap = {
      0:'assets/images/player/attack_r_1.png',
      5:'assets/images/player/attack_r_2.png',
      10:'assets/images/player/attack_r_3.png',
      15:'assets/images/player/attack_r_4.png',
      20:'assets/images/player/attack_r_5.png'
    };
    animationsMap["attack_right"] = framesMap;

    // smash attack left
    framesMap = {
      0:'assets/images/player/smash_attack_l_1.png',
      5:'assets/images/player/smash_attack_l_2.png',
      10:'assets/images/player/smash_attack_l_3.png',
      15:'assets/images/player/smash_attack_l_4.png',
      20:'assets/images/player/smash_attack_l_5.png',
      25:'assets/images/player/smash_attack_l_6.png',
      30:'assets/images/player/smash_attack_l_7.png',
      35:'assets/images/player/smash_attack_l_8.png',
      40:'assets/images/player/smash_attack_l_9.png'
    };
    animationsMap["smash_attack_left"] = framesMap;

    // smash attack right
    framesMap = {
      0:'assets/images/player/smash_attack_r_1.png',
      5:'assets/images/player/smash_attack_r_2.png',
      10:'assets/images/player/smash_attack_r_3.png',
      15:'assets/images/player/smash_attack_r_4.png',
      20:'assets/images/player/smash_attack_r_5.png',
      25:'assets/images/player/smash_attack_r_6.png',
      30:'assets/images/player/smash_attack_r_7.png',
      35:'assets/images/player/smash_attack_r_8.png',
      40:'assets/images/player/smash_attack_r_9.png'
    };
    animationsMap["smash_attack_right"] = framesMap;

    // block left
    framesMap = {
      0:'assets/images/player/block_l_1.png'
    };
    animationsMap["block_left"] = framesMap;

    // block right
    framesMap = {
      0:'assets/images/player/block_r_1.png'
    };
    animationsMap["block_right"] = framesMap;

    // fireball left
    framesMap = {
      0:'assets/images/player/fireball_l_1.png',
      5:'assets/images/player/fireball_l_2.png',
      10:'assets/images/player/fireball_l_3.png',
      15:'assets/images/player/fireball_l_4.png',
      20:'assets/images/player/fireball_l_5.png',
      25:'assets/images/player/fireball_l_6.png',
      30:'assets/images/player/fireball_l_7.png',
      35:'assets/images/player/fireball_l_8.png',
      40:'assets/images/player/fireball_l_9.png',
      45:'assets/images/player/fireball_l_10.png'
    };
    animationsMap["fireball_left"] = framesMap;

    // fireball right
    framesMap = {
      0:'assets/images/player/fireball_r_1.png',
      5:'assets/images/player/fireball_r_2.png',
      10:'assets/images/player/fireball_r_3.png',
      15:'assets/images/player/fireball_r_4.png',
      20:'assets/images/player/fireball_r_5.png',
      25:'assets/images/player/fireball_r_6.png',
      30:'assets/images/player/fireball_r_7.png',
      35:'assets/images/player/fireball_r_8.png',
      40:'assets/images/player/fireball_r_9.png',
      45:'assets/images/player/fireball_r_10.png'
    };
    animationsMap["fireball_right"] = framesMap;
  
    return animationsMap;
  }
}

class Platform extends PhysicalAsset {
  Platform(String image, double width, double height,
           double hitboxX, double hitboxY, double posX, double posY) {
    // image file
    this.imageFile = image;
    // dimensions
    this.imageWidth = ScreenUtil.blockSizeWidth*width;
    this.imageHeight = ScreenUtil.blockSizeHeight*height;
    this.hitboxX = hitboxX;
    this.hitboxY = hitboxY;
    // position
    this.posX = posX;
    this.posY = posY;
  }

  @override
  Map<String, Map<int, String>> animationsFactory() {
    return null;
  }
}

class Background extends Asset {
  Background(String image) {
    // image file
    imageFile = image;
    // dimensions
    imageWidth = ScreenUtil.blockSizeWidth*100;
    imageHeight = ScreenUtil.blockSizeHeight*100;
    // position
    posX = 50;
    posY = 50;
  }

  @override
  Map<String, Map<int, String>> animationsFactory() {
    return null;
  }
}