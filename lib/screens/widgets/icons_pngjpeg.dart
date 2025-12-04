import 'package:flutter/material.dart';

class AnyIcon extends StatelessWidget {
  final String assetPath;
  final double size;
  final double scale;
  final bool mirrored;

  const AnyIcon({
    super.key,
    required this.assetPath,
    this.size = 24,
    this.scale = 1.0,
    this.mirrored = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget icon = Image.asset(
      assetPath,
      fit: BoxFit.contain,
    );

    if (mirrored) {
      icon = Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(3.1416),
        child: icon,
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: Transform.scale(
        scale: scale,
        child: icon,
      ),
    );
  }
}
