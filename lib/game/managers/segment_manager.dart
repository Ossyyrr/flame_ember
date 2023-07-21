import 'package:flame/components.dart';

import '../actors/enemy.dart';
import '../objects/ground_block.dart';
import '../objects/platform_block.dart';
import '../objects/platform_block_grass.dart';
import '../objects/star.dart';

class Block {
  // gridPosition position is always segment based X,Y.
  // 0,0 is the bottom left corner.
  // 10,10 is the upper right corner.
  final Vector2 gridPosition;
  final Type blockType;
  Block(this.gridPosition, this.blockType);
}

final segments = [
  //Cada segmento será de 640 - 10 bloques de ancho para cada segmento. 64 pixeles por bloque.
  segment0,
  segment1,
  segment2,
  segment3,
  segment4,
];

final segment0 = [
  Block(Vector2(4, 4), Star),
  Block(Vector2(0, 0), GroundBlock),
  Block(Vector2(1, 0), GroundBlock),
  Block(Vector2(2, 0), GroundBlock),
  Block(Vector2(3, 0), GroundBlock),
  Block(Vector2(4, 0), GroundBlock),
  Block(Vector2(5, 0), GroundBlock),
  Block(Vector2(5, 3), PlatformBlockGrass),
  Block(Vector2(6, 0), GroundBlock),
  Block(Vector2(6, 3), PlatformBlockGrass),
  Block(Vector2(7, 0), GroundBlock),
  Block(Vector2(7, 3), PlatformBlockGrass),
  Block(Vector2(8, 0), GroundBlock),
  Block(Vector2(8, 3), PlatformBlockGrass),
  Block(Vector2(9, 0), GroundBlock),
  Block(Vector2(5, 1), Enemy),
];

final segment1 = [
  Block(Vector2(0, 0), GroundBlock),
  Block(Vector2(1, 0), PlatformBlock),
  Block(Vector2(1, 0), GroundBlock),
  Block(Vector2(1, 1), PlatformBlock),
  Block(Vector2(1, 2), PlatformBlock),
  Block(Vector2(1, 3), PlatformBlockGrass),
  Block(Vector2(2, 6), PlatformBlockGrass),
  Block(Vector2(3, 6), PlatformBlockGrass),
  Block(Vector2(6, 5), PlatformBlockGrass),
  Block(Vector2(7, 5), PlatformBlockGrass),
  Block(Vector2(7, 7), Star),
  Block(Vector2(8, 0), PlatformBlock),
  Block(Vector2(8, 0), GroundBlock),
  Block(Vector2(8, 1), PlatformBlockGrass),
  Block(Vector2(8, 5), PlatformBlockGrass),
  Block(Vector2(9, 0), GroundBlock),
  Block(Vector2(8, 6), Enemy),
];

final segment2 = [
  Block(Vector2(0, 0), GroundBlock),
  Block(Vector2(1, 0), GroundBlock),
  Block(Vector2(2, 0), GroundBlock),
  Block(Vector2(3, 0), GroundBlock),
  Block(Vector2(3, 3), PlatformBlockGrass),
  Block(Vector2(4, 0), GroundBlock),
  Block(Vector2(4, 3), PlatformBlockGrass),
  Block(Vector2(5, 0), GroundBlock),
  Block(Vector2(5, 3), PlatformBlockGrass),
  Block(Vector2(6, 0), GroundBlock),
  Block(Vector2(6, 3), PlatformBlock),
  Block(Vector2(6, 4), PlatformBlock),
  Block(Vector2(6, 5), PlatformBlockGrass),
  Block(Vector2(6, 7), Star),
  Block(Vector2(7, 0), GroundBlock),
  Block(Vector2(8, 0), GroundBlock),
  Block(Vector2(9, 0), GroundBlock),
  Block(Vector2(5, 4), Enemy),
];

final segment3 = [
  Block(Vector2(0, 0), GroundBlock),
  Block(Vector2(1, 0), GroundBlock),
  Block(Vector2(2, 0), PlatformBlock),
  Block(Vector2(2, 0), GroundBlock),
  Block(Vector2(2, 1), PlatformBlock),
  Block(Vector2(2, 2), PlatformBlockGrass),
  Block(Vector2(4, 4), PlatformBlockGrass),
  Block(Vector2(6, 6), PlatformBlockGrass),
  Block(Vector2(7, 0), PlatformBlock),
  Block(Vector2(7, 0), GroundBlock),
  Block(Vector2(7, 1), PlatformBlockGrass),
  Block(Vector2(8, 0), GroundBlock),
  Block(Vector2(8, 8), Star),
  Block(Vector2(9, 0), GroundBlock),
  Block(Vector2(1, 1), Enemy),
];

final segment4 = [
  Block(Vector2(0, 0), GroundBlock),
  Block(Vector2(1, 0), GroundBlock),
  Block(Vector2(2, 0), GroundBlock),
  Block(Vector2(2, 3), PlatformBlockGrass),
  Block(Vector2(3, 0), GroundBlock),
  Block(Vector2(3, 3), PlatformBlockGrass),
  Block(Vector2(4, 0), GroundBlock),
  Block(Vector2(5, 0), GroundBlock),
  Block(Vector2(5, 5), PlatformBlockGrass),
  Block(Vector2(6, 0), GroundBlock),
  Block(Vector2(6, 5), PlatformBlockGrass),
  Block(Vector2(6, 7), Star),
  Block(Vector2(7, 0), GroundBlock),
  Block(Vector2(8, 0), GroundBlock),
  Block(Vector2(8, 3), PlatformBlockGrass),
  Block(Vector2(9, 0), GroundBlock),
  Block(Vector2(9, 3), PlatformBlockGrass),
  Block(Vector2(3, 1), Enemy),
  Block(Vector2(9, 1), Enemy),
];
