import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:samurai_fighting/core/consts.dart';

import 'package:samurai_fighting/core/player_state.dart';
import 'package:samurai_fighting/hud/health_bar.dart';
import 'package:samurai_fighting/game/samurai_fighting.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<SamuraiFighting>, CollisionCallbacks {
  late SpriteAnimationGroupComponent<PlayerState> playerAnimation;
  late RectangleHitbox attackHitBox1;
  late RectangleHitbox attackHitBox2;
  bool isJumping = false;

  bool isFlipped = false;

  int health = 100;
  @override
  Future<void> onLoad() async {
    size = Vector2(200, 200) * playerScaleFactor;
    // debugMode = true;
  }

  void flip() {
    isFlipped = !isFlipped;
    updateAnimation(PlayerState.idle);
  }

  void updateAnimation(PlayerState playerState) {
    if (!isFlipped) {
      playerAnimation.current = playerState;
    } else {
      playerAnimation.current = PlayerState
          .values[playerState.index + (PlayerState.values.length ~/ 2)];
    }
    animation = playerAnimation.animation;
  }

  void jump() {
    if (!gameRef.isGameDone) {
      isJumping = true;
      updateAnimation(PlayerState.jumping);
      y -= 80;

      Future.delayed(const Duration(milliseconds: 200), () {
        updateAnimation(PlayerState.falling);
      });

      Future.delayed(const Duration(milliseconds: 250), () {
        updateAnimation(PlayerState.idle);
        y += 80;
      });

      Future.delayed(const Duration(milliseconds: 250), () {
        isJumping = false;
      });
    }
  }

  void dash(JoystickComponent joystick) {
    var isJoyMoving = (joystick.direction == JoystickDirection.right ||
        joystick.direction == JoystickDirection.left);
    if (isJoyMoving) {
      if (joystick.direction == JoystickDirection.right) {
        position = Vector2(position.x + 200, position.y);
      } else {
        position = Vector2(position.x - 200, position.y);
      }
    }
  }

  void move(JoystickComponent joyStick, double dt) {
    if (!gameRef.isGameDone) {
      var joyX = joyStick.relativeDelta.x * 300 * dt;
      var isJoyUp = (joyStick.direction == JoystickDirection.up ||
          joyStick.direction == JoystickDirection.upLeft ||
          joyStick.direction == JoystickDirection.upRight);

      if (joyStick.isDragged) {
        if ((joyX > 0.8 || joyX < -0.8)) {
          x += joyX;
          if (!isJumping) {
            updateAnimation(PlayerState.running);
          }
        } else {
          if (isJoyUp && !isJumping) {
            jump();
          }
        }
      } else {
        if (!isJumping &&
            (playerAnimation.current == PlayerState.running ||
                playerAnimation.current == PlayerState.runningFlipped)) {
          updateAnimation(PlayerState.idle);
        }
      }
    }
  }

  bool isAttacking = false;

  void attack1() {}

  void attack2() {}

  void takeHit(String opponentName, HealthBar healthBar) {
    if (health > 0 && !gameRef.isGameDone) {
      updateAnimation(PlayerState.takeHit);

      Future.delayed(const Duration(milliseconds: 300), () {
        if (!gameRef.isGameDone) {
          health -= 10;
          healthBar.lowerHealth();
          if (health <= 0) {
            updateAnimation(PlayerState.death);
            animation?.loop = false;
            gameRef.alertMessage!.message = "$opponentName WINS!";
            gameRef.alertMessage!.textPosition = Vector2(34, 12);
            gameRef.add(gameRef.alertMessage!);
            gameRef.add(gameRef.resetButton!);
            gameRef.isGameDone = true;
          } else {
            updateAnimation(PlayerState.idle);
          }
        }
      });
    }
  }

  Future<void> prepareAnimations() async {}

  void reset(HealthBar healthBar) {
    health = 100;
    healthBar.reset();
    isFlipped = false;
    updateAnimation(PlayerState.idle);
  }
}
