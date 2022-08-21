import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:qwerty/model/laser_path.dart';
import 'package:qwerty/model/platform.dart';
import 'package:qwerty/model/wall.dart';
import 'package:qwerty/screen/main_game.dart';
import 'package:qwerty/utils/random.dart';

class PlayerBall extends BodyComponent<MainGame> with ContactCallbacks {
  @override
  Body createBody() {
    Shape shape = CircleShape()..radius = 1.5;
    BodyDef bodyDef = BodyDef(
      type: BodyType.dynamic,
      linearVelocity: Vector2(100, 100) * (doubleInRange(0, 1) - doubleInRange(0, 1)) * 100,
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
    }

    if (other is LaserPath) {
      body.applyLinearImpulse(body.linearVelocity * 100);
      print("Speed Up");
    }

    if (other is ForbiddenWall) {
      print("GAME OVER");
      gameRef.gameOver();
    }
  }
}
