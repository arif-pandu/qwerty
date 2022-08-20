import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class PlayerBall extends BodyComponent {
  @override
  Body createBody() {
    Shape shape = CircleShape()..radius = 32;
    BodyDef bodyDef = BodyDef(
      type: BodyType.dynamic,
      linearVelocity: Vector2(100, 100) * 100,
    );
    FixtureDef fixtureDef = FixtureDef(
      shape,
      restitution: 1.0,
      // density: 1.0,
      // friction: 0.1,
      userData: this,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
