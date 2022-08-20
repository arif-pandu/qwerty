import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

// class Wall<T extends FlameGame> extends PositionComponent with CollisionCallbacks, HasGameRef<T> {
//   @override
//   Future<void> onLoad() async {
//     await super.onLoad();
//     size = gameRef.size;
//     add(RectangleHitbox());
//   }

//   final _zeroVector = Vector2.zero();
//   @override
//   void update(double dt) {
//     super.update(dt);
//     position = gameRef.camera.unprojectVector(_zeroVector);
//   }

//   @override
//   void onGameResize(Vector2 gameSize) {
//     super.onGameResize(gameSize);
//     size = gameSize;
//   }
// }

List<Wall> createBoundaries(Forge2DGame game) {
  final topLeft = Vector2.zero();
  final bottomRight = game.screenToWorld(game.camera.viewport.effectiveSize);
  final topRight = Vector2(bottomRight.x, topLeft.y);
  final bottomLeft = Vector2(topLeft.x, bottomRight.y);

  return [
    Wall(topLeft, topRight),
    Wall(topRight, bottomRight),
    Wall(bottomRight, bottomLeft),
    Wall(bottomLeft, topLeft),
  ];
}

class Wall extends BodyComponent {
  final Vector2 start;
  final Vector2 end;

  Wall(this.start, this.end);

  @override
  Body createBody() {
    final shape = EdgeShape()..set(start, end);
    final fixtureDef = FixtureDef(shape, friction: 0.3);
    final bodyDef = BodyDef(
      userData: this, // To be able to determine object in collision
      position: Vector2.zero(),
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
