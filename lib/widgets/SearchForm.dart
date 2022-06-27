import 'package:flutter/material.dart';

import '../Uti/Consts.dart';
import '../Uti/Support.dart';
import '../managers/Proxy.dart';
class SearchForm extends StatelessWidget {
  final Function(String value) press;
  final double widthFactor;


  const SearchForm({Key? key, required this.press, required this.widthFactor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
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
                      color: Theme.of(context).colorScheme.secondary,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
