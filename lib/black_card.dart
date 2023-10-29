import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:syzygy/actors/fighter_player.dart';
import 'package:syzygy/actors/samurai_enemy.dart';
import 'package:syzygy/controllers/segment_manager.dart';
import 'package:syzygy/objects/ground_block.dart';

class BlackCardGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  BlackCardGame();

  final world = World();
  late final CameraComponent cameraComponent;
  late FighterPlayer _player;
  double objectSpeed = 0.0;
  late double lastBlockXPosition = 0.0;
  late UniqueKey lastBlockKey;

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'fighter/Idle.png',
      'samurai/idle.png',
      'objects/ground.png',
    ]);
    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);
    initializeGame();
  }

  void initializeGame() {
    final segmentsToLoad = (size.x / 640).ceil();
    segmentsToLoad.clamp(0, segments.length);
    for (var i = 0; i < segmentsToLoad; i++) {
      loadGameSegments(i, (640 * i).toDouble());
    }
    _player = FighterPlayer(
      position: Vector2(128, canvasSize.y - 128),
    );
    world.add(_player);
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
        case SamuraiEnemy:
          add(
            SamuraiEnemy(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
          break;
      }
    }
  }
}
