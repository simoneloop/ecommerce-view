import 'package:flutter/material.dart';

import '../Uti/Consts.dart';
import '../Uti/Support.dart';
import '../managers/Proxy.dart';
class SearchForm extends StatelessWidget {
  final Function(String value) press;


  const SearchForm({Key? key, required this.press}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              /*padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),*/
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                        offset: Offset(0, 10),
                        blurRadius: 20)
                  ]),

              child: TextFormField(
                style: getTextStyle(size: Consts.smallText),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) {press(value);},
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    hintStyle: getTextStyle(size: Consts.smallText),
                    hintText: "Cerca prodotto per nome",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.transparent)),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Consts.kBlueColor,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
