import 'package:flutter/material.dart';
class CoolIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final Color? colorShadow;

  const CoolIcon({Key? key, required this.icon, required this.color, required this.size, required this.colorShadow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double shadowIntensity=0;
    if(colorShadow!=null){
      shadowIntensity=6;
    }
    else{
      shadowIntensity=0;
    }
    return Icon(
      icon,
      shadows: [
        for(double i=0;i<shadowIntensity;i++)
          Shadow(
            color: colorShadow!,
            blurRadius: 3*i,
          ),
      ],
      color: color,
      size:size,

    );
  }
}
