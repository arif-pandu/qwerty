import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';

class ListPositions {
  static List position(Vector2 size) => [
        /// ROW 1 QWERTY
        Vector2(
          size.x * 0.1 + (size.x * 0.8 * 0),
          size.y * 0.7,
        ),
        Vector2(
          size.x * 0.1 + (size.x * 0.8 * 1 / 9),
          size.y * 0.7,
        ),
        Vector2(
          size.x * 0.1 + (size.x * 0.8 * 2 / 9),
          size.y * 0.7,
        ),
        Vector2(
          size.x * 0.1 + (size.x * 0.8 * 3 / 9),
          size.y * 0.7,
        ),
        Vector2(
          size.x * 0.1 + (size.x * 0.8 * 4 / 9),
          size.y * 0.7,
        ),
        Vector2(
          size.x * 0.1 + (size.x * 0.8 * 5 / 9),
          size.y * 0.7,
        ),
        Vector2(
          size.x * 0.1 + (size.x * 0.8 * 6 / 9),
          size.y * 0.7,
        ),
        Vector2(
          size.x * 0.1 + (size.x * 0.8 * 7 / 9),
          size.y * 0.7,
        ),
        Vector2(
          size.x * 0.1 + (size.x * 0.8 * 8 / 9),
          size.y * 0.7,
        ),
        Vector2(
          size.x * 0.1 + (size.x * 0.8 * 9 / 9),
          size.y * 0.7,
        ),

        /// ROW 2 ASDF
        Vector2(
          size.x * 0.15 + (size.x * 0.7 * 0),
          size.y * 0.8,
        ),
        Vector2(
          size.x * 0.15 + (size.x * 0.7 * 1 / 8),
          size.y * 0.8,
        ),
        Vector2(
          size.x * 0.15 + (size.x * 0.7 * 2 / 8),
          size.y * 0.8,
        ),
        Vector2(
          size.x * 0.15 + (size.x * 0.7 * 3 / 8),
          size.y * 0.8,
        ),
        Vector2(
          size.x * 0.15 + (size.x * 0.7 * 4 / 8),
          size.y * 0.8,
        ),
        Vector2(
          size.x * 0.15 + (size.x * 0.7 * 5 / 8),
          size.y * 0.8,
        ),
        Vector2(
          size.x * 0.15 + (size.x * 0.7 * 6 / 8),
          size.y * 0.8,
        ),
        Vector2(
          size.x * 0.15 + (size.x * 0.7 * 7 / 8),
          size.y * 0.8,
        ),
        Vector2(
          size.x * 0.15 + (size.x * 0.7 * 8 / 8),
          size.y * 0.8,
        ),

        /// ROW 3 ZXCV
        Vector2(
          size.x * 0.2 + (size.x * 0.6 * 0),
          size.y * 0.9,
        ),
        Vector2(
          size.x * 0.2 + (size.x * 0.6 * 1 / 6),
          size.y * 0.9,
        ),
        Vector2(
          size.x * 0.2 + (size.x * 0.6 * 2 / 6),
          size.y * 0.9,
        ),
        Vector2(
          size.x * 0.2 + (size.x * 0.6 * 3 / 6),
          size.y * 0.9,
        ),
        Vector2(
          size.x * 0.2 + (size.x * 0.6 * 4 / 6),
          size.y * 0.9,
        ),
        Vector2(
          size.x * 0.2 + (size.x * 0.6 * 5 / 6),
          size.y * 0.9,
        ),
        Vector2(
          size.x * 0.2 + (size.x * 0.6 * 6 / 6),
          size.y * 0.9,
        ),
      ];

  static const List<int> listOffsetQwerty = [17, 23, 5, 18, 20, 25, 21, 9, 15, 16, 1, 19, 4, 6, 7, 8, 10, 11, 12, 26, 24, 3, 22, 2, 14, 13];
}
