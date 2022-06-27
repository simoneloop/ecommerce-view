import 'package:ecommerce_view/widgets/CoolIcon.dart';
import 'package:flutter/material.dart';
class CoolIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final Color colorShadow;
  final Function() press;

  const CoolIconButton({Key? key, required this.icon, required this.color, required this.size, required this.colorShadow, required this.press}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: press, icon:CoolIcon(size: size, icon: icon, colorShadow: colorShadow, color: color,));
  }
}
