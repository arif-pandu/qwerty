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
    var vertices = [
      startPoint,
      endPoint,
    ];

    Shape shape = ChainShape()..createChain(vertices);

    BodyDef bodyDef = BodyDef(userData: this);
    FixtureDef fixtureDef = FixtureDef(shape, friction: 0, restitution: 1);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
