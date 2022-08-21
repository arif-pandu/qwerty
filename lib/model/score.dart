import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScoreBoard extends Component with HasGameRef {
  ScoreBoard({required this.score}) : super(priority: 9);
  int score;
  TextComponent textComponent = TextComponent();
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    textComponent
      ..anchor = Anchor.centerRight
      ..text = score.toString()
      ..position = Vector2(gameRef.camera.gameSize.x - 2, 2)
      ..textRenderer = TextPaint(
        style: TextStyle(fontSize: 3, color: BasicPalette.white.color),
      );

    add(textComponent);
  }
}



// TextComponent(text: 'Hello, Flame', textRenderer: _regular)
//         ..anchor = Anchor.topCenter
//         ..x = size.x / 2
//         ..y = 32.0,