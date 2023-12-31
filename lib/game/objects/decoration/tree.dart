import 'dart:async';
import 'dart:math';

import 'package:ember_flame/game/services/ember_quest_game.dart';
import 'package:ember_flame/utils/globals.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class Tree extends SpriteComponent with HasGameRef<EmberQuestGame> {
  final bool isInitial;
  Tree({this.isInitial = false}) : super() {
    anchor = const Anchor(0.5, 1);

    priority = -1; // z-index
    debugMode = Globals.showHitBox;
  }
  static late double treeWidth, treeHeigth;
  final Random random = Random();
  late double screenWidth, screenHeight;

  @override
  void update(double dt) {
    position.x += game.objectSpeed * dt / 2;
    if (position.x < -treeWidth) {
      removeFromParent(); // Eliminar cuando sale de la pantalla
    }
    if (game.gameOver) {
      removeFromParent();
    }
    super.update(dt);
  }

  @override
  FutureOr<void> onLoad() async {
    screenWidth = game.size.x;
    screenHeight = game.size.y;

    treeHeigth = screenHeight / 1.5 + (random.nextDouble() * 10);
    treeWidth = treeHeigth;

    position = Vector2(
        random.nextDouble() * screenWidth +
            (isInitial ? 0 : screenWidth + treeWidth),
        screenHeight + 4);
    size = Vector2(treeWidth, treeHeigth);

    // Elegir aleatoriamente

    final trees = ['tree1.png', 'tree2.png', 'tree3.png', 'tree4.png'];
    final tree = trees[Random().nextInt(trees.length)];

    sprite = await Sprite.load(tree);

    add(
      RotateEffect.by(
        0.01,
        EffectController(
          duration: 2,
          reverseDuration: 1.5,
          startDelay: random.nextDouble() * 3,
          infinite: true,
          curve: Curves.easeInOut,
        ),
      ),
    );

    return super.onLoad();
  }
}
