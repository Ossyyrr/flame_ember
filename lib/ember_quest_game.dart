import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_doc/actors/ember.dart';
import 'package:flame_doc/objects/ground_block.dart';
import 'package:flame_doc/objects/platform_block.dart';
import 'package:flame_doc/objects/platform_block_grass.dart';
import 'package:flutter/material.dart';

import 'actors/water_enemy.dart';
import 'managers/segment_manager.dart';
import 'objects/star.dart';
import 'overlays/hud.dart';

class EmberQuestGame extends FlameGame
    with
        HasCollisionDetection,
        HasKeyboardHandlerComponents,
        TapDetector,
        VerticalDragDetector,
        LongPressDetector {
  EmberQuestGame();

  late EmberPlayer _ember;
  double objectSpeed = 0.0; //Velocidad de los objetos del juego
  late double lastBlockXPosition = 0.0;
  late UniqueKey lastBlockKey;
  ValueNotifier<bool> hasJumped = ValueNotifier<bool>(false);

  final world = World();
  late final CameraComponent cameraComponent;

  int starsCollected = 0;
  int health = 3;

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }

  @override
  void onLongPressStart(LongPressStartInfo info) {
    if (info.eventPosition.game[0] < 250) {
      _ember.goLeft();
    } else {
      _ember.goRight();
    }
  }

  @override
  void onLongPressEnd(LongPressEndInfo info) {
    _ember.horizontalDirection = 0;
  }

  @override
  void onVerticalDragStart(DragStartInfo info) {
    _ember.jump();
    print("Vertical drag ${info.eventPosition.game}");
  }

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      // Carga las imagenes en cache
      'block.png',
      'block_grass.png',
      'ember.png',
      'ground.png',
      'heart_half.png',
      'heart_half_1.png',
      'heart_half_2.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
      'bg_w.png',
      'bg_f.png',
    ]);

    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);
    initializeGame(true);
  }

  void initializeGame(bool loadHud) {
    // Assume that size.x < 3200
    //Cada segmento será de 640 - 10 bloques de ancho para cada segmento. 64 pixeles por bloque.

    final segmentsToLoad = (size.x / 640).ceil();
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameSegments(i, (640 * i).toDouble());
    }

    _ember = EmberPlayer(
      position: Vector2(128, canvasSize.y - 128),
    );
    add(_ember);
    if (loadHud) {
      add(Hud());
    }
  }

  void reset() {
    starsCollected = 0;
    health = 3;
    initializeGame(false);
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    for (final block in segments[segmentIndex]) {
      switch (block.blockType) {
        case GroundBlock:
          add(
            GroundBlock(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
          break;
        case PlatformBlock:
          add(PlatformBlock(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));
          break;
        case PlatformBlockGrass:
          add(PlatformBlockGrass(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));
          break;
        case Star:
          add(
            Star(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
          break;
        case WaterEnemy:
          add(
            WaterEnemy(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
          break;
      }
    }
  }
}
