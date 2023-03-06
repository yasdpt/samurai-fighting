import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'package:samurai_fighting/game/samurai_fighting.dart';

class HealthBar extends PositionComponent with HasGameRef<SamuraiFighting> {
  final PositionComponent player;
  static final _paint = Paint()..color = Colors.red.shade600;

  late Vector2 baseSize;

  HealthBar({required this.player});

  @override
  Future<void> onLoad() async {
    baseSize = Vector2((gameRef.size.x / 2.0) - 70.0, 20);
    size = baseSize;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(size.toRect(), const Radius.circular(8)),
      _paint,
    );
  }

  void lowerHealth() {
    size = Vector2(size.x - (baseSize.x / 10), 20);
  }

  void reset() {
    size = baseSize;
  }
}
