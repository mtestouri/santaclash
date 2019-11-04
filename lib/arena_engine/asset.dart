import 'package:flutter/material.dart';

class Asset extends StatefulWidget {
  @override
  AssetState createState() => AssetState();
}

class AssetState extends State<Asset> {
  int type = 0; // dynamic or static
  bool gravity = true;
  double velocityX = 0;
  double velocityY = 0;
  int posX = 0;
  int posY = 0;
  int hitboxX = 0;
  int hitboxY = 0;

  String imageFile = '';
  double imageHeight = 0;
  double imageWidth = 0;

  void render() {
    //call setstates
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment(0.5, 0.5),
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

class Fighter extends Asset {
  
}