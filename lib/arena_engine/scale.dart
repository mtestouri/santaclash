import 'package:flutter/widgets.dart';

class ScaleConfig {
  static double widthScaling;
  static double heightScaling;

  void init(BuildContext context) {
    widthScaling = MediaQuery.of(context).size.width/100;
    heightScaling = MediaQuery.of(context).size.height/100;
  }
}