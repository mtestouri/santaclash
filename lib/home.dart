import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:smashlike/arena_engine/scale.dart';
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
    Scale().init(context, "landscape");
    return Scaffold(
      body: Container(
        height: Scale.screenHeight,
        width: Scale.screenWidth,
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/images/homepage.png'),
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
      height: Scale.blockSizeHeight * 15,
      width: Scale.blockSizeWidth * 35,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/images/smash-like.png'),
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
      height: Scale.blockSizeHeight * 15,
      width: Scale.blockSizeWidth * 20,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/images/play.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: FlatButton(
        onPressed: () {
          Game game = new Game(); // init game
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => game),
          ); // switch to game page
          game.play(); // entering game loop
        },
        child: null,
      ),
    );
  }
}