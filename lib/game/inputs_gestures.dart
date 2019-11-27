import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/gesture.dart';
import 'package:smashlike/smash_engine/screen_util.dart';

class CircularButton extends StatelessWidget {
  final IconData iconData;
  final String text;

  CircularButton({this.iconData, @required this.text});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: ScreenUtil.blockSizeHeight*14,
      height: ScreenUtil.blockSizeHeight*14,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment(0.0, 0.0),
        children: [
          Icon(
            iconData,
            color: Colors.white,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class ButtonLeft extends InputGesture {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ScreenUtil.blockSizeHeight*7,
      left: ScreenUtil.blockSizeWidth*7,
      child: GestureDetector(
        onTapDown: (details) {
          this.pushInput(context, "press_left_start");
        },
        onTapCancel: () {
          this.pushInput(context, "press_left_end");
        },
        onTapUp: (details) {
          this.pushInput(context, "press_left_end");
        },
        child: CircularButton(iconData: Icons.arrow_back, text: ''),
      )
    );
  }
}

class ButtonRight extends InputGesture {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ScreenUtil.blockSizeHeight*7,
      left: ScreenUtil.blockSizeWidth*19,
      child: GestureDetector(
        onTapDown: (details) {
          this.pushInput(context, "press_right_start");
        },
        onTapCancel: () {
          this.pushInput(context, "press_right_end");
        },
        onTapUp: (details) {
          this.pushInput(context, "press_right_end");
        },
        child: CircularButton(iconData: Icons.arrow_forward, text: ''),
      )
    );
  }
}

class ButtonUp extends InputGesture {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ScreenUtil.blockSizeHeight*24,
      left: ScreenUtil.blockSizeWidth*80,
      child: GestureDetector(
        onTapDown: (details) {
          this.pushInput(context, "press_up");
        },
        child: CircularButton(iconData: Icons.arrow_upward, text: ''),
      )
    );
  }
}

class ButtonA extends InputGesture {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ScreenUtil.blockSizeHeight*7,
      left: ScreenUtil.blockSizeWidth*62,
      child: GestureDetector(
        onTapDown: (details) {
          this.pushInput(context, "press_a");
        },
        onLongPress: () {
          this.pushInput(context, "long_press_a");
        },
        child: CircularButton(text: "A")
      ),
    );
  }
}

class ButtonB extends InputGesture {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ScreenUtil.blockSizeHeight*7,
      left: ScreenUtil.blockSizeWidth*74,
      child: GestureDetector(
        onTapDown: (details) {
          this.pushInput(context, "press_b_start");
        },
        onTapCancel: () {
          this.pushInput(context, "press_b_end");
        },
        onTapUp: (details) {
          this.pushInput(context, "press_b_end");
        },
        child: CircularButton(text: "B")
      ),
    );
  }
}

class ButtonFireball extends InputGesture {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ScreenUtil.blockSizeHeight*7,
      left: ScreenUtil.blockSizeWidth*86,
      child: GestureDetector(
        onTapDown: (details) {
          this.pushInput(context, "press_fireball");
        },
        child: CircularButton(iconData: Icons.brightness_low, text: ''),
      ),
    );
  }
}
