import 'package:flutter/material.dart';
import 'package:smashlike/arena_engine/scale.dart';

class Asset extends StatefulWidget {
  final AssetState state = AssetState();

  @override
  AssetState createState() => state;
}

class AssetState extends State<Asset> {
  // physical properties
  int type = 0; // static or dynamic
  bool gravity = false;
  // position and velocity
  double velocityX = 0;
  double velocityY = 0;
  double posX = 0;
  double posY = 0;
  double hitboxX = 0;
  double hitboxY = 0;
  // image file
  String imageFile = '';
  double imageHeight = 0;
  double imageWidth = 0;

  void render() {
    setState(() {
      // update pos ?
      // update image dimension
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned( // TODO check
        bottom: Scale.blockSizeHeight*posY - imageHeight/2,
        left: Scale.blockSizeWidth*posX - imageWidth/2,
        child: Container(
            child: Image.asset(
              imageFile,
              height: imageHeight,
              width: imageWidth,
            ),
        ),
    );
  }
}
