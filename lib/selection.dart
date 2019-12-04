import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/screen_util.dart';

class SelectionChara extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, screenOrientation: "landscape");
    return Scaffold(
      body:Container(
        height: ScreenUtil.screenHeight,
        width: ScreenUtil.screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/menus/selectback.png'),
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
              decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/menus/selectbacks.png'),
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
                        width: ScreenUtil.unitWidth*22,
                        height: ScreenUtil.unitHeight*13,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/menus/stitle.png'),
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
                  image: AssetImage('assets/images/menus/selectbackc.png'),
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
                    width: ScreenUtil.unitWidth*30,
                    height: ScreenUtil.unitHeight*15,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/menus/ctitle.png'),
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
                width: ScreenUtil.unitWidth*15,
                height: ScreenUtil.screenHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/menus/ligne.png'),
                    fit: BoxFit.fill,
                  ),
          ),
            ),
          ),
          Align(
            alignment: Alignment(-0.01, -0.9),
            child: Container(
              width: ScreenUtil.unitWidth*20,
              height: ScreenUtil.unitHeight*15,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/menus/vs.png'),
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
      return Image.asset('assets/images/menus/idle0s.png');
    }
    else if(frameNbr.value>=1 && frameNbr.value<2) {
      return Image.asset('assets/images/menus/idle1s.png');
    }
    else if(frameNbr.value>=2 && frameNbr.value<3) {
      return Image.asset('assets/images/menus/idle2s.png');
    }
    else if(frameNbr.value>=3 && frameNbr.value<4) {
      return Image.asset('assets/images/menus/idle3s.png');
    }
    else {
      return Image.asset('assets/images/menus/idle4s.png');
    }


  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.unitHeight * 60,
      width: ScreenUtil.unitWidth * 25,
      child: FittedBox(
        child: AnimatedBuilder(
          animation: _idleFrame,
          builder: (context,child){
            return frameNeeded(_idleFrame);
          },
          child: Image.asset('assets/images/menus/idle0s'),
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
      return Image.asset('assets/images/menus/idle0c.png');
    }
    else if(frameNbr.value>=1 && frameNbr.value<2) {
      return Image.asset('assets/images/menus/idle1c.png');
    }
    else if(frameNbr.value>=2 && frameNbr.value<3) {
      return Image.asset('assets/images/menus/idle2c.png');
    }
    else if(frameNbr.value>=3 && frameNbr.value<4) {
      return Image.asset('assets/images/menus/idle3c.png');
    }
    else {
      return Image.asset('assets/images/menus/idle4c.png');
    }


  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.unitHeight * 70,
      width: ScreenUtil.unitWidth * 40,
      child: FittedBox(
        child: AnimatedBuilder(
          animation: _idleFrame,
          builder: (context,child){
            return frameNeeded(_idleFrame);
          },
          child: Image.asset('assets/images/menus/idle0c'),
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
