import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qwerty/overlay/gameover.dart';
import 'package:qwerty/overlay/play.dart';
import 'package:qwerty/screen/main_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GameWidget(
          game: MainGame(),
          overlayBuilderMap: {
            "menu": (BuildContext context, MainGame game) => PlayMenu(game: game),
            "gameover": (BuildContext context, MainGame game) => GameOver(game: game),
          },
          initialActiveOverlays: [
            "menu",
          ],
        ),
      ),
    );
  }
}
