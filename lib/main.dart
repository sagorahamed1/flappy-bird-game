import 'package:flame/game.dart';
import 'package:flappy_bird/screens/game_over_screen.dart';
import 'package:flappy_bird/screens/main_menu_screen.dart';
import 'package:flutter/cupertino.dart';

import 'game/flappy_bird_game.dart';

void main(){
  final game = FlappyBirdGame();
  runApp(
    GameWidget(
      initialActiveOverlays: const [MainMenuScreen.id],
        game:game,
      overlayBuilderMap: {
          'mainMenu' : (context, _)=> MainMenuScreen(game: game),
        'gameOver': (context, _) => GameOverScreen(game: game),
      },
    ),
  );
}