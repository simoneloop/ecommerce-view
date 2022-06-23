import 'package:flutter/material.dart';

import '../Uti/Consts.dart';

class CoolText extends StatelessWidget {
  final String text;
  final String size;
  final Color? color;



  const CoolText({Key? key, required this.text, required this.size,this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(size=='s'){
      return Text(text,style: Consts.smallTextStyle.copyWith(color: color != null?color:null),);
    }
    else if(size=="m"){
      return Text(text,style: Consts.mediumTextStyle.copyWith(color: color != null?color:null),);
    }
    else if(size=="b"){
      return Text(text,style: Consts.bigTextStyle.copyWith(color: color != null?color:null),);
    }else{
      return Text(text,style: Consts.mediumTextStyle.copyWith(color: color != null?color:null),);
    }

  }
}
