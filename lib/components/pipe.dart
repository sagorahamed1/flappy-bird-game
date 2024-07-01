import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/assets.dart';
import 'package:flappy_bird/components/configaration.dart';
import 'package:flappy_bird/components/pip_positions.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';

class Pipe extends SpriteComponent with HasGameRef<FlappyBirdGame> {



  Pipe({
    required this.height,
    required this.pipePosition,
  });

  @override
  final double height;
  final PipePositions pipePosition;

  @override
  Future<void> onLoad() async {
   final pipe = await gameRef.images.load(Assets.pipe);
   final pipeRouted = await gameRef.images.load(Assets.pipeRotated);

   size = Vector2(50, height);

   switch(pipePosition){
     case PipePositions.top :
       position.y = 0;
       sprite = Sprite(pipeRouted);
     break;
     case PipePositions.bottom :
       position.y = gameRef.size.y - size.y - Config.groundHeight;
       sprite = Sprite(pipe);
       break;
   }

   add(RectangleHitbox());
  }
}