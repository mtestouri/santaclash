import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/gesture.dart';
import 'package:smashlike/smash_engine/screen_util.dart';

// TODO : const value for actions and ids

class CircularButton extends InputGesture {
  final IconData _iconData;
  CircularButton(this._iconData);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: ScreenUtil.blockSizeHeight*14,
      height: ScreenUtil.blockSizeHeight*14,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        shape: BoxShape.circle,
      ),
      child: Icon(
        _iconData,
        color: Colors.white,
      ),
    );
  }
}

class ButtonLeft extends InputGesture {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ScreenUtil.blockSizeHeight*10,
      left: ScreenUtil.blockSizeWidth*10,
      child: GestureDetector(
        onLongPressStart: (LongPressStartDetails details) {
          this.pushInput(context, Input("Left", "pressStart"));
        },
        onLongPressEnd: (LongPressEndDetails details) {
          this.pushInput(context, Input("Left", "pressEnd"));
        },
        child: CircularButton(Icons.arrow_back),
      )
    );
  }
}

class ButtonRight extends InputGesture {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ScreenUtil.blockSizeHeight*10,
      left: ScreenUtil.blockSizeWidth*24,
      child: GestureDetector(
        onLongPressStart: (LongPressStartDetails details) {
          this.pushInput(context, Input("Right", "pressStart"));
        },
        onLongPressEnd: (LongPressEndDetails details) {
          this.pushInput(context, Input("Right", "pressEnd"));
        },
        child: CircularButton(Icons.arrow_forward),
      )
    );
  }
}

class ButtonUp extends InputGesture {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ScreenUtil.blockSizeHeight*10,
      left: ScreenUtil.blockSizeWidth*60,
      child: FloatingActionButton(
        heroTag: "Up",
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        child: Icon(
          Icons.arrow_upward,
          color: Colors.white,
        ),
        onPressed: () {this.pushInput(context, Input("Up", "pressed"));},
      )
    );
  }
}

class ButtonA extends InputGesture {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ScreenUtil.blockSizeHeight*10,
      left: ScreenUtil.blockSizeWidth*72,
      child: FloatingActionButton(
        heroTag: "A",
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        child: Text("A"),
        onPressed: () {this.pushInput(context, Input("A", "pressed"));},
      )
    );
  }
}

class ButtonB extends InputGesture {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ScreenUtil.blockSizeHeight*10,
      left: ScreenUtil.blockSizeWidth*84,
      child: FloatingActionButton(
        heroTag: "B",
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        child: Text("B"),
        onPressed: () {this.pushInput(context, Input("B", "pressed"));},
      )
    );
  }
}