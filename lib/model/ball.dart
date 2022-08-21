import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:qwerty/model/platform.dart';
import 'package:qwerty/screen/main_game.dart';

class PlayerBall extends BodyComponent<MainGame> with ContactCallbacks {
  @override
  Body createBody() {
    Shape shape = CircleShape()..radius = 1.5;
    BodyDef bodyDef = BodyDef(
      type: BodyType.dynamic,
      linearVelocity: Vector2(100, 100) * 100,
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
      // gameRef.score++;
      gameRef.updateScore();
    }
  }
}
