import 'package:ecommerce_view/managers/WebStorage.dart';
import 'package:flutter/material.dart';

import '../Uti/Consts.dart';
import '../Uti/Support.dart';
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
      child: CoolTextButton(gradient: Consts.PrimoGradient, text: "LOGOUT", press: (){logOut(context); }),
    );
  }


}
