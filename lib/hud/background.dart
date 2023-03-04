import 'package:flame/components.dart';

import 'package:samurai_fighting/game/samurai_fighting.dart';

class Background extends SpriteComponent with HasGameRef<SamuraiFighting> {
  Background() : super();

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('background.png');
    size = gameRef.size;
  }
}
