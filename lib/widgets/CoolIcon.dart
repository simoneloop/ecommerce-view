import 'package:flutter/material.dart';
class CoolIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final Color colorShadow;

  const CoolIcon({Key? key, required this.icon, required this.color, required this.size, required this.colorShadow}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      shadows: [
        Shadow(
          color: colorShadow,
          blurRadius: 3,
        ),
        Shadow(
          color: colorShadow,
          blurRadius: 6,
        ),
        Shadow(
          color: colorShadow,
          blurRadius: 9,
        )
      ],
      color: color,
      size:size,

    );
  }
}
