import 'package:ember_flame/game/services/ember_quest_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'heart.dart';

class Hud extends PositionComponent with HasGameRef<EmberQuestGame> {
  Hud({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 5,
  });

  late TextComponent _scoreTextComponent;

  @override
  Future<void> onLoad() async {
    _scoreTextComponent = TextComponent(
      text: '${game.starsCollected}',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 32,
          color: Color.fromRGBO(10, 10, 10, 1),
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(game.size.x - 60, 24),
    );
    add(_scoreTextComponent);

    final starSprite = await game.loadSprite('star.png');
    add(
      SpriteComponent(
        sprite: starSprite,
        position: Vector2(game.size.x - 100, 26),
        size: Vector2.all(64),
        anchor: Anchor.center,
      ),
    );

    await add(
      HeartHealthComponent(
        heartNumber: game.health,
        size: Vector2.all(42),
        position: Vector2(12, 4),
      ),
    );
  }

  @override
  void update(double dt) {
    _scoreTextComponent.text = '${game.starsCollected}';
  }
}
