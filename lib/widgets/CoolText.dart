import 'package:flutter/material.dart';

import '../Uti/Consts.dart';

class CoolText extends StatelessWidget {
  final String text;
  final String size;


  const CoolText({Key? key, required this.text, required this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(size=='s'){
      return Text(text,style: Consts.smallTextStyle,);
    }
    else if(size=="m"){
      return Text(text,style: Consts.mediumTextStyle,);
    }
    else if(size=="b"){
      return Text(text,style: Consts.bigTextStyle,);
    }else{
      return Text(text,style: Consts.mediumTextStyle,);
    }

  }
}
