import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';

import 'package:samurai_fighting/game/samurai_fighting.dart';

class ActionButton extends SpriteComponent
    with HasGameRef<SamuraiFighting>, Tappable {
  final String image;
  final int index;
  final Function onTap;
  Offset circleOffset;

  ActionButton({
    super.position,
    required this.image,
    required this.index,
    required this.onTap,
    this.circleOffset = const Offset(42, 30),
  });
  @override
  Future<void> onLoad() async {
    super.onLoad();
    final actionImage = SpriteSheet(
      image: await gameRef.images.load(image),
      srcSize: Vector2(200, 200),
    );

    var spriteAttack = actionImage.getSprite(0, index);
    sprite = spriteAttack;
    size = Vector2(70, 70);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
      circleOffset,
      27,
      BasicPalette.black.withAlpha(50).paint(),
    );
    super.render(canvas);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    onTap();
    return super.onTapDown(info);
  }
}
