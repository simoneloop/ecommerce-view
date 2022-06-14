import 'package:ecommerce_view/entities/Product.dart';
import 'package:flutter/material.dart';

import '../Uti/Consts.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
    this.press,
    this.actions
  }) : super(key: key);
  final Product product;
  final Function()? press;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: press,
      child: Container(
        decoration: BoxDecoration(gradient: Consts.kBlueGradient,borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
                child: Image.network("https://picsum.photos/300")),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,top: 8,bottom: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(product.name,style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.white),),
                      ),
                      Text(product.price.toString()+"€",style: Theme.of(context).textTheme.headline3?.copyWith(fontWeight: FontWeight.w900,color: Colors.white),)

                    ],
                  ),
                  if (actions!=null) Container(
                    margin: EdgeInsets.only(left: 70),
                    padding: const EdgeInsets.only(left: 10),
                    constraints:BoxConstraints(maxWidth: actions!.length*60.0,maxHeight: 30.0),
                    child: ListView.builder(
                        scrollDirection:Axis.horizontal,
                        itemCount:actions?.length,
                        itemBuilder: (context,i){final action=actions![i];return action;}),
                  )
                ],
              ),
            ),
          ],
        ),
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
