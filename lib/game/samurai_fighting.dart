import 'dart:async';

import 'package:flame/game.dart';

class SamuraiFighting extends FlameGame
    with HasDraggables, HasTappables, HasCollisionDetection {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }
}
