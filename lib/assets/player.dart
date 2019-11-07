import 'package:smashlike/arena_engine/asset.dart';
import 'package:smashlike/arena_engine/scale.dart';

class Player extends Asset {
  Player(double initPosX, double initPosY) {
    // physical properties
    this.state.type = 1; // dynamic type
    this.state.gravity = true;
    // position and velocity
    this.state.velocityX = 0;
    this.state.velocityY = 0;
    this.state.posX = initPosX;
    this.state.posY = initPosY;
    // image file
    this.state.imageFile = 'lib/assets/images/player.png';
    // dimensions
    this.state.imageWidth = Scale.blockSizeHeight*10;
    this.state.imageHeight = Scale.blockSizeHeight*20; // TODO check singleton
    this.state.hitboxX = this.state.imageWidth; // TODO the hitbox should be slightly smaller than the image
    this.state.hitboxY = this.state.imageHeight;
  }
}

class PlayerState extends AssetState {
  
}