import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:samurai_fighting/core/consts.dart';

import 'package:samurai_fighting/core/extensions.dart';
import 'package:samurai_fighting/core/player.dart';
import 'package:samurai_fighting/core/player_state.dart';
import 'package:samurai_fighting/hud/health_bar.dart';
import 'package:samurai_fighting/players/kenji.dart';

class Mack extends Player {
  late Vector2 _basePosition;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    _basePosition = Vector2(
      100,
      groundPosition + 9,
    );

    await prepareAnimations();

    updateAnimation(PlayerState.idle);

    position = _basePosition;
    attackHitBox1 = RectangleHitbox(
      size: Vector2(115, 30),
      position: Vector2(170, 130),
      isSolid: true,
    );
    attackHitBox2 = RectangleHitbox(
      size: Vector2(120, 30),
      position: Vector2(170, 130),
      isSolid: true,
    );
    var takeHitbox = RectangleHitbox(
      size: Vector2(40, 85),
      position: Vector2(128, 100),
      isSolid: true,
    );

    add(takeHitbox);
    // debugMode = true;
  }

  /// Change position of attack box based on [isFlipped]
  @override
  void flip() {
    super.flip();
    if (isFlipped) {
      attackHitBox1.position = Vector2(15, 130);
      attackHitBox2.position = Vector2(15, 130);
    } else {
      attackHitBox1.position = Vector2(170, 130);
      attackHitBox2.position = Vector2(170, 130);
    }
  }

  /// Attack
  @override
  void attack1() {
    if (!gameRef.isGameDone && !isAttacking) {
      isAttacking = true;
      updateAnimation(PlayerState.attack1);

      Future.delayed(
        const Duration(milliseconds: 300),
        () {
          if (!contains(attackHitBox1)) {
            add(attackHitBox1);
          }
        },
      );

      Future.delayed(
        const Duration(milliseconds: 400),
        () {
          if (contains(attackHitBox1)) {
            remove(attackHitBox1);
          }
        },
      );

      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          updateAnimation(PlayerState.idle);
          isAttacking = false;
        },
      );
    }
  }

  @override
  void attack2() {
    if (!gameRef.isGameDone) {
      isAttacking = true;
      updateAnimation(PlayerState.attack2);

      Future.delayed(
        const Duration(milliseconds: 400),
        () {
          if (!contains(attackHitBox2)) {
            add(attackHitBox2);
          }
        },
      );

      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          remove(attackHitBox2);
        },
      );

      Future.delayed(
        const Duration(milliseconds: 600),
        () {
          updateAnimation(PlayerState.idle);
          isAttacking = false;
        },
      );
    }
  }

  @override
  void reset(HealthBar healthBar) {
    super.reset(healthBar);
    position = _basePosition;
    attackHitBox1.position = Vector2(170, 130);
    attackHitBox2.position = Vector2(170, 130);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Kenji && isAttacking) {
      gameRef.kenji!.takeHit(
        "Mack",
        gameRef.kenjiHealthBar!,
      );
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  Future<void> prepareAnimations() async {
    final idle = await gameRef.loadSpriteAnimation(
      'mack_idle.png',
      8.animationDataSequenced,
    );

    final running = await gameRef.loadSpriteAnimation(
      'mack_run.png',
      8.animationDataSequenced,
    );

    final jump = await gameRef.loadSpriteAnimation(
      'mack_jump.png',
      2.animationDataSequenced,
    );

    final fall = await gameRef.loadSpriteAnimation(
      'mack_fall.png',
      6.animationDataSequenced,
    );

    final attack1 = await gameRef.loadSpriteAnimation(
      'mack_attack_1.png',
      6.animationDataSequenced,
    );

    final attack2 = await gameRef.loadSpriteAnimation(
      'mack_attack_2.png',
      6.animationDataSequenced,
    );

    final takeHit = await gameRef.loadSpriteAnimation(
      'mack_take_hit.png',
      4.animationDataSequenced,
    );

    final death = await gameRef.loadSpriteAnimation(
      'mack_death.png',
      6.animationDataSequenced,
    );

    final idleFlipped = await gameRef.loadSpriteAnimation(
      'mack_idle_flipped.png',
      8.animationDataSequenced,
    );

    final runningFlipped = await gameRef.loadSpriteAnimation(
      'mack_run_flipped.png',
      8.animationDataSequenced,
    );

    final jumpFlipped = await gameRef.loadSpriteAnimation(
      'mack_jump_flipped.png',
      2.animationDataSequenced,
    );

    final fallFlipped = await gameRef.loadSpriteAnimation(
      'mack_fall_flipped.png',
      6.animationDataSequenced,
    );

    final attack1Flipped = await gameRef.loadSpriteAnimation(
      'mack_attack_1_flipped.png',
      6.animationDataSequenced,
    );

    final attack2Flipped = await gameRef.loadSpriteAnimation(
      'mack_attack_2_flipped.png',
      6.animationDataSequenced,
    );

    final takeHitFlipped = await gameRef.loadSpriteAnimation(
      'mack_take_hit_flipped.png',
      4.animationDataSequenced,
    );

    final deathFlipped = await gameRef.loadSpriteAnimation(
      'mack_death_flipped.png',
      6.animationDataSequenced,
    );

    playerAnimation = SpriteAnimationGroupComponent<PlayerState>(
      animations: {
        PlayerState.running: running,
        PlayerState.idle: idle,
        PlayerState.jumping: jump,
        PlayerState.falling: fall,
        PlayerState.attack1: attack1,
        PlayerState.attack2: attack2,
        PlayerState.takeHit: takeHit,
        PlayerState.death: death,
        PlayerState.runningFlipped: runningFlipped,
        PlayerState.idleFlipped: idleFlipped,
        PlayerState.jumpingFlipped: jumpFlipped,
        PlayerState.fallingFlipped: fallFlipped,
        PlayerState.attack1Flipped: attack1Flipped,
        PlayerState.attack2Flipped: attack2Flipped,
        PlayerState.takeHitFlipped: takeHitFlipped,
        PlayerState.deathFlipped: deathFlipped,
      },
      current: PlayerState.idle,
    );
  }
}
