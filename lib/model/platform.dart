import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:qwerty/model/ball.dart';

class BoxPlatform extends BodyComponent {
  final Vector2 position;

  BoxPlatform(this.position);

  @override
  Body createBody() {
    final shape = PolygonShape();
    shape.setAsBoxXY(4.0, 1);
    final bodyDef = BodyDef(
      position: position,
      userData: this,
    );
    final fixtureDef = FixtureDef(shape, friction: 0, restitution: 1);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  Future<void> removeFromGame() async {}
}
