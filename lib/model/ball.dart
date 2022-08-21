import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:qwerty/model/laser_path.dart';
import 'package:qwerty/model/platform.dart';
import 'package:qwerty/model/wall.dart';
import 'package:qwerty/screen/main_game.dart';
import 'package:qwerty/utils/random.dart';

class PlayerBall extends BodyComponent<MainGame> with ContactCallbacks {
  PlayerBall() : super(renderBody: false);
  SpriteAnimationComponent ball = SpriteAnimationComponent();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    Image image = await gameRef.images.load("custom-ball.png");
    ball = SpriteAnimationComponent()
      ..animation = SpriteAnimation.fromFrameData(
        image,
        SpriteAnimationData.sequenced(
          amount: 10,
          stepTime: 1 / 10,
          textureSize: Vector2(100, 100),
        ),
      )
      ..size = Vector2(1.5, 1.5)
      ..anchor = Anchor.center
      ..position = Vector2.zero();

    add(ball);
  }

  @override
  Body createBody() {
    Shape shape = CircleShape()..radius = 1.5;
    BodyDef bodyDef = BodyDef(
      type: BodyType.dynamic,
      linearVelocity: Vector2(100, 100) * (doubleInRange(0, 1) - doubleInRange(0, 1)),
      position: Vector2(doubleInRange(30, gameRef.camera.gameSize.x - 30), 0),
    );
    FixtureDef fixtureDef = FixtureDef(
      shape,
      restitution: 1.0,
      friction: 0.0,
      userData: this,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is BoxPlatform) {
      other.removeFromParent();
      gameRef.updateScore();
      soundHitPlatform();
    }

    if (other is LaserPath) {
      body.applyLinearImpulse(body.linearVelocity * 1.01);
      print("Speed Up");
    }

    if (other is ForbiddenWall) {
      print("GAME OVER");
      gameRef.gameOver();
    }
  }

  Future<void> soundHitPlatform() async {
    await FlameAudio.play("custom-plop.mp3");
  }
}
