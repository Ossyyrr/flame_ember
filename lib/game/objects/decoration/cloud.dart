import 'dart:async';
import 'dart:math';

import 'package:ember_flame/game/services/ember_quest_game.dart';
import 'package:ember_flame/utils/globals.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class Cloud extends SpriteComponent with HasGameRef<EmberQuestGame> {
  final bool isInitial;
  Cloud({this.isInitial = false}) : super() {
    anchor = const Anchor(0.5, 0.5);
    priority = -1; // z-index
    debugMode = Globals.showHitBox; // Permite ver los hitBox
  }

  static late double cloudWidth, cloudHeigth;
  final Random random = Random();
  late double screenWidth, screenHeight;

  @override
  void update(double dt) {
    position.x += game.objectSpeed * dt / 2;
    if (position.x < -cloudWidth) {
      removeFromParent(); // Eliminar cuando sale de la pantalla
    }
    super.update(dt);
  }

  @override
  FutureOr<void> onLoad() async {
    screenWidth = game.size.x;
    screenHeight = game.size.y;

    cloudHeigth = screenHeight / 3 + (random.nextDouble() * 10);
    cloudWidth = cloudHeigth * 2;

    position = Vector2(
        random.nextDouble() * screenWidth +
            (isInitial ? 0 : screenWidth + cloudWidth),
        (screenHeight * random.nextDouble()) / 2);
    size = Vector2(cloudWidth, cloudHeigth);

    // Elegir aleatoriamente

    final clouds = ['cloud1.png', 'cloud2.png', 'cloud3.png'];
    final cloud = clouds[Random().nextInt(clouds.length)];

    sprite = await Sprite.load(cloud);
    add(
      MoveEffect.by(
        Vector2((-screenWidth * 2.5), 0),
        EffectController(
          onMax: () => flipHorizontally(),
          onMin: () => flipHorizontally(),
          duration: 250,
        ),
      ),
    );

    return super.onLoad();
  }
}
