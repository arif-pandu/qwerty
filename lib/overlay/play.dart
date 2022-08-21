import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:qwerty/model/custom_button.dart';
import 'package:qwerty/screen/main_game.dart';
import 'package:url_launcher/url_launcher.dart';

class PlayMenu extends StatelessWidget {
  const PlayMenu({
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
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "QWERTY",
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
                      text: "PLAY",
                      onTap: () {
                        game.overlays.remove("menu");
                        game.resetGame();
                        game.playGame();
                      },
                    ),
                    CustomButton(
                      game: game,
                      text: "GUIDE",
                      onTap: () {
                        customDialog(
                          context,
                          [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: ListView(
                                  children: const [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Text(
                                      "The Virtual Keyboard will indicate the selected letter\nAnd then you must press another letter(not same with indicated one) to make a straight line\nKeep the ball bouncing and get score as much as possible",
                                      style: TextStyle(fontSize: 20, color: Color(0xff1a1a1a)),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      "DON'T Let the ball touch ground",
                                      style: TextStyle(fontSize: 20, color: Color(0xff1a1a1a)),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    CustomButton(
                      game: game,
                      text: "ABOUT ME",
                      onTap: () {
                        customDialog(
                          context,
                          [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "My Name is Arif Pandu\nFlutter Developer",
                                      style: TextStyle(fontSize: 20, color: Color(0xff1a1a1a)),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 30),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        hoverColor: Colors.transparent,
                                        onTap: () async {
                                          await launchUrl(
                                            Uri.parse("https://twitter.com/mapen_"),
                                          );
                                        },
                                        child: Text(
                                          "Find me on Twitter @mapen_",
                                          style: TextStyle(fontSize: 20, color: Color(0xff1a1a1a)),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
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

  customDialog(BuildContext context, List<Widget> children) {
    return showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.height * 0.5,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      ...children,
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(top: 10, left: 10),
                          child: Material(
                            child: InkWell(
                              hoverColor: Colors.lightBlue,
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Ink(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xff1a1a1a),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
