import 'package:ember_flame/game/overlays/game_over.dart';
import 'package:ember_flame/game/overlays/main_menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';
import 'game/services/ember_quest_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FocusNode focusNode = FocusNode();
  String playerName = 'New Player';

// TODO
// Hitbox borde de pantalla
// Iniciar juego al dar a play (no segundo plano)

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.lilitaOne().fontFamily,
      ),
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
