import 'package:ember_flame/game/services/ember_quest_game.dart';
import 'package:ember_flame/utils/crate_animation_by_limit.dart';
import 'package:ember_flame/utils/globals.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/sprite.dart';

class WaterEnemy extends SpriteAnimationComponent
    with HasGameRef<EmberQuestGame> {
  final Vector2 gridPosition;
  double xOffset;

  final Vector2 velocity = Vector2.zero();

  WaterEnemy({
    required this.gridPosition,
    required this.xOffset,
  }) : super(size: Vector2.all(64 * 1.5), anchor: Anchor.bottomCenter) {
    anchor = const Anchor(0.5, 0.10); // CENTRO
    debugMode = Globals.showHitBox; // Permite ver los hitBox
  }

  late SpriteAnimation deadAnimation,
      walkAnimation,
      angryAnimation,
      lastAnimation;

  @override
  void onLoad() {
    final spriteSheet = SpriteSheet(
        image: game.images.fromCache('water_enemy.png'),
        srcSize: Vector2(787, 770));

    walkAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 10, step: 3, sizeX: 20, stepTime: 0.4);
    deadAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 4, step: 6, sizeX: 20, stepTime: 0.4);
    angryAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 4, sizeX: 20, stepTime: 0.4);

    animation = angryAnimation;

    position = Vector2(
      (gridPosition.x * size.x) + xOffset + (size.x / 2),
      game.size.y - (gridPosition.y * size.y) - (size.y / 2),
    );
    add(
      RectangleHitbox(
        collisionType: CollisionType.passive,
        size: Vector2(64, 74),
        position: Vector2(17, 22),
      ),
    );
    flipHorizontally();
    add(
      MoveEffect.by(
        Vector2(-2 * size.x, 0),
        EffectController(
          onMax: () => flipHorizontally(),
          onMin: () => flipHorizontally(),
          duration: 3,
          alternate: true,
          infinite: true,
        ),
      ),
    );
  }

  @override
  void update(double dt) {
    velocity.x = game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x || game.health <= 0) {
      removeFromParent();
    }
    super.update(dt);
  }
}
