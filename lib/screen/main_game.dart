import 'dart:async';
import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart' hide Timer;
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

  late Timer timer;

  @override
  Color backgroundColor() => const Color(0xff1a1a1a);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    var boundaries = createBoundaries(this);
    boundaries.forEach(add);
    add(ForbiddenWall());

    playerBall = PlayerBall();
    // add(playerBall);

    var letters = createLetters(size);
    letters.forEach(add);

    scoreBoard = ScoreBoard(score: score);
    add(scoreBoard);
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

  playGame() {
    add(playerBall);
    Future.delayed(const Duration(seconds: 3), () {
      spawnBoxPlatform();
      timer = Timer.periodic(
        const Duration(seconds: 5),
        (timer) {
          spawnBoxPlatform();
        },
      );
    });
    randomNum = Random().nextInt(26);
    add(CustomParticle(position: ListPositions.position(size)[randomNum]));
  }

  highlightLetter() {
    randomNum = Random().nextInt(26);
    add(CustomParticle(position: ListPositions.position(size)[randomNum]));
  }

  updateScore() {
    score++;
    scoreBoard.textComponent.text = score.toString();
  }

  spawnBoxPlatform() {
    /// min X = 2
    /// max X = size.x - 2
    /// min Y = 2
    /// max Y = size.y * 2/5

    add(BoxPlatform(
      Vector2(
        doubleInRange(2, camera.gameSize.x - 2),
        doubleInRange(2, camera.gameSize.y * 2 / 5),
      ),
    ));
  }

  gameOver() {
    pauseEngine();
    overlays.add("gameover");
  }
}
