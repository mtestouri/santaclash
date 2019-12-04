import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/screen_util.dart';
import 'package:smashlike/game.dart';
import 'package:smashlike/menu.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // set landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // hide status bar
    SystemChrome.setEnabledSystemUIOverlays([]);
    // root widget
    return MaterialApp(
      title: 'Smash Like',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil().init(context, "landscape");
    return Scaffold(
      body: GestureDetector(
        onTap:(){

          Navigator.push(
              context,
              FadeRoute(page: MenuPage())
          );
        },
      child: Container(
        height: ScreenUtil.screenHeight,
        width: ScreenUtil.screenWidth,
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/homepage.png'),
          fit: BoxFit.fill,
        ),
      ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, -0.89),
              child: Title(),
            ),
            Align(
              alignment: Alignment(0,0.7),
              child: MyBlinkingButton(),
            ),

          ],

      ),
      ),
      ),
    );
  }

}


class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.blockSizeHeight * 18,
      width: ScreenUtil.blockSizeWidth * 60,
      child: FittedBox(
        child: Image.asset('assets/images/smash-like.png'),
        fit: BoxFit.fill,
      ),
    );
  }
}

class MyBlinkingButton extends StatefulWidget {
  @override
  _MyBlinkingButtonState createState() => _MyBlinkingButtonState();
}

class _MyBlinkingButtonState extends State<MyBlinkingButton>
    with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  @override
  void initState() {
    _animationController =
    new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return FadeTransition(
      opacity: _animationController,
      child: Container(
        height: ScreenUtil.blockSizeHeight * 10,
        width: ScreenUtil.blockSizeWidth * 30,
        child: Image.asset('assets/images/touch-screen.png'),
      ),
      );
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}


class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}

