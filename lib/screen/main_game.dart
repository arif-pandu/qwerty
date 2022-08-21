import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:qwerty/model/ball.dart';
import 'package:qwerty/model/ball.dart';
import 'package:qwerty/model/laser_path.dart';
import 'package:qwerty/model/letters.dart';
import 'package:qwerty/utils/list_keyboard.dart';
import 'package:qwerty/model/platform.dart';
import 'package:qwerty/utils/position.dart';
import 'package:qwerty/model/wall.dart';

class MainGame extends Forge2DGame with HasTappables, KeyboardEvents {
  MainGame() : super(gravity: Vector2.zero());

  bool isChainExist = false;

  late PlayerBall playerBall;
  late LaserPath laserPath;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    var boundaries = createBoundaries(this);
    boundaries.forEach(add);

    playerBall = PlayerBall();
    add(playerBall);

    var letters = createLetters(size);
    letters.forEach(add);

    // add(Platform(camera.gameSize / 2));

    Future.delayed(Duration(seconds: 3), () {
      add(BoxPlatform(camera.gameSize / 2));
    });
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;
    int random = Random().nextInt(26);

    if (event.logicalKey != ListKeyBoard.listKey[random]) {
      if (ListKeyBoard.listKey.contains(event.logicalKey)) {
        if (!isChainExist && isKeyDown) {
          isChainExist = true;
          laserPath = LaserPath(
            startPoint: ListPositions.position(size)[random],
            endPoint: ListPositions.position(size)[ListKeyBoard.listKey.indexOf(event.logicalKey)],
          );
          add(laserPath);
        } else if (isChainExist && !isKeyDown) {
          laserPath.removeFromParent();
          isChainExist = false;
        }
      }
    }

    return super.onKeyEvent(event, keysPressed);
  }
}

//// EXAMPLE
// class FindCoordinates extends BodyComponent {
//   FindCoordinates({required this.offset});
//   final Vector2 offset;

//   @override
//   Body createBody() {
//     Shape circle = CircleShape()..radius = 2;
//     BodyDef bodyDef = BodyDef(
//       type: BodyType.static,
//       position: offset,
//     );
//     FixtureDef fixtureDef = FixtureDef(circle, restitution: 1, friction: 0);
//     return world.createBody(bodyDef)..createFixture(fixtureDef);
//   }
// }
