import 'package:ember_flame/game/actors/water_enemy.dart';
import 'package:ember_flame/game/objects/platform_block_grass.dart';
import 'package:ember_flame/game/objects/star.dart';
import 'package:ember_flame/utils/crate_animation_by_limit.dart';
import 'package:ember_flame/utils/globals.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';

import '../objects/ground_block.dart';
import '../objects/platform_block.dart';
import '../services/ember_quest_game.dart';

class EmberPlayer extends SpriteAnimationComponent
    with KeyboardHandler, CollisionCallbacks, HasGameRef<EmberQuestGame> {
  EmberPlayer({
    required super.position,
  }) : super(size: Vector2.all(64 * 1.5), anchor: Anchor.bottomCenter) {
    anchor = const Anchor(0.5, 0); // CENTRO
    debugMode = Globals.showHitBox; // Permite ver los hitBox
  }
  bool hitByEnemy = false;
  int horizontalDirection = 0;
  final Vector2 velocity = Vector2.zero();
  double moveSpeed = 200;
  final Vector2 fromAbove = Vector2(0, -1);

  bool isOnGround = false;
  final double gravity = 15;
  final double jumpSpeed = 600;
  final double terminalVelocity = 150;

  bool hasJumped = false;

  void jump() {
    hasJumped = true;
  }

  void goLeft() {
    horizontalDirection = -1;
  }

  void goRight() {
    horizontalDirection = 1;
  }

  late SpriteAnimation deadAnimation,
      walkAnimation,
      angryAnimation,
      lastAnimation;

  @override
  void onLoad() {
    final spriteSheet = SpriteSheet(
        image: game.images.fromCache('ember.png'), srcSize: Vector2(787, 770));

    walkAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 10, step: 3, sizeX: 20, stepTime: 0.4);
    deadAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 4, step: 6, sizeX: 20, stepTime: 0.4);
    angryAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 4, sizeX: 20, stepTime: 0.4);

    animation = walkAnimation;
    // animation = SpriteAnimation.fromFrameData(
    //   game.images.fromCache('ember.png'),
    //   SpriteAnimationData.sequenced(
    //     amount: 4,
    //     textureSize: Vector2.all(787),
    //     stepTime: 0.12,
    //   ),
    // );

    // HITBOX

    add(
      CircleHitbox(
        radius: 34,
        position: Vector2(12, 28),
      ),
    );
  }

  @override
  void update(double dt) {
    velocity.x = horizontalDirection * moveSpeed;
    position += velocity * dt;

    if (horizontalDirection == -1 && scale.x == 1) {
      flipHorizontally();
    } else if (horizontalDirection == 1 && scale.x == -1) {
      flipHorizontally();
    }

// Apply basic gravity
    velocity.y += gravity;

// Determine if ember has jumped
    if (hasJumped) {
      if (isOnGround) {
        velocity.y = -jumpSpeed;
        isOnGround = false;
      }
      hasJumped = false;
    }

// Prevent ember from jumping to crazy fast as well as descending too fast and
// crashing through the ground or a platform.
    velocity.y = velocity.y.clamp(-jumpSpeed, terminalVelocity);

    game.objectSpeed = 0;
    moveSpeed = 200;
// Prevent ember from going backwards at screen edge.
    if (position.x <= 0 && horizontalDirection < 0) {
      velocity.x = 0;
      // game.objectSpeed = moveSpeed;
      // moveSpeed = -200;
    }
// Prevent ember from going beyond half screen.
    if (position.x + 64 >= game.size.x / 2 && horizontalDirection > 0) {
      velocity.x = 0;
      game.objectSpeed = -moveSpeed;
      moveSpeed = 0;
    }

// If ember fell in pit, then game over.
    if (position.y > game.size.y + size.y) {
      game.health = 0;
    }

    if (game.health <= 0) {
      removeFromParent(); // Remove ember from game.
      game.overlays.add('GameOver');
    }
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirection = 0;

    if (keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      horizontalDirection = -1;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      horizontalDirection = 1;
    }

    hasJumped = keysPressed.contains(LogicalKeyboardKey.space) ||
        keysPressed.contains(LogicalKeyboardKey.keyW);

    return true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is GroundBlock ||
        other is PlatformBlock ||
        other is PlatformBlockGrass) {
      if (intersectionPoints.length == 2) {
        // Calculate the collision normal and separation distance.
        final mid = (intersectionPoints.elementAt(0) +
                intersectionPoints.elementAt(1)) /
            2;

        final collisionNormal = absoluteCenter - mid;
        final separationDistance = (size.x / 2) - collisionNormal.length;
        collisionNormal.normalize();

        // If collision normal is almost upwards,
        // ember must be on ground.
        if (fromAbove.dot(collisionNormal) > 0.9) {
          isOnGround = true;
        }

        // Resolve collision by moving ember along
        // collision normal by separation distance.
        position += collisionNormal.scaled(separationDistance);
      }
    }
    if (other is Star) {
      other.removeFromParent();
      game.starsCollected++;
    }

    if (other is WaterEnemy) {
      hit();
    }

    super.onCollision(intersectionPoints, other);
  }

  // This method runs an opacity effect on ember
// to make it blink.
  void hit() {
    if (!hitByEnemy) {
      hitByEnemy = true;
      game.health--;
    }
    add(
      OpacityEffect.fadeOut(
        EffectController(
          alternate: true,
          duration: 0.1,
          repeatCount: 5,
        ),
      )..onComplete = () {
          hitByEnemy = false;
        },
    );
  }
}
