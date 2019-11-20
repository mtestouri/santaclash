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
    imageWidth = ScreenUtil.blockSizeWidth*100;//ScreenUtil.screenWidth;
    imageHeight = ScreenUtil.blockSizeHeight*30;//ScreenUtil.screenHeight;
    hitboxX = imageWidth;
    hitboxY = imageHeight;
  }
}