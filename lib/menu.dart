import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/screen_util.dart';
import 'package:smashlike/main.dart';
import 'package:smashlike/credits.dart';
import 'package:smashlike/selection.dart';
import 'package:smashlike/join.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, screenOrientation: "landscape");
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child:Scaffold(
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
                alignment: Alignment(0, -0.1),
                child: PlayButton(),
              ),
              Align(
                alignment: Alignment(0, 0.45),
                child: CreditsButton(),
              ),
              Align(
                alignment: Alignment(0, -0.89),
                child: Title(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class SecondMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, screenOrientation: "landscape");
    return WillPopScope(
        onWillPop: () => Future.value(false),
    child:Scaffold(
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
              alignment: Alignment(0, -0.1),
              child: CreateGameButton(),
            ),
            Align(
              alignment: Alignment(0, 0.45),
              child: JoinGameButton(),
            ),
            Align(
              alignment: Alignment(0, -0.89),
              child: Title(),
            ),
            Align(
              alignment: Alignment(0, 0.9),
              child: ReturnButton(),
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
      height: ScreenUtil.unitHeight * 20,
      width: ScreenUtil.unitWidth * 35,
      child: FittedBox(
        child: Image.asset('assets/images/menus/menu.png'),
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
            FadeRoute(page: SecondMenuPage()),
          ); // switch to game page
        },
        child: null,
      ),
    );
  }
}
class ReturnButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.unitHeight * 15,
      width: ScreenUtil.unitWidth * 10,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/menus/return.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            FadeRoute(page: MenuPage()),
          ); // switch to game page
        },
        child: null,
      ),
    );
  }
}
class CreateGameButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.unitHeight * 15,
      width: ScreenUtil.unitWidth * 40,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/menus/create_game.png'),
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
class JoinGameButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.unitHeight * 15,
      width: ScreenUtil.unitWidth * 30,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/menus/join_game.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            FadeRoute(page: PreJoin()),
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
      height: ScreenUtil.unitHeight * 15,
      width: ScreenUtil.unitWidth * 35,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/menus/credits.png'),
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