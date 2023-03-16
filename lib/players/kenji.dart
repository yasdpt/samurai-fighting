import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:samurai_fighting/core/consts.dart';

import 'package:samurai_fighting/core/extensions.dart';
import 'package:samurai_fighting/core/player.dart';
import 'package:samurai_fighting/core/player_state.dart';
import 'package:samurai_fighting/hud/health_bar.dart';
import 'package:samurai_fighting/players/mack.dart';

class Kenji extends Player {
  late Vector2 _basePosition;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _basePosition = Vector2(
      350,
      groundPosition,
    );

    await prepareAnimations();

    updateAnimation(PlayerState.idle);

    position = _basePosition;

    attackHitBox1 = RectangleHitbox(
      size: Vector2(88, 30),
      position: Vector2(18, 150),
      isSolid: true,
    );
    attackHitBox2 = RectangleHitbox(
      size: Vector2(88, 30),
      position: Vector2(18, 150),
      isSolid: true,
    );
    var takeHitbox = RectangleHitbox(
      size: Vector2(30, 100),
      position: Vector2(130, 100),
      isSolid: true,
    );
    add(takeHitbox);
    // debugMode = true;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Mack && isAttacking) {
      gameRef.mack!.takeHit(
        "Kenji",
        gameRef.mackHealthBar!,
      );
    }
  }

  @override
  void flip() {
    super.flip();
    if (isFlipped) {
      attackHitBox1.position = Vector2(190, 150);
      attackHitBox2.position = Vector2(190, 150);
    } else {
      attackHitBox1.position = Vector2(18, 150);
      attackHitBox2.position = Vector2(18, 150);
    }
  }

  @override
  void attack1() {
    if (!gameRef.isGameDone && !isAttacking) {
      isAttacking = true;

      updateAnimation(PlayerState.attack1);

      Future.delayed(const Duration(milliseconds: 200), () {
        if (!contains(attackHitBox1)) {
          add(attackHitBox1);
        }
      });

      Future.delayed(const Duration(milliseconds: 300), () {
        if (contains(attackHitBox1)) {
          remove(attackHitBox1);
        }
      });

      Future.delayed(
        const Duration(milliseconds: 400),
        () {
          updateAnimation(PlayerState.idle);
          isAttacking = false;
        },
      );
    }
  }

  @override
  void attack2() {
    if (!gameRef.isGameDone && !isAttacking) {
      isAttacking = true;

      updateAnimation(PlayerState.attack2);

      Future.delayed(const Duration(milliseconds: 200), () {
        if (!contains(attackHitBox2)) {
          add(attackHitBox2);
        }
      });

      Future.delayed(const Duration(milliseconds: 300), () {
        if (contains(attackHitBox2)) {
          remove(attackHitBox2);
        }
      });

      Future.delayed(
        const Duration(milliseconds: 400),
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
    attackHitBox1.position = Vector2(25, 150);
    attackHitBox2.position = Vector2(18, 150);
  }

  @override
  Future<void> prepareAnimations() async {
    final idle = await gameRef.loadSpriteAnimation(
      'kenji_idle.png',
      4.animationDataSequenced,
    );

    final running = await gameRef.loadSpriteAnimation(
      'kenji_run.png',
      8.animationDataSequenced,
    );

    final jump = await gameRef.loadSpriteAnimation(
      'kenji_jump.png',
      2.animationDataSequenced,
    );

    final fall = await gameRef.loadSpriteAnimation(
      'kenji_fall.png',
      2.animationDataSequenced,
    );

    final attack1 = await gameRef.loadSpriteAnimation(
      'kenji_attack_1.png',
      4.animationDataSequenced,
    );

    final attack2 = await gameRef.loadSpriteAnimation(
      'kenji_attack_2.png',
      4.animationDataSequenced,
    );

    final death = await gameRef.loadSpriteAnimation(
      'kenji_death.png',
      7.animationDataSequenced,
    );

    final takeHit = await gameRef.loadSpriteAnimation(
      'kenji_take_hit.png',
      3.animationDataSequenced,
    );

    final idleFlipped = await gameRef.loadSpriteAnimation(
      'kenji_idle_flipped.png',
      4.animationDataSequenced,
    );

    final runningFlipped = await gameRef.loadSpriteAnimation(
      'kenji_run_flipped.png',
      8.animationDataSequenced,
    );

    final jumpFlipped = await gameRef.loadSpriteAnimation(
      'kenji_jump_flipped.png',
      2.animationDataSequenced,
    );

    final fallFlipped = await gameRef.loadSpriteAnimation(
      'kenji_fall_flipped.png',
      2.animationDataSequenced,
    );

    final attack1Flipped = await gameRef.loadSpriteAnimation(
      'kenji_attack_1_flipped.png',
      4.animationDataSequenced,
    );

    final attack2Flipped = await gameRef.loadSpriteAnimation(
      'kenji_attack_2_flipped.png',
      4.animationDataSequenced,
    );

    final deathFlipped = await gameRef.loadSpriteAnimation(
      'kenji_death_flipped.png',
      7.animationDataSequenced,
    );

    final takeHitFlipped = await gameRef.loadSpriteAnimation(
      'kenji_take_hit_flipped.png',
      3.animationDataSequenced,
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
