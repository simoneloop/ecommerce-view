import 'package:flutter/material.dart';

import '../Uti/Consts.dart';
import 'CoolText.dart';

class CoolTextButton extends StatelessWidget {
  const CoolTextButton({Key? key, required this.gradient, required this.text, required this.press,this.height,this.width, this.textStyle}) : super(key: key);

  final Function() press;
  final LinearGradient gradient;
  final String text;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
            width:width!=null?width: 300,
            height:height!=null?height: 50,
            decoration: BoxDecoration(
              gradient: gradient,
            ),
            child: TextButton(onPressed: press, child:CoolText(text:text,size: "m",textStyle:textStyle != null?textStyle: null,color:Theme.of(context).primaryColor,) )));
  }
}
