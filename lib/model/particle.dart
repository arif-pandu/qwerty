import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qwerty/screen/main_game.dart';

class CustomParticle extends Component with HasGameRef {
  CustomParticle({required this.position});
  final Vector2 position;
  late ComputedParticle computedParticle;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    double halfCellSize = gameRef.camera.gameSize.x / 40;
    computedParticle = ComputedParticle(
      renderer: (canvas, particle) {
        return canvas.drawCircle(
          Offset.zero,
          particle.progress * halfCellSize,
          Paint()
            ..color = Color.lerp(
              Colors.white,
              Colors.amber,
              particle.progress,
            )!,
        );
      },
      lifespan: 1,
    );
    add(
      ParticleSystemComponent(
        position: position + ((Vector2(gameRef.camera.gameSize.x / 40, gameRef.camera.gameSize.x / 40)) / 2),
        particle: computedParticle,
      ),
    );
  }

  // Particle computedParticle() {
  //   return ComputedParticle(
  //     renderer: (canvas, particle) => canvas.drawCircle(
  //       Offset.zero,
  //       particle.progress * halfCellSize,
  //       Paint()
  //         ..color = Color.lerp(
  //           Colors.red,
  //           Colors.blue,
  //           particle.progress,
  //         )!,
  //     ),
  //   );
  // }
}
