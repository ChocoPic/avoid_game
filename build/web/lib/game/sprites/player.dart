import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avoid_game/game/sprites/bomb.dart';
import 'package:flutter_avoid_game/game/sprites/star.dart';

class Player extends RectangleComponent with CollisionCallbacks {
  // 모양 세팅
  static const playerSize = 52.0;
  int _starCnt = 0; //별 점수
  int _bombCnt = 0; //폭탄 점수

  Player({required position})
  :super(
    position: position,
    size: Vector2.all(playerSize),
    anchor: Anchor.bottomCenter,  //이동,크기,회전 시 기준 위치
   );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    paint.color = Colors.blue;
    add(RectangleHitbox());
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Star){
      _starCnt += 1;
    }else if(other is Bomb){
      _bombCnt += 1;
    }else{
      super.onCollisionStart(intersectionPoints, other);
    }
  }

  int getStarCnt(){
    return _starCnt;
  }
  int getBombCnt(){
    return _bombCnt;
  }
}