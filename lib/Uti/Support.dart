import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
void showCoolSnackbar(BuildContext context,String text,String action){
  Color? col;
  if(action=="ok"){
    col=Colors.green;
  }
  else if(action=="err"){
    col=Colors.red;
  }
  final snackBar=SnackBar(
    content: Text(text,
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 30),),
    duration: Duration(seconds: 2),
    backgroundColor: col,
    shape: StadiumBorder(),
    behavior: SnackBarBehavior.floating,

  );
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
TextStyle getTextStyle({Color? color,double? size,FontWeight? fontWeight}){
  return GoogleFonts.abhayaLibre(
    fontSize:size!=null?size:25,
    fontWeight: fontWeight!=null?fontWeight:FontWeight.w400,
    color: color != null?color:Colors.black,
  );
}

