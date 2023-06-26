import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'ember_quest_game.dart';

void main() {
  runApp(
    const GameWidget<EmberQuestGame>.controlled(
      gameFactory: EmberQuestGame.new,
    ),
  );
}