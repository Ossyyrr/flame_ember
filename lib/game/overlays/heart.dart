import 'package:ember_flame/game/services/ember_quest_game.dart';
import 'package:flame/components.dart';

enum HeartState {
  available,
  half,
  half1,
  half2,
}

class HeartHealthComponent extends SpriteGroupComponent<HeartState>
    with HasGameRef<EmberQuestGame> {
  final int heartNumber;

  HeartHealthComponent({
    required this.heartNumber,
    super.position,
    required super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final availableSprite = await game.loadSprite('heart.png');
    final half = await game.loadSprite('heart_half.png');
    final half1 = await game.loadSprite('heart_half_1.png');
    final half2 = await game.loadSprite('heart_half_2.png');

    sprites = {
      HeartState.available: availableSprite,
      HeartState.half2: half2,
      HeartState.half1: half1,
      HeartState.half: half,
    };

    current = HeartState.available;
  }

  @override
  void update(double dt) {
    if (game.health == 0) {
      current = HeartState.half;
    }
    if (game.health == 1) {
      current = HeartState.half1;
    }
    if (game.health == 2) {
      current = HeartState.half2;
    }
    if (game.health == 3) {
      current = HeartState.available;
    }
    super.update(dt);
  }
}
