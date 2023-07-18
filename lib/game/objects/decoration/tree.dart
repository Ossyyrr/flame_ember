import 'dart:async';
import 'dart:math';

import 'package:ember_flame/game/services/ember_quest_game.dart';
import 'package:ember_flame/utils/globals.dart';
import 'package:flame/components.dart';

class Tree extends SpriteComponent with HasGameRef<EmberQuestGame> {
  Tree() : super() {
    priority = -1; // z-index
    debugMode = Globals.showHitBox; // Permite ver los hitBox
  }
  static late double treeWidth, treeHeigth;

  Random random = Random();

  late double screenWidth, screenHeight;

  final double spriteSheetWidth = 77.1,
      spriteSheetHeight = 120; // Valores de la imagen de un meteor

  @override
  void update(double dt) {
    position.x += game.objectSpeed * dt / 2;
    if (position.x < -treeWidth) {
      removeFromParent(); // Eliminar cuando sale de la pantalla
    }
    super.update(dt);
  }

  @override
  FutureOr<void> onLoad() async {
    screenWidth = game.size.x;
    screenHeight = game.size.y;

    treeHeigth = screenHeight / 1.5;
    treeWidth = screenHeight / 1.5;

    position = Vector2(random.nextDouble() * screenWidth + screenWidth,
        screenHeight - treeHeigth + 4);
    size = Vector2(treeWidth, treeHeigth);

    // Elegir aleatoriamente

    final trees = ['tree1.png', 'tree2.png', 'tree3.png', 'tree4.png'];
    final tree = trees[random.nextInt(trees.length)];

    sprite = await Sprite.load(tree);

    return super.onLoad();
  }
}
