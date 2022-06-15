import 'package:ecommerce_view/Uti/Consts.dart';
import 'package:ecommerce_view/widgets/AppBarWidget.dart';
import 'package:flutter/material.dart';

import '../entities/Product.dart';
import '../widgets/ProductDetailsBody.dart';

class DetailsPage extends StatelessWidget {
  final Product product;

  const DetailsPage({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(leadingFunction:()=> {Navigator.pop(context),print("ciao")},),
      body:Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF0D47A1),
                Color(0xFF1976D2),
                Color(0xFF42A5F5),
              ],
            ),
          ),
          child: SingleChildScrollView(child: ProductDetailsBody(product: product,))),
    );
  }
}
