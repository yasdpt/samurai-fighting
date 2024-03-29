import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/widgets.dart';

import 'package:samurai_fighting/hud/action_button.dart';
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
  JoystickComponent? joystickKenji;
  JoystickComponent? joystickMack;
  ActionButton? kenjiAttack1;
  ActionButton? kenjiAttack2;
  ActionButton? kenjiDash;
  ActionButton? mackAttack1;
  ActionButton? mackAttack2;
  ActionButton? mackDash;

  bool isGameDone = false;
  final knobPaint = BasicPalette.black.withAlpha(200).paint();
  final backgroundPaint = BasicPalette.black.withAlpha(100).paint();

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
    add(joystickMack!);
    add(joystickKenji!);
    add(mackAttack1!);
    add(mackAttack2!);
    add(kenjiAttack1!);
    add(kenjiAttack2!);
    add(mackDash!);
    add(kenjiDash!);
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
    joystickKenji!.position = Vector2(canvasSize.x, canvasSize.y);
    kenjiAttack1!.position = Vector2(canvasSize.x - 67, 175);
    kenjiAttack2!.position = Vector2(canvasSize.x - 67, 110);
    kenjiDash!.position = Vector2(canvasSize.x - 130, 140);
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

    joystickKenji ??= JoystickComponent(
      knob: CircleComponent(radius: 15, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(right: 20, bottom: 20),
      position: Vector2(size.x, size.y),
    );

    joystickMack ??= JoystickComponent(
      knob: CircleComponent(radius: 15, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 20, bottom: 20),
    );

    kenjiAttack1 ??= ActionButton(
      image: 'kenji_attack_1.png',
      index: 1,
      onTap: kenji!.attack1,
      position: Vector2(size.x - 67, 175),
      circleOffset: const Offset(22, 32),
    );

    kenjiAttack2 ??= ActionButton(
      image: 'kenji_attack_2.png',
      index: 1,
      onTap: kenji!.attack2,
      position: Vector2(size.x - 67, 110),
      circleOffset: const Offset(22, 30),
    );
    kenjiDash ??= ActionButton(
      image: 'kenji_run.png',
      index: 5,
      onTap: () => kenji!.dash(joystickKenji!),
      position: Vector2(size.x - 130, 140),
      circleOffset: const Offset(35, 35),
    );

    mackAttack1 ??= ActionButton(
      image: 'mack_attack_1.png',
      index: 5,
      onTap: mack!.attack1,
      position: Vector2(10, 175),
    );

    mackAttack2 ??= ActionButton(
      image: 'mack_attack_2.png',
      index: 5,
      onTap: mack!.attack2,
      position: Vector2(10, 110),
      circleOffset: const Offset(42, 33),
    );

    mackDash ??= ActionButton(
      image: 'mack_run.png',
      index: 5,
      onTap: () => mack!.dash(joystickMack!),
      position: Vector2(70, 140),
      circleOffset: const Offset(34, 33),
    );
  }
}
