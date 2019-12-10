import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/screen_util.dart';
import 'package:smashlike/main.dart';
import 'package:smashlike/menu.dart';

class Host extends StatelessWidget {
  final int playerId;
  final int mapId;

  Host({@required this.playerId, @required this.mapId});
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, screenOrientation: "landscape");
    return Scaffold(
      body: Container(
        height: ScreenUtil.screenHeight,
        width: ScreenUtil.screenWidth,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/menus/joinback.png'),
            fit: BoxFit.fill,

          ),
        ),
        child:Stack(
            children:[


              Align(
                alignment: Alignment(0, -0.6),
                child: Text("Waiting for a player..."  , textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 30),),
              ),
              Align(
                alignment: Alignment(-0.8, 0.1),
                child: Container(
                  height: ScreenUtil.unitHeight*30,
                  width: ScreenUtil.unitWidth*20,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/menus/bluetooth.png'),
                      fit: BoxFit.fill,

                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.8, 0.1),
                child:Container(
                    height: ScreenUtil.unitHeight*30,
                    width: ScreenUtil.unitWidth*20,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/menus/bluetooth.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),

              Align(
                alignment: Alignment(0, 0.9),
                child: ReturnButton(),
              ),


            ]
        ),
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
            FadeRoute(page: SecondMenuPage()),
          ); // switch to game page
        },
        child: null,
      ),
    );
  }
}


