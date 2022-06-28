import 'package:ecommerce_view/widgets/CoolText.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../managers/Proxy.dart';
import '../managers/WebStorage.dart';
import 'Consts.dart';
void showCoolSnackbar(BuildContext context,String text,String action,{int? seconds}){
  Color? col;
  if(action=="ok"){
    col=Color(0xff00580a);
  }
  else if(action=="err"){
    col=Color(0xFF780B00);
  }
  else if(action=="tip"){
    col=Color(0xFF004078);
  }
  final snackBar=SnackBar(
    content: CoolText(text: text,size: "m",textAlign: TextAlign.center,),
    duration: Duration(seconds:seconds!=null?seconds: 2),
    backgroundColor: col,
    shape: StadiumBorder(),
    behavior: SnackBarBehavior.floating,

  );
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
TextStyle getTextStyle({Color? color,double? size,FontWeight? fontWeight}){
  return GoogleFonts.orbitron(
    fontSize:size!=null?size:25,
    fontWeight: fontWeight!=null?fontWeight:FontWeight.w400,
    color: color != null?color:Colors.white,
    shadows: [
      for(double i=0;i<Consts.shadow_intensity;i++)
        Shadow(
          color:color==Colors.transparent?Colors.transparent: Consts.secondary_color,
          blurRadius: 3*i
        )
    ]
  );
}
void logOut(BuildContext context){
  Proxy.appState.resetState();
  WebStorage.instance.eraseData();
  Navigator.pushNamed(context, "LoginPage");
}

