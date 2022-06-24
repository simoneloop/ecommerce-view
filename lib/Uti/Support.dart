import 'package:flutter/material.dart';

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