import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:qwerty/position.dart';

class Letter extends Component with Game {
  Letter({
    required this.index,
    required this.srcPosition,
  });

  final int index;
  final Vector2 srcPosition;

  SpriteComponent letter = SpriteComponent();
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addLetterA();
  }

  Future<void> addLetterA() async {
    Sprite letterA = await loadSprite("letter.png")
      // ..srcPosition = Vector2(0, 0)
      ..srcPosition = srcPosition
      ..srcSize = Vector2(50, 50);

    letter
      ..sprite = letterA
      ..position = ListPositions.position(size)[index]
      ..size = Vector2(size.x / 40, size.x / 40)
      ..debugMode = true;

    add(letter);
  }
}

List<Letter> createLetters(Vector2 size) {
  return [
    ...List.generate(
      ListPositions.position(size).length,
      (index) => Letter(
        index: index,
        srcPosition: Vector2(0, 50 * index.toDouble()),
      ),
    ),
  ];
}
