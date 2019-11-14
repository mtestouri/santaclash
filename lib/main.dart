import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/screen_util.dart';
import 'package:smashlike/game.dart';

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
      body: Container(
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
              alignment: Alignment(0, 0.15),
              child: PlayButton(),
            ),
            Align(
              alignment: Alignment(0, -0.55),
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
      height: ScreenUtil.blockSizeHeight * 15,
      width: ScreenUtil.blockSizeWidth * 35,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/smash-like.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.blockSizeHeight * 15,
      width: ScreenUtil.blockSizeWidth * 20,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/play.png'),
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