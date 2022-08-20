import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class LaserPath extends BodyComponent {
  LaserPath({
    required this.startPoint,
    required this.endPoint,
  }) : super();

  final Vector2 startPoint;
  final Vector2 endPoint;

  @override
  Body createBody() {
    double length = sqrt(pow((endPoint.x - startPoint.x), 2) + pow((endPoint.y - startPoint.y), 2));
    Vector2 center = Vector2((startPoint.x + endPoint.x) / 2, (startPoint.y + endPoint.y) / 2);

    print("startPoint : " + startPoint.toString());
    print("endPoint : " + endPoint.toString());

    print("length : " + length.toStringAsFixed(2));
    print("center : " + center.toString());

    var vertices = [
      startPoint,
      endPoint,
    ];

    Shape shape = ChainShape()..createChain(vertices);

    BodyDef bodyDef = BodyDef();
    FixtureDef fixtureDef = FixtureDef(shape, friction: 0, restitution: 1);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
