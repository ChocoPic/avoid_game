import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avoid_game/game/sprites/player.dart';
import 'package:flutter_avoid_game/game/sprites/star.dart';

class Bomb extends RectangleComponent with HasGameRef, CollisionCallbacks{
  static const bombSize = 32.0;

  Bomb(position)
  :super(
    position: position,
    size: Vector2.all(bombSize),
    anchor: Anchor.bottomCenter,
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    paint.color = Colors.deepPurpleAccent;
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {  //매 프레임마다 호출된다
    super.update(dt);
    position.y = position.y + 5;
    if(position.y - size.y > gameRef.size.y){ //화면 벗어나면 제거
      removeFromParent();
    }
  }

  @override //충돌 처리 대상
  bool onComponentTypeCheck(PositionComponent other) {
    if(other is Star || other is Bomb){
      return false;
    }else{
      return super.onComponentTypeCheck(other);
    }
  }

  @override //충돌시
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Player){
      removeFromParent();
    }else{
      super.onCollisionStart(intersectionPoints, other);
    }
  }
}