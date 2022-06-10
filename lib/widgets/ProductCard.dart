import 'package:ecommerce_view/entities/Product.dart';
import 'package:flutter/material.dart';

import '../Uti/Consts.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
    required this.press
  }) : super(key: key);
  final Product product;
  final Function press;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Consts.BRACCIALE_COLOR,borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
              child: Image.network("https://picsum.photos/200")),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(product.name,style: Theme.of(context).textTheme.headline4,),
                ),
                Text("€324",style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.w900),)

              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*Material(
borderRadius: BorderRadius.circular(16),
clipBehavior: Clip.antiAliasWithSaveLayer,
child: Container(width:130,height: 60,child: Image.network("https://picsum.photos/200/100")))*/
/*Container(
height: 180,
width: 160,
decoration: BoxDecoration(color: Consts.BRACCIALE_COLOR,
borderRadius: BorderRadius.circular(16)),
child: Image.network("https://picsum.photos/100"),*/
