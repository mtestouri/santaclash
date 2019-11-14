import 'package:smashlike/smash_engine/asset.dart';
import 'package:smashlike/smash_engine/screen_util.dart';

class Platform extends Asset {
  Platform(double posX, double posY) {
    // position
    this.posX = posX;
    this.posY = posY;
    // image file
    imageFile = 'assets/images/platform.png';
    // dimensions
    imageWidth = ScreenUtil.blockSizeWidth*50;
    imageHeight = ScreenUtil.blockSizeHeight*100;
    hitboxX = imageWidth;
    hitboxY = imageHeight;
  }
}