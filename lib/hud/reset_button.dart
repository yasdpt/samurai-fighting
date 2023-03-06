import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import 'package:samurai_fighting/game/samurai_fighting.dart';

class ResetButton extends PositionComponent
    with HasGameRef<SamuraiFighting>, Tappable {
  static final _paint = Paint()..color = Colors.blue.shade700.withOpacity(0.8);

  TextPaint textPaint = TextPaint(
    style: const TextStyle(
      fontSize: 20.0,
    ),
  );

  ResetButton();
  @override
  Future<void> onLoad() async {
    super.onLoad();

    var resetSprite = await Sprite.load(
      'restart.png',
      srcSize: Vector2(256, 256),
    );
    var resetIcon = SpriteComponent()
      ..sprite = resetSprite
      ..size = Vector2(25, 25)
      ..position = Vector2(15, 15)
      ..add(
        ColorEffect(
          Colors.white,
          const Offset(0.0, 1.0),
          EffectController(
            duration: 0,
          ),
        ),
      );

    size = Vector2(150, 50);
    position = Vector2((gameRef.size.x / 2) - 70, (gameRef.size.y / 2) + 40);
    add(resetIcon);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(size.toRect(), const Radius.circular(12)),
      _paint,
    );
    textPaint.render(
      canvas,
      "RESTART",
      Vector2(50, 15),
    );
    super.render(canvas);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    resetGame();
    return super.onTapDown(info);
  }

  void resetGame() {}
}
