import 'dart:async';

import 'package:flame/game.dart';

import 'package:samurai_fighting/hud/background.dart';

class SamuraiFighting extends FlameGame
    with HasDraggables, HasTappables, HasCollisionDetection {
  Background? background;
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _initComponent();

    add(background!);
  }

  /// Resize components that are dependable on size of the page
  /// after resizing.
  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    _initComponent();

    background!.size = canvasSize;
  }

  /// Initiate game components
  void _initComponent() {
    background ??= Background();
  }
}
