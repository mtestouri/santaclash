import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/screen_util.dart';
import 'package:smashlike/game.dart';
import 'package:smashlike/main.dart';
import 'package:smashlike/credits.dart';

class SelectionChara extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil().init(context, "landscape");
    return Scaffold(
      body:Container(
        height: ScreenUtil.screenHeight,
        width: ScreenUtil.screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/selectback.png'),
            fit: BoxFit.fill,
          ),
        ),
      child:Stack(
        children:[
          Align(
            alignment: Alignment(-1, 0),
            child: Container(
              width: ScreenUtil.screenWidth/2,
              height: ScreenUtil.screenHeight,
              onTap:()=> print("on"),
              decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/selectbacks.png'),
                      fit: BoxFit.fill,
                ),
                  ),
                child:Stack(
                  children:[
                Align(
                  alignment: Alignment(0.3, 1.6),
                  child: IdleSanta(),
                ),
                    Align(
                      alignment: Alignment(0,-0.87),
                      child:Container(
                        width: ScreenUtil.blockSizeWidth*22,
                        height: ScreenUtil.blockSizeHeight*13,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/stitle.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    ),
                ]
                ),
          ),

    ),
          Align(
            alignment: Alignment(1, 0),
            child: Container(
              width: ScreenUtil.screenWidth/2,
              height: ScreenUtil.screenHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/selectbackc.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child:Stack(
              children:[
              Align(
              alignment: Alignment(0, 1),
              child: IdleCycl(),
              ),
              Align(
                  alignment: Alignment(0.2,-0.87),
                  child:Container(
                    width: ScreenUtil.blockSizeWidth*30,
                    height: ScreenUtil.blockSizeHeight*15,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/ctitle.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
              ),
              ]
              ),
              ),
            ),


          Align(
            alignment: Alignment(0, 0),
            child: Container(
                width: ScreenUtil.blockSizeWidth*15,
                height: ScreenUtil.screenHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/ligne.png'),
                    fit: BoxFit.fill,
                  ),
          ),
            ),
          ),
          Align(
            alignment: Alignment(-0.01, -0.9),
            child: Container(
              width: ScreenUtil.blockSizeWidth*20,
              height: ScreenUtil.blockSizeHeight*15,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/vs.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
    ]
    ),
    ),
    );
  }
}

class IdleSanta extends StatefulWidget {
  @override
  _IdleSantaState createState() => _IdleSantaState();
}

class _IdleSantaState extends State<IdleSanta> with TickerProviderStateMixin{
  AnimationController _idleFrame;
  @override
  void initState() {
    _idleFrame = AnimationController(
      value:0,
      lowerBound: 0,
      upperBound: 5,
      duration: Duration(microseconds: 500000),
      vsync: this,
    );
    _idleFrame.repeat();
    super.initState();
  }
  Widget frameNeeded(AnimationController frameNbr){

    if(frameNbr.value>=0 && frameNbr.value<1) {
      return Image.asset('assets/images/idle0s.png');
    }
    else if(frameNbr.value>=1 && frameNbr.value<2) {
      return Image.asset('assets/images/idle1s.png');
    }
    else if(frameNbr.value>=2 && frameNbr.value<3) {
      return Image.asset('assets/images/idle2s.png');
    }
    else if(frameNbr.value>=3 && frameNbr.value<4) {
      return Image.asset('assets/images/idle3s.png');
    }
    else {
      return Image.asset('assets/images/idle4s.png');
    }


  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.blockSizeHeight * 60,
      width: ScreenUtil.blockSizeWidth * 25,
      child: FittedBox(
        child: AnimatedBuilder(
          animation: _idleFrame,
          builder: (context,child){
            return frameNeeded(_idleFrame);
          },
          child: Image.asset('assets/images/idle0s'),
        ),
        fit: BoxFit.fill,
      ),
    );
  }
  @override
  void dispose() {
    _idleFrame.dispose();
    super.dispose();
  }
}
class IdleCycl extends StatefulWidget {
  @override
  _IdleCyclState createState() => _IdleCyclState();
}

class _IdleCyclState extends State<IdleCycl> with TickerProviderStateMixin{
  AnimationController _idleFrame;
  @override
  void initState() {
    _idleFrame = AnimationController(
      value:0,
      lowerBound: 0,
      upperBound: 5,
      duration: Duration(microseconds: 500000),
      vsync: this,
    );
    _idleFrame.repeat();
    super.initState();
  }
  Widget frameNeeded(AnimationController frameNbr){

    if(frameNbr.value>=0 && frameNbr.value<1) {
      return Image.asset('assets/images/idle0c.png');
    }
    else if(frameNbr.value>=1 && frameNbr.value<2) {
      return Image.asset('assets/images/idle1c.png');
    }
    else if(frameNbr.value>=2 && frameNbr.value<3) {
      return Image.asset('assets/images/idle2c.png');
    }
    else if(frameNbr.value>=3 && frameNbr.value<4) {
      return Image.asset('assets/images/idle3c.png');
    }
    else {
      return Image.asset('assets/images/idle4c.png');
    }


  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.blockSizeHeight * 70,
      width: ScreenUtil.blockSizeWidth * 40,
      child: FittedBox(
        child: AnimatedBuilder(
          animation: _idleFrame,
          builder: (context,child){
            return frameNeeded(_idleFrame);
          },
          child: Image.asset('assets/images/idle0c'),
        ),
        fit: BoxFit.fill,
      ),
    );
  }
  @override
  void dispose() {
    _idleFrame.dispose();
    super.dispose();
  }
}
