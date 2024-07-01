import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/src/text/renderers/text_renderer.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird/components/configaration.dart';
import 'package:flappy_bird/components/pip_positions.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';

import '../assets.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame>{
  PipeGroup();

  final _random = Random();

  @override
  Future<void> onLoad() async{

    position.x = gameRef.size.x;

   final heightMinimusGroup =  gameRef.size.y - Config.groundHeight;
   final spaching = 100 + _random.nextDouble() * (heightMinimusGroup / 4);
   final centery = spaching + _random.nextDouble() * (heightMinimusGroup - spaching);
    addAll([
      Pipe(height: centery - spaching/2, pipePosition: PipePositions.top),
      Pipe(height: heightMinimusGroup - (centery + spaching /2), pipePosition: PipePositions.bottom)
    ]);
  }


  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt;

    if(position.x < -10){
      removeFromParent();
      print("====> remove");
      updateScroe();
    }
    if (gameRef.isHit) {
      removeFromParent();
      gameRef.isHit = false;
    }
  }

  void updateScroe(){
    gameRef.bird.score += 1;
    FlameAudio.play(Assets.point);
  }
}