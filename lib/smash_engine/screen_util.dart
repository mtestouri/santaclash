import 'package:flutter/widgets.dart';

class ScreenUtil { // TODO put rotations of screen here
  static double screenHeight;
  static double screenWidth;
  static double blockSizeHeight;
  static double blockSizeWidth;

  void init(BuildContext context, String mode) {
    if(mode == "landscape") {
      screenHeight = MediaQuery.of(context).size.height;
      screenWidth = MediaQuery.of(context).size.width;
      blockSizeHeight = screenHeight/100;
      blockSizeWidth = screenWidth/100;
    }
    else {
      screenHeight = MediaQuery.of(context).size.width;
      screenWidth = MediaQuery.of(context).size.height;
      blockSizeHeight = screenWidth/100;
      blockSizeWidth = screenHeight/100;
    }
  }
}