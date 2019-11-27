import 'package:smashlike/smash_engine/asset.dart';

class ArenaObject extends PhysicalAsset {
  ArenaObject(String image, double width, double height,
           double hitboxX, double hitboxY, double posX, double posY) {
    // visual properties
    this.imageFile = image;
    this.imageWidth = width;
    this.imageHeight = height;
    this.posX = posX;
    this.posY = posY;
    // hitbox
    this.hitboxX = hitboxX;
    this.hitboxY = hitboxY;
  }

  @override
  Map<String, Map<int, String>> animationsFactory() {
    return null;
  }
}

class Background extends Asset {
  Background(String image) {
    // visual propertie
    imageFile = image;
    imageWidth = 100;
    imageHeight = 100;
    posX = 50;
    posY = 50;
  }

  @override
  Map<String, Map<int, String>> animationsFactory() {
    return null;
  }
}