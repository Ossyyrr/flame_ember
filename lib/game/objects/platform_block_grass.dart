import 'package:ember_flame/utils/globals.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../services/ember_quest_game.dart';

class PlatformBlockGrass extends SpriteComponent
    with HasGameRef<EmberQuestGame> {
  final Vector2 gridPosition;
  double xOffset;
  final Vector2 velocity = Vector2.zero();

  PlatformBlockGrass({
    required this.gridPosition,
    required this.xOffset,
  }) : super(
          size: Vector2.all(64),
          anchor: Anchor.bottomLeft,
        ) {
    debugMode = Globals.showHitBox; // Permite ver los hitBox
  }

  @override
  void onLoad() {
    final platformImage = game.images.fromCache('block_grass.png');
    sprite = Sprite(platformImage);
    position = Vector2(
      (gridPosition.x * size.x) + xOffset,
      game.size.y - (gridPosition.y * size.y),
    );
    add(
      RectangleHitbox(
        collisionType: CollisionType.passive,
        size: Vector2(64, 58),
        position: Vector2(0, 6),
      ),
    );
  }

  @override
  void update(double dt) {
    velocity.x = game.objectSpeed; // Velocidad definida en EmberQuestGame
    position += velocity * dt;
    if (position.x < -size.x) removeFromParent();
    if (position.x < -size.x || game.gameOver) {
      removeFromParent();
    }
    super.update(dt);
  }
}
