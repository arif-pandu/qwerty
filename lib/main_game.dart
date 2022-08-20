import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:qwerty/ball.dart';
import 'package:qwerty/laser_path.dart';
import 'package:qwerty/letters.dart';
import 'package:qwerty/platform.dart';
import 'package:qwerty/wall.dart';

class MainGame extends Forge2DGame with HasTappables, KeyboardEvents {
  MainGame()
      : super(
          gravity: Vector2.zero(),
          zoom: 1,
        );

  int letterTapped = 0;
  final maxLetterTapped = 2;
  List<LogicalKeyboardKey> pressedKey = [];

  late PlayerBall playerBall;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    var boundaries = createBoundaries(this);
    boundaries.forEach(add);

    playerBall = PlayerBall();
    // add(playerBall);

    var letters = createLetters(size);
    letters.forEach(add);

    add(LaserPath(
      startPoint: Vector2(200, 200),
      endPoint: Vector2(300, 300),
    ));
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    pressKey(event.logicalKey);

    return super.onKeyEvent(event, keysPressed);
  }

  Future<void> pressKey(LogicalKeyboardKey key) async {}
}

//// EXAMPLE
class FindCoordinates extends BodyComponent {
  FindCoordinates({required this.offset});
  final Vector2 offset;

  @override
  Body createBody() {
    Shape circle = CircleShape()..radius = 2;
    BodyDef bodyDef = BodyDef(
      type: BodyType.static,
      position: offset,
    );
    FixtureDef fixtureDef = FixtureDef(circle, restitution: 1, friction: 0);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
