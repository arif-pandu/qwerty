import 'package:flame_forge2d/flame_forge2d.dart';

class Platform extends BodyComponent {
  final Vector2 worldCenter;

  Platform(this.worldCenter);

  @override
  Body createBody() {
    final shape = PolygonShape();
    shape.setAsBoxXY(4.0, 1);
    final fixtureDef = FixtureDef(shape, friction: 0, restitution: 1);

    final bodyDef = BodyDef(position: worldCenter.clone());
    final ground = world.createBody(bodyDef);
    ground.createFixture(fixtureDef);

    return ground;
  }
}
