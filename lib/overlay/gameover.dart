import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:qwerty/model/custom_button.dart';
import 'package:qwerty/screen/main_game.dart';

class GameOver extends StatelessWidget {
  const GameOver({
    Key? key,
    required this.game,
  }) : super(key: key);

  final MainGame game;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: MediaQuery.of(context).size.width * 0.5,
          width: MediaQuery.of(context).size.width * 0.5,
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
                      game: game,
                      text: "RESTART",
                      onTap: () async {
                        await game.resetGame();
                        game.overlays.remove("gameover");

                        game.resumeEngine();
                        await game.playGame();
                      },
                    ),
                    CustomButton(
                      game: game,
                      text: "MENU",
                      onTap: () async {
                        await game.resetGame();
                        game.overlays.remove("gameover");
                        game.overlays.add("menu");
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
