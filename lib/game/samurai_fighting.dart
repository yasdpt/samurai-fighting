import 'dart:async';

import 'package:flame/game.dart';
import 'package:samurai_fighting/hud/alert.dart';

import 'package:samurai_fighting/hud/background.dart';
import 'package:samurai_fighting/hud/health_bar.dart';
import 'package:samurai_fighting/hud/health_bar_background.dart';
import 'package:samurai_fighting/hud/reset_button.dart';
import 'package:samurai_fighting/hud/timer.dart';
import 'package:samurai_fighting/players/kenji.dart';
import 'package:samurai_fighting/players/mack.dart';

class SamuraiFighting extends FlameGame
    with HasDraggables, HasTappables, HasCollisionDetection {
  Background? background;
  AlertMessage? alertMessage;
  ResetButton? resetButton;
  Kenji? kenji;
  Mack? mack;
  HealthBar? kenjiHealthBar;
  HealthBarBackground? kenjiHealthBarBackground;
  HealthBar? mackHealthBar;
  HealthBarBackground? mackHealthBarBackground;
  AppTimer? timer;

  bool isGameDone = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _initComponent();

    add(background!);
    add(mack!);
    add(kenji!);
    add(kenjiHealthBarBackground!);
    add(kenjiHealthBar!);
    add(mackHealthBarBackground!);
    add(mackHealthBar!);
    add(timer!);
  }

  /// Resize components that are dependable on size of the page
  /// after resizing.
  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    _initComponent();

    background!.size = canvasSize;
    kenjiHealthBar!.size = Vector2((canvasSize.x / 2.0) - 70.0, 20);
    mackHealthBar!.size = Vector2((canvasSize.x / 2.0) - 70.0, 20);
    kenjiHealthBar!.position = Vector2(canvasSize.x - (canvasSize.x + 30), 20);
    mackHealthBar!.position = Vector2(canvasSize.x + 30, 20);
    kenjiHealthBarBackground!.size = Vector2((canvasSize.x / 2) - 65, 25);
    mackHealthBarBackground!.size = Vector2((canvasSize.x / 2) - 65, 25);
    kenjiHealthBarBackground!.position = Vector2(
      canvasSize.x - (canvasSize.x + 27.5),
      17.5,
    );
    mackHealthBarBackground!.position = Vector2(canvasSize.x + 27.5, 17.5);
    timer!.position = Vector2((canvasSize.x / 2) - 30, 15);
  }

  /// Initiate game components
  void _initComponent() {
    background ??= Background();
    alertMessage ??= AlertMessage();
    resetButton ??= ResetButton();
    kenji ??= Kenji();
    mack ??= Mack();
    kenjiHealthBar ??= HealthBar(player: kenji!);
    kenjiHealthBarBackground ??= HealthBarBackground(player: kenji!);
    mackHealthBar ??= HealthBar(player: mack!);
    mackHealthBarBackground ??= HealthBarBackground(player: mack!);
    timer ??= AppTimer();
  }
}
