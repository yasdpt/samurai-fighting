import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'package:samurai_fighting/game/samurai_fighting.dart';

class AppTimer extends PositionComponent with HasGameRef<SamuraiFighting> {
  static final _paint = Paint()..color = Colors.blue.shade700.withOpacity(0.4);
  TextPaint textPaint = TextPaint(
    style: const TextStyle(
      fontSize: 12.0,
    ),
  );
  var countdown = Timer(60);

  var time = 60;

  @override
  FutureOr<void> onLoad() {
    size = Vector2(60, 30);
    position = Vector2((gameRef.size.x / 2) - 30, 15);
  }

  @override
  void update(double dt) {
    countdown.update(dt);
    if (countdown.finished) {
      // Prefer the timer callback, but this is better in some cases
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(size.toRect(), const Radius.circular(12)),
      _paint,
    );
    var timeLeft = time - countdown.current.toInt();
    if (timeLeft == 0 && !gameRef.isGameDone) {
      gameRef.isGameDone = true;
      gameRef.alertMessage!.message = "DRAW!";
      gameRef.alertMessage!.textPosition = Vector2(70, 12);
      gameRef.add(gameRef.alertMessage!);
      gameRef.add(gameRef.resetButton!);
    }

    if (gameRef.isGameDone) {
      textPaint.render(canvas, "00:00", Vector2(15, 9));
    } else {
      textPaint.render(
        canvas,
        "0${timeLeft == 60 ? "1" : "0"}:${timeLeft > 9 ? timeLeft == 60 ? "00" : timeLeft : "0$timeLeft"}",
        Vector2(15, 9),
      );
    }
  }
}
