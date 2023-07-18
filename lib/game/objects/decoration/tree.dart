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
  static const double treeWidth = 300, treeHeigth = 300;

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

    position = Vector2(
        random.nextDouble() * screenWidth * 2, screenHeight - treeHeigth);
    size = Vector2(treeWidth, treeHeigth);

    sprite = await Sprite.load('tree1.png');

    return super.onLoad();
  }
}