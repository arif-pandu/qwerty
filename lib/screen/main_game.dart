import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:qwerty/model/ball.dart';
import 'package:qwerty/model/ball.dart';
import 'package:qwerty/model/laser_path.dart';
import 'package:qwerty/model/letters.dart';
import 'package:qwerty/model/score.dart';
import 'package:qwerty/utils/list_keyboard.dart';
import 'package:qwerty/model/platform.dart';
import 'package:qwerty/utils/position.dart';
import 'package:qwerty/model/wall.dart';

class MainGame extends Forge2DGame with HasTappables, KeyboardEvents {
  MainGame() : super(gravity: Vector2.zero());

  bool isChainExist = false;

  // late TextComponent scoreText;
  int _score = 0;
  int get score => _score;
  set score(int value) {
    _score = value;
    // scoreText.text = value.toString();
  }

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
    // add(
    //   scoreText = TextComponent(
    //     text: score.toString(),
    //     anchor: Anchor.centerRight,
    //     position: Vector2(camera.gameSize.x - 2, 2),
    //     textRenderer: TextPaint(
    //       style: TextStyle(fontSize: 3, color: BasicPalette.white.color),
    //     ),
    //   ),
    // );

    Future.delayed(Duration(seconds: 0), () {
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

  updateScore() {
    score++;
    scoreBoard.textComponent.text = score.toString();
  }
}
