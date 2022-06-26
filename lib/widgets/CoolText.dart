import 'package:flutter/material.dart';

import '../Uti/Consts.dart';

class CoolText extends StatelessWidget {
  final String text;
  final String size;
  final Color? color;
  final TextStyle? textStyle;
  final TextAlign? textAlign;



  const CoolText({Key? key, required this.text, required this.size, this.textStyle,this.color, this.textAlign}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(size=='s'){
      return Text(text,textAlign: textAlign,style:textStyle!=null?textStyle: Consts.smallTextStyle.copyWith(color: color != null?color:null),);
    }
    if(size=='xs'){
      return Text(text,textAlign: textAlign,style:textStyle!=null?textStyle: Consts.extraSmallTextStyle.copyWith(color: color != null?color:null),);
    }
    else if(size=="m"){
      return Text(text,textAlign: textAlign,style:textStyle!=null?textStyle: Consts.mediumTextStyle.copyWith(color: color != null?color:null),);
    }
    else if(size=="b"){
      return Text(text,textAlign: textAlign,style:textStyle!=null?textStyle: Consts.bigTextStyle.copyWith(color: color != null?color:null),);
    }else{
      return Text(text,textAlign: textAlign,style:textStyle!=null?textStyle: Consts.mediumTextStyle.copyWith(color: color != null?color:null),);
    }

  }
}
