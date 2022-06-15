import 'package:flutter/material.dart';

import '../Uti/Consts.dart';
class Categories extends StatefulWidget {
  final Function callback;

  const Categories({Key? key, required this.callback}) : super(key: key);
  @override
  _CategoriesState createState() => _CategoriesState(callback: callback);
}

class _CategoriesState extends State<Categories> {
  List<String> categories = ["Tutti i prodotti","Bracciali", "Collane", "Orecchini"];
  int selectedIndex = 0;
  final Function callback;

  _CategoriesState({required this.callback});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SizedBox(
          height: 25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) => buildCategory(index),
          )),
    );
  }

  Widget buildCategory(int index) =>
      GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
            callback(categories[index]);
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(categories[index],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: selectedIndex == index ? Colors.black : Consts
                          .kTextLightBlack
                  )
              ),
              Container(
                height: 2,
                width: 30,
                color: selectedIndex == index ? Colors.black : Colors
                    .transparent,
                margin: EdgeInsets.only(top: 2),
              )
            ],
          ),

        ),
      );
}