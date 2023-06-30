import 'package:firebase_core/firebase_core.dart';
import 'package:flame/game.dart';
import 'package:flame_doc/overlays/game_over.dart';
import 'package:flame_doc/overlays/main_menu.dart';
import 'package:flutter/material.dart';

import 'ember_quest_game.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FocusNode focusNode = FocusNode();
  String playerName = 'New Player';

  runApp(
    MaterialApp(
      home: GameWidget<EmberQuestGame>.controlled(
        focusNode: focusNode,
        gameFactory: EmberQuestGame.new,
        overlayBuilderMap: {
          'MainMenu': (_, game) => MainMenu(
                game: game,
                focusNode: focusNode,
                setPlayerName: (pn) => playerName = pn,
              ),
          'GameOver': (_, game) => GameOver(
                game: game,
                playerName: playerName,
              ),
        },
        initialActiveOverlays: const ['MainMenu'],
      ),
    ),
  );
}
