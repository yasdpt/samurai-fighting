import 'package:flame/components.dart';

/// Default frame size for animations in game
Vector2 _defaultFrameSize = Vector2(200, 200);

extension ConvertFrameToAnimationData on int {
  /// Creates a sequenced [SpriteAnimationData] from the given [int] as frames amount
  SpriteAnimationData get animationDataSequenced =>
      SpriteAnimationData.sequenced(
        amount: this,
        stepTime: 0.1,
        textureSize: _defaultFrameSize,
      );
}
