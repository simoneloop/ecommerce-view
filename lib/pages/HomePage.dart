import 'package:ecommerce_view/widgets/AppBarWidget.dart';
import 'package:flutter/material.dart';

import '../Uti/Consts.dart';
import '../entities/Product.dart';
import '../widgets/ProductCard.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Product pr=Product(quantity: 2, description: "simpleProduct", name: 'product1', price: 3.14, typo: 'bracciale', hot: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBarWidget(index: 0,),
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text("Prodotti in vetrina",style: Theme.of(context).textTheme.headline3,)),
          ),
          ProductCard(product: pr, press: (){},)
        ],
      ),
    );
  }
}



