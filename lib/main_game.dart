import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:qwerty/ball.dart';
import 'package:qwerty/letters.dart';
import 'package:qwerty/platform.dart';
import 'package:qwerty/wall.dart';

class MainGame extends Forge2DGame with HasTappables {
  MainGame()
      : super(
          gravity: Vector2.zero(),
          zoom: 1,
        );

  late PlayerBall playerBall;
  // late Letter letter;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    var boundaries = createBoundaries(this);
    boundaries.forEach(add);

    playerBall = PlayerBall();
    add(playerBall);

    var letters = createLetters(size);
    letters.forEach(add);
    // letter = Letter();
    // add(letter);
    // add(Platform(screenToWorld(size * camera.zoom / 2)));
  }
}
