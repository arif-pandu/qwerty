import 'package:flutter/material.dart';
import 'package:qwerty/screen/main_game.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.game,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final MainGame game;
  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          hoverColor: Colors.lightBlue,
          onTap: onTap,
          child: Ink(
            width: MediaQuery.of(context).size.width * 0.2,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xff1a1a1a),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
