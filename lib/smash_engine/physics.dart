import 'dart:math';
import 'package:smashlike/smash_engine/asset.dart';

class Physics {
  // TODO parameters and singleton ?
  // TODO pos just before collision

  static void update(List<PhysicalAsset> assets, double currFps) {
    for(int i=0; i<assets.length; i++) {
      if(assets[i].type == PhysicalAsset.DYNAMIC) {
        PhysicalAsset a1 = assets[i];

        // gravity
        if(a1.gravity)
          a1.velY -= 1;

        // collisions
        for(int j=0; j<assets.length; j++) {
          // dynamic to static collisions only
          if(j != i && (assets[j].type == PhysicalAsset.STATIC)) {
            var a2 = assets[j];
            
            // along x
            if(max(a1.hitboxLeft + a1.velX/currFps, a2.hitboxLeft + a2.velX/currFps) 
              < min(a1.hitboxRight + a1.velX/currFps, a2.hitboxRight + a2.velX/currFps) &&
              max(a1.hitboxBottom, a2.hitboxBottom) 
              < min(a1.hitboxTop, a2.hitboxTop)) {
              a1.velX = 0;
              continue;
            }
            
            // along y
            if(max(a1.hitboxLeft, a2.hitboxLeft) 
              < min(a1.hitboxRight, a2.hitboxRight) &&
              max(a1.hitboxBottom + a1.velY/currFps, a2.hitboxBottom + a2.velY/currFps) 
              < min(a1.hitboxTop + a1.velY/currFps, a2.hitboxTop + a2.velY/currFps)) {
              a1.velY = 0;
              continue;
            }

            // along both
            if(max(a1.hitboxLeft + a1.velX/currFps, a2.hitboxLeft + a2.velX/currFps) 
              < min(a1.hitboxRight + a1.velX/currFps, a2.hitboxRight + a2.velX/currFps) &&
              max(a1.hitboxBottom + a1.velY/currFps, a2.hitboxBottom + a2.velY/currFps) 
              < min(a1.hitboxTop + a1.velY/currFps, a2.hitboxTop + a2.velY/currFps)) {
              a1.velX = 0;
              a1.velY = 0;
            }
          }
        }

        // positions
        a1.posX += a1.velX/currFps;
        a1.posY += a1.velY/currFps;
      }
    }
  }
}
