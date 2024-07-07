import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird/assets.dart';
import 'package:flappy_bird/components/bird_movements.dart';
import 'package:flappy_bird/components/configaration.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flutter/cupertino.dart';

class Bird extends SpriteGroupComponent<BirdMovements>
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {

  int score = 0;

  @override
  Future<void> onLoad() async {
    final birdMiddleFlap = await gameRef.loadSprite(Assets.birdMidflap);
    final birdUpFlap = await gameRef.loadSprite(Assets.birdUPflap);
    final birdDownFlap = await gameRef.loadSprite(Assets.birdDownFlap);

    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);

    current = BirdMovements.middle;

    sprites = {
      BirdMovements.middle: birdMiddleFlap,
      BirdMovements.up: birdUpFlap,
      BirdMovements.down: birdDownFlap,
    };
    add(CircleHitbox());
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);
    print("=====> hit on Collision");
    gameOver();
  }

  void gameOver(){
    gameRef.overlays.add('gameOver');
    FlameAudio.play(Assets.collision);
    gameRef.pauseEngine();
    gameRef.isHit = true;
  }

  void reset(){
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
  }


  void fly() {
    add(MoveByEffect(Vector2(0, Config.gravity),
        EffectController(duration: 0.3, curve: Curves.decelerate),
        onComplete: () => current = BirdMovements.down));
    current = BirdMovements.up;

    
    FlameAudio.play(Assets.flying);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

    position.y += Config.birdVelocity * dt;


    if(position.y < 1){
      gameOver();
    }
  }
}
