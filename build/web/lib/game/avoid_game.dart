import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avoid_game/game/sprites/bomb.dart';
import 'package:flutter_avoid_game/game/sprites/player.dart';
import 'package:flutter_avoid_game/game/sprites/star.dart';

class AvoidGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  late Player player;
  double nextSpawnTime = 0;
  late TextComponent starScore;
  late TextComponent bombScore;
  late TextComponent score;

  @override
  Future<void> onLoad() async {
    player = Player(
      position: Vector2(size.x * 0.5, size.y-32),
    );
    add(player);

    // 점수 표시
    starScore = TextComponent(
      text: '',
      textRenderer: TextPaint(
          style: const TextStyle(fontSize: 20, color: Colors.white,)
      ),
      anchor: Anchor.center,
      position: Vector2(50,50),
    );
    bombScore = TextComponent(
      text: '',
      textRenderer: TextPaint(
          style: const TextStyle(fontSize: 20, color: Colors.white,)
      ),
      anchor: Anchor.center,
      position: Vector2(50,80),
    );
    score = TextComponent(
      text: '',
      textRenderer: TextPaint(
          style: const TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold)
      ),
      anchor: Anchor.center,
      position: Vector2(100, 70),
    );
    add(starScore);
    add(bombScore);
    add(score);
  }

  //탭 이벤트 세팅
  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (!event.handled) {
      final point = event.canvasPosition;
      if (point.x > size.x / 2) { //오른쪽 탭
        player.position = Vector2(size.x*0.75, size.y-32);
      } else { //왼쪽 탭
        player.position = Vector2(size.x*0.25, size.y-32);
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    // 오브젝트 랜덤으로 생성하기
    nextSpawnTime -= dt;
    if(nextSpawnTime < 0){
      var object_num = Random().nextInt(5);
      if(object_num < 2) {
        add(Bomb(Vector2(size.x*(Random().nextInt(10) > 5? 0.75 :0.25 ), 0)));
      }else{
        add(Star(Vector2(size.x*(Random().nextInt(10) > 5? 0.75 :0.25 ), 0)));
      }
      nextSpawnTime = 0.3 + Random().nextDouble()*2;
    }
    // 점수 업데이트하기
    var s1 =  player.getStarCnt();
    var s2 = player.getBombCnt();
    starScore.text = '+ ${s1.toString()}';
    bombScore.text = '- ${s2.toString()}';
    score.text = (s1*1 - s2*1).toString();
  }

  @override
  Color backgroundColor() => Colors.blueGrey;

}


