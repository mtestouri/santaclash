import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/screen_util.dart';
import 'package:smashlike/game.dart';
import 'package:smashlike/main.dart';
import 'package:smashlike/credits.dart';
import 'package:smashlike/selection.dart';




class MenuPage extends StatelessWidget {
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
              alignment: Alignment(0, -0.2),
              child: PlayButton(),
            ),
            Align(
              alignment: Alignment(0, 0.35),
              child: CreditsButton(),
            ),
            Align(
              alignment: Alignment(0, -0.89),
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
      child: FittedBox(
        child: Image.asset('assets/images/menu.png'),
        fit: BoxFit.fill,
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
              FadeRoute(page: SelectionChara()),
          ); // switch to game page
        },
        child: null,
      ),
    );
  }
}
class CreditsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.blockSizeHeight * 15,
      width: ScreenUtil.blockSizeWidth * 35,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/credits.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            FadeRoute(page: Credits()),
          ); // switch to game page
        },
        child: null,
      ),
    );
  }
}