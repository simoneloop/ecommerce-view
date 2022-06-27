import 'package:flutter/material.dart';

import '../Uti/Consts.dart';
import '../Uti/Support.dart';

class CoolText extends StatelessWidget {
  final String text;
  final String size;
  final Color? color;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;



  const CoolText({Key? key, required this.text, required this.size, this.textStyle,this.color, this.textAlign, this.fontWeight}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(size=='s'){
      return Text(text,textAlign: textAlign,style:textStyle!=null?textStyle:getTextStyle(color:color!=null?color:null,size: Consts.smallText),);
    }
    if(size=='xs'){
      return Text(text,textAlign: textAlign,style:textStyle!=null?textStyle: getTextStyle(color:color!=null?color:null,size: Consts.extraSmallText),);
    }
    else if(size=="m"){
      return Text(text,textAlign: textAlign,style:textStyle!=null?textStyle: getTextStyle(color:color!=null?color:null,size: Consts.mediumText),);
    }
    else if(size=="b"){
      return Text(text,textAlign: textAlign,style:textStyle!=null?textStyle: getTextStyle(color:color!=null?color:null,size: Consts.bigText),);
    }else{
      return Text(text,textAlign: textAlign,style:textStyle!=null?textStyle:getTextStyle(color:color!=null?color:null,size: Consts.mediumText),);
    }

  }
}