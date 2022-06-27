import 'package:flutter/material.dart';

import '../Uti/Consts.dart';
import '../managers/Proxy.dart';
import 'CoolTextButton.dart';
class LogOutButton extends StatefulWidget {
  @override
  State<LogOutButton> createState() => _LogOutButtonState();
}

class _LogOutButtonState extends State<LogOutButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40,bottom: 30),
      child: CoolTextButton(gradient: Consts.PrimoGradient, text: "LOGOUT", press: (){logOut(); }),
    );
  }

  void logOut(){
    Proxy.appState.resetState();
    Navigator.pushNamed(context, "LoginPage");
  }
}
