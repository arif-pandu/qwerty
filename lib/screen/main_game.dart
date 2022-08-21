import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:qwerty/model/ball.dart';
import 'package:qwerty/model/laser_path.dart';
import 'package:qwerty/model/letters.dart';
import 'package:qwerty/model/particle.dart';
import 'package:qwerty/model/score.dart';
import 'package:qwerty/utils/list_keyboard.dart';
import 'package:qwerty/model/platform.dart';
import 'package:qwerty/utils/position.dart';
import 'package:qwerty/model/wall.dart';
import 'package:qwerty/utils/random.dart';

class MainGame extends Forge2DGame with HasTappables, KeyboardEvents {
  MainGame() : super(gravity: Vector2.zero());

  bool isChainExist = false;

  int score = 0;

  int randomNum = 0;

  late PlayerBall playerBall;
  late LaserPath laserPath;
  late ScoreBoard scoreBoard;

  @override
  Color backgroundColor() => const Color(0xff1a1a1a);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    var boundaries = createBoundaries(this);
    boundaries.forEach(add);

    playerBall = PlayerBall();
    add(playerBall);

    var letters = createLetters(size);
    letters.forEach(add);

    scoreBoard = ScoreBoard(score: score);
    add(scoreBoard);

    Future.delayed(Duration(seconds: 0), () {
      spawnBoxPlatform();
    });
    randomNum = Random().nextInt(26);

    add(CustomParticle(position: ListPositions.position(size)[randomNum]));
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    if (event.logicalKey != ListKeyBoard.listKey[randomNum]) {
      if (ListKeyBoard.listKey.contains(event.logicalKey)) {
        if (!isChainExist && isKeyDown) {
          isChainExist = true;
          laserPath = LaserPath(
            startPoint: ListPositions.position(size)[randomNum],
            endPoint: ListPositions.position(size)[ListKeyBoard.listKey.indexOf(event.logicalKey)],
          );
          add(laserPath);
        } else if (isChainExist && !isKeyDown) {
          laserPath.removeFromParent();
          isChainExist = false;
          highlightLetter();
        }
      }
    }

    return super.onKeyEvent(event, keysPressed);
  }

  highlightLetter() {
    randomNum = Random().nextInt(26);
    add(CustomParticle(position: ListPositions.position(size)[randomNum]));
    spawnBoxPlatform();
  }

  updateScore() {
    score++;
    scoreBoard.textComponent.text = score.toString();
  }

  spawnBoxPlatform() {
    /// min X = 0
    /// max X = size.x - 2
    /// min Y = 1
    /// max Y = size.y * 2/5

    add(BoxPlatform(
      Vector2(
        doubleInRange(0, camera.gameSize.x - 2),
        doubleInRange(1, camera.gameSize.y * 2 / 5),
      ),
    ));
  }
}
