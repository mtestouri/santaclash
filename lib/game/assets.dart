import 'package:smashlike/smash_engine/renderer.dart';
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
    imageFile = 'assets/images/player.png';
    // dimensions
    imageWidth = ScreenUtil.blockSizeWidth*5;
    imageHeight = ScreenUtil.blockSizeHeight*14;
    hitboxX = 5;
    hitboxY = 12;
  }
}

class Platform extends PhysicalAsset {
  Platform(double posX, double posY) {
    // position
    this.posX = posX;
    this.posY = posY;
    // image file
    imageFile = 'assets/images/platform.png';
    // dimensions
    imageWidth = ScreenUtil.blockSizeWidth*100;
    imageHeight = ScreenUtil.blockSizeHeight*30;
    hitboxX = 100;
    hitboxY = 30;
  }
}