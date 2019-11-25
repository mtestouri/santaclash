import 'dart:math';
import 'package:smashlike/smash_engine/asset.dart';

class Physics {
  // TODO pos just before collision
  double _currFps = 60;
  double _gravity = -98.1;

  static final Physics _inst = Physics._internal();
  Physics._internal();

  set currFps(double value) => _currFps = value;

  factory Physics({double gravity}) {
    if(gravity != null)
      _inst._gravity = gravity;
    return _inst;
  }

  void update(List<PhysicalAsset> assets) {
    for(int i=0; i<assets.length; i++) {
      if(assets[i].type == PhysicalAsset.DYNAMIC) {
        var a1 = assets[i];

        // gravity
        if(a1.gravity)
          a1.velY += _gravity/_currFps;

        // collisions
        for(int j=0; j<assets.length; j++) {
          // dynamic to static collisions only
          if(j != i && (assets[j].type == PhysicalAsset.STATIC)) {
            var a2 = assets[j];
            
            // along x
            if(max(a1.hitboxLeft + a1.velX/_currFps, a2.hitboxLeft + a2.velX/_currFps) 
              < min(a1.hitboxRight + a1.velX/_currFps, a2.hitboxRight + a2.velX/_currFps) &&
              max(a1.hitboxBottom, a2.hitboxBottom) 
              < min(a1.hitboxTop, a2.hitboxTop)) {
              a1.velX = 0;
              continue;
            }
            
            // along y
            if(max(a1.hitboxLeft, a2.hitboxLeft) 
              < min(a1.hitboxRight, a2.hitboxRight) &&
              max(a1.hitboxBottom + a1.velY/_currFps, a2.hitboxBottom + a2.velY/_currFps) 
              < min(a1.hitboxTop + a1.velY/_currFps, a2.hitboxTop + a2.velY/_currFps)) {
              a1.velY = 0;
              continue;
            }

            // along both
            if(max(a1.hitboxLeft + a1.velX/_currFps, a2.hitboxLeft + a2.velX/_currFps) 
              < min(a1.hitboxRight + a1.velX/_currFps, a2.hitboxRight + a2.velX/_currFps) &&
              max(a1.hitboxBottom + a1.velY/_currFps, a2.hitboxBottom + a2.velY/_currFps) 
              < min(a1.hitboxTop + a1.velY/_currFps, a2.hitboxTop + a2.velY/_currFps)) {
              a1.velX = 0;
              a1.velY = 0;
            }
          }
        }

        // positions
        a1.posX += a1.velX/_currFps;
        a1.posY += a1.velY/_currFps;
      }
    }
  }

  bool isOnGround(PhysicalAsset a1, List<PhysicalAsset> assets) {
    for(var a2 in assets) {
      if((identical(a1, a2) == false) && (a2.type == PhysicalAsset.STATIC)) {
        // check object underneath
        if(max(a1.hitboxLeft, a2.hitboxLeft) 
          < min(a1.hitboxRight, a2.hitboxRight) &&
          max(a1.hitboxBottom + a1.velY/_currFps + 
          _gravity/_currFps, a2.hitboxBottom + a2.velY/_currFps) 
          < min(a1.hitboxTop + a1.velY/_currFps + 
          _gravity/_currFps, a2.hitboxTop + a2.velY/_currFps)) {
          return true;
        }
      }
    }
    return false;
  }
}
