import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ScreenUtil {
  static double screenHeight;
  static double screenWidth;
  static double blockSizeHeight;
  static double blockSizeWidth;

  static void init(BuildContext context, {String screenOrientation}) {
    if((screenOrientation != null) && (screenOrientation == "landscape")) {
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

  static void setScreenOrientation(String screenOrientation) {
    if(screenOrientation == "landscape") {
      SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      ]);
    }
    if(screenOrientation == "portrait") {
      SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
      ]);
    }
  }

  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}