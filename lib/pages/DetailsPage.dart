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
      appBar: AppBarWidget(leadingFunction:()=> {Navigator.pop(context)},),
      body:Container(
          decoration: const BoxDecoration(
            gradient: Consts.PrimoGradient,
          ),
          child: SingleChildScrollView(child: ProductDetailsBody(product: product,))),
    );
  }
}
