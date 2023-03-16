import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'package:samurai_fighting/players/kenji.dart';
import 'package:samurai_fighting/game/samurai_fighting.dart';

class HealthBarBackground extends PositionComponent
    with HasGameRef<SamuraiFighting> {
  final PositionComponent player;
  static final _paint = Paint()..color = Colors.white;

  HealthBarBackground({required this.player});

  @override
  Future<void> onLoad() async {
    size = Vector2((gameRef.size.x / 2) - 65, 25);
    if (player is Kenji) {
      position = Vector2(gameRef.size.x - (size.x + 27.5), 17.5);
    } else {
      position = Vector2(size.x + 27.5, 17.5);
      flipHorizontally();
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(size.toRect(), const Radius.circular(8)),
      _paint,
    );
  }
}
