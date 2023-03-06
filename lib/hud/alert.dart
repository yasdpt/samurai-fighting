import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'package:samurai_fighting/game/samurai_fighting.dart';

class AlertMessage extends PositionComponent with HasGameRef<SamuraiFighting> {
  String message = "";
  static final _paint = Paint()..color = Colors.blue.shade700.withOpacity(0.8);
  TextPaint textPaint = TextPaint(
    style: const TextStyle(
      fontSize: 32.0,
    ),
  );

  Vector2 textPosition = Vector2(34, 12);

  @override
  FutureOr<void> onLoad() {
    size = Vector2(240, 60);
    position = Vector2((gameRef.size.x / 2) - 120, (gameRef.size.y / 2) - 30);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(size.toRect(), const Radius.circular(12)),
      _paint,
    );
    textPaint.render(
      canvas,
      message,
      textPosition,
    );
  }
}
