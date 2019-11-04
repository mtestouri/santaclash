import 'package:flutter/material.dart';
import 'package:smashlike/arena_engine/scale.dart';
import 'package:smashlike/game.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smash Like',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0.0, 0.05),
              child: PlayButton(),
            ),
            Align(
              alignment: Alignment(0.0, -0.55),
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
    ScaleConfig().init(context);
    return Container(
      height: ScaleConfig.heightScaling * 10,
      width: ScaleConfig.widthScaling * 60,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/smash-like.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScaleConfig().init(context);
    return Container(
      height: ScaleConfig.heightScaling * 10,
      width: ScaleConfig.widthScaling * 40,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/play.png'),
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