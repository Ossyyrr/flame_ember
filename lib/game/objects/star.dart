import 'package:ember_flame/game/services/ember_quest_game.dart';
import 'package:ember_flame/utils/globals.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class Star extends SpriteComponent with HasGameRef<EmberQuestGame> {
  final Vector2 gridPosition;
  double xOffset;

  final Vector2 velocity = Vector2.zero();

  Star({
    required this.gridPosition,
    required this.xOffset,
  }) : super(
          size: Vector2.all(64 * 2),
          anchor: Anchor.center,
        ) {
    anchor = const Anchor(0.5, 0.50); // CENTRO
    debugMode = Globals.showHitBox; // Permite ver los hitBox
  }

  @override
  void onLoad() {
    final starImage = game.images.fromCache('star.png');

    sprite = Sprite(starImage);
    position = Vector2(
      (gridPosition.x * size.x / 2) + xOffset + (size.x / 4),
      game.size.y - (gridPosition.y * size.y / 2) - (size.y / 4),
    );
    add(
      RectangleHitbox(
        collisionType: CollisionType.passive,
        size: size / 2,
        position: Vector2(28, 28),
      ),
    );
    add(
      SizeEffect.by(
        Vector2(-24, -24),
        EffectController(
          duration: 0.75,
          reverseDuration: 0.7,
          infinite: true,
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  @override
  void update(double dt) {
    velocity.x = game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x) removeFromParent();
    if (game.gameOver) {
      removeFromParent();
    }
    super.update(dt);
  }
}
