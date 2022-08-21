import 'dart:ui';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:qwerty/model/custom_button.dart';
import 'package:qwerty/screen/main_game.dart';

class GameOver extends StatefulWidget {
  const GameOver({
    Key? key,
    required this.game,
  }) : super(key: key);

  final MainGame game;

  @override
  State<GameOver> createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  @override
  void initState() {
    playBGM();
    super.initState();
  }

  Future<void> playBGM() async {
    await FlameAudio.play("gameover.mp3");
    Future.delayed(Duration(seconds: 3), () {
      widget.game.pauseEngine();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.height * 0.5,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "GAMEOVER",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      game: widget.game,
                      text: "RESTART",
                      onTap: () async {
                        await widget.game.resetGame();
                        widget.game.overlays.remove("gameover");

                        widget.game.resumeEngine();
                        await widget.game.playGame();
                      },
                    ),
                    CustomButton(
                      game: widget.game,
                      text: "MENU",
                      onTap: () async {
                        await widget.game.resetGame();
                        widget.game.resumeEngine();
                        widget.game.overlays.remove("gameover");
                        widget.game.overlays.add("menu");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
