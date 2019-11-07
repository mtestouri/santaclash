import 'package:smashlike/arena_engine/asset.dart';
import 'package:smashlike/arena_engine/scale.dart';

class Platform extends Asset {
  Platform(double posX, double posY) {
    // physical properties
    this.state.type = 0; // dynamic type
    this.state.gravity = false;
    // position
    this.state.posX = posX;
    this.state.posY = posY;
    // image file
    this.state.imageFile = 'lib/assets/images/platform.png';
    // dimensions
    this.state.imageWidth = Scale.blockSizeWidth*100;
    this.state.imageHeight = Scale.blockSizeHeight*100;
    this.state.hitboxX = this.state.imageWidth;
    this.state.hitboxY = this.state.imageHeight;
  }
}