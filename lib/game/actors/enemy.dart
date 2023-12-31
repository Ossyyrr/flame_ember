import 'package:ember_flame/core/services/image_sercice.dart';
import 'package:ember_flame/game/overlays/widget/character_selector.dart';
import 'package:ember_flame/game/services/ember_quest_game.dart';
import 'package:ember_flame/utils/globals.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/sprite.dart';

class Enemy extends SpriteAnimationComponent with HasGameRef<EmberQuestGame> {
  final Vector2 gridPosition;
  double xOffset;

  final Vector2 velocity = Vector2.zero();

  Enemy({
    required this.gridPosition,
    required this.xOffset,
  }) : super(
          size: Vector2.all(64 * 1.5),
          anchor: Anchor.bottomCenter,
        ) {
    anchor = const Anchor(0.5, 0.10); // Center
    debugMode = Globals.showHitBox;
  }

  late SpriteAnimation angryAnimation;

  @override
  void onLoad() async {
    (double, double) spriteSize =
        await ImageService.getImageSize('assets/images/ember.png');
    final spriteSheet = SpriteSheet(
        image: game.images.fromCache(
            Globals.selectedCharacter == Character.ember
                ? 'water_enemy.png'
                : 'ember.png'),
        srcSize: Vector2(spriteSize.$1 / 14, spriteSize.$2));

    void loadCharacterAnimations() async {
      angryAnimation =
          spriteSheet.createAnimation(row: 0, stepTime: 0.2, to: 3);
    }

    loadCharacterAnimations();

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
    if (position.x < -size.x || game.gameOver) {
      removeFromParent();
    }
    super.update(dt);
  }
}
