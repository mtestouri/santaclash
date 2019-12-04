import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/screen_util.dart';
import 'package:smashlike/game.dart';
import 'package:smashlike/main.dart';

class Credits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil().init(context, "landscape");
    return Scaffold(
      body: Container(
        height: ScreenUtil.screenHeight,
        width: ScreenUtil.screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/creditsfont.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children:[
            Align(
              alignment: Alignment(0,-0.70),
              child: Stack(
                children:[
                  Text("Special Thank You To :",
                  style: TextStyle(
                    fontSize:40,
                    foreground: Paint()
                      ..style=PaintingStyle.stroke
                      ..strokeWidth=6
                      ..color=Colors.blue[900],
                  ),
                  ),

                  Text("Special Thank You To :",
                style: TextStyle(
                  fontSize: 40.0, color: Colors.grey[300],

                ),
              ),
                ]
            ),

            ),
            Align(
              alignment: Alignment(0.1, 0),
              child: ScrollCredits(),
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
        child: Image.asset('assets/images/Play.png'),
        fit: BoxFit.fill,
      ),
    );
  }
}

class ScrollCredits extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.blockSizeHeight*40,
      width: ScreenUtil.blockSizeWidth*60,
      child: SingleChildScrollView(

        child: Text(
                "DEVELOPER :\n \n"
                    "Agnello Vasco\n"
                    "Chiodo Adrien\n"
                    "Testouri Mehdi\n\n"
                    "ASSET DRAWER :\n\n"
                    "Vnitti\n"
                    "BigBuckBunny\n"
                    "Max Thorne\n"
                    "Ansinuz\n"
                    "Elthen",
                style: TextStyle(
            fontSize: 16.0, color: Colors.white,
        ),
            textAlign: TextAlign.center,
      ),
      ),
    );

  }
}