import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/background.dart';
import 'package:flappy_bird/components/bird.dart';
import 'package:flappy_bird/components/configaration.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe_group.dart';
import 'package:flutter/material.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  late TextComponent score;
  bool isHit = false;
  Timer interval = Timer(Config.pipeInterval, repeat: true);

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      score = buildScore(),
      Ground(),
      bird = Bird(),
      PipeGroup(),

    ]);

    interval.onTick = () => add(PipeGroup());
  }


  TextComponent buildScore() {
    return TextComponent(
      text: "Score : 0",
      textRenderer: TextPaint(
          style: const TextStyle(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.w800)),
      position: Vector2(size.x / 2, size.y / 2 * 0.2),
      anchor: Anchor.center,
    );
  }

  @override
  void onTap() {
    // TODO: implement onTap
    super.onTap();
    bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    score.text = 'Score : ${bird.score}';
  }
}
