import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/screen_util.dart';
import 'package:smashlike/game.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.setScreenOrientation("landscape");
    ScreenUtil.hideStatusBar();
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
    ScreenUtil.init(context, screenOrientation: "landscape");
    return Scaffold(
      body: Container(
        height: ScreenUtil.screenHeight,
        width: ScreenUtil.screenWidth,
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/menus/homepage.png'),
          fit: BoxFit.fill,
        ),
      ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, 0.30),
              child: PlayButton(),
            ),
            Align(
              alignment: Alignment(0, -0.45),
              child: Title(),
            ),
          ],
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.unitHeight * 15,
      width: ScreenUtil.unitWidth * 35,
      child: FittedBox(
        child: Image.asset('assets/images/menus/smash-like.png'),
        fit: BoxFit.fill,
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.unitHeight * 15,
      width: ScreenUtil.unitWidth * 20,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/menus/play.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Game()),
          ); // switch to game page
        },
        child: null,
      ),
    );
  }
}