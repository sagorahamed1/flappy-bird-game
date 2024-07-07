
import 'package:flame/src/components/text_component.dart';
import 'package:flame/src/text/renderers/text_renderer.dart';
import 'package:flutter/material.dart';

import '../assets.dart';
import '../game/flappy_bird_game.dart';

class GameOverScreen extends StatelessWidget {
  final FlappyBirdGame game;

  const GameOverScreen({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.black38,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Container(
            height: 70,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.deepOrangeAccent
            ),

            child: Center(
              child: Text('SCORE : ${game.bird.score}', style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.w800
              ),),
            ),
          ),

          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(Assets.gameOver,width: 300),
          ),
          const SizedBox(height: 20),

          GestureDetector(
            onTap: onRestart,
            child:  Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(Assets.restart, height: 70, width: 250),
            ),
          )


        ],
      ),
    ),
  );

  void onRestart() {
    game.bird.reset();
    game.overlays.remove('gameOver');
    game.resumeEngine();
  }
}