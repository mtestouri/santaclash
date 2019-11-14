import 'package:smashlike/smash_engine/asset.dart';
import 'package:smashlike/smash_engine/screen_util.dart';

class Player extends Asset {
  double damage = 0;
  double ultimate = 0;

  Player(double initPosX, double initPosY) {
    // physical properties
    type = 1; // dynamic type
    gravity = true;
    // position
    posX = initPosX;
    posY = initPosY;
    // image file
    imageFile = 'assets/images/player.png';
    // dimensions
    imageWidth = ScreenUtil.blockSizeWidth*100;
    imageHeight = ScreenUtil.blockSizeHeight*10;
    hitboxX = imageWidth; // TODO the hitbox should be slightly smaller than the image
    hitboxY = imageHeight;
  }
}
