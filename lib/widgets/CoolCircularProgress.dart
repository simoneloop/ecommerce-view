import 'package:flutter/material.dart';
class CoolCircularProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxHeight: 10,maxWidth: 10),
        child: CircularProgressIndicator());
  }
}
