import 'package:ecommerce_view/entities/Product.dart';
import 'package:ecommerce_view/pages/DetailsPage.dart';
import 'package:ecommerce_view/widgets/CoolText.dart';
import 'package:flutter/material.dart';

import '../Uti/Consts.dart';

class ProductCard extends StatefulWidget {
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
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isHover=false;
  Offset mousePos=new Offset(0, 0);
  double movFactor=0.98;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(
                  product: widget.product,
                )));
      },
      child: Container(
        decoration: widget.product.quantity>0?
          isHover?
            BoxDecoration(
              boxShadow:[
                BoxShadow(color: Consts.secondary_color,blurRadius: 3),
                BoxShadow(color: Consts.secondary_color,blurRadius: 6),
                BoxShadow(color: Consts.secondary_color,blurRadius: 9),
              ],
              gradient: Consts.PrimoGradient,borderRadius: BorderRadius.circular(16)):
            BoxDecoration(
                gradient: Consts.PrimoGradient,borderRadius: BorderRadius.circular(16))
          :isHover?
            BoxDecoration(
                boxShadow:[
                  BoxShadow(color: Consts.secondary_color,blurRadius: 3),
                  BoxShadow(color: Consts.secondary_color,blurRadius: 6),
                  BoxShadow(color: Consts.secondary_color,blurRadius: 9),
                ],
                gradient: Consts.SecondoGradient,borderRadius: BorderRadius.circular(16)):
            BoxDecoration(gradient: Consts.SecondoGradient,borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
              child: MouseRegion(
                onEnter:(e){
                  setState(() {
                    isHover=true;

                  });
                } ,
                onHover:(e){
                  setState(() {
                    mousePos+=e.delta*5;
                    mousePos*=movFactor;

                  });
                } ,
                onExit:(e){
                  setState(() {
                    isHover=false;

                  });
                } ,
                child: Container(
                  height: 300,
                  width: 300,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      backImage(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,top: 8,bottom: 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Container(
                          height: 50,
                          width: 200,
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: CoolText(text: widget.product.name,size: "s",color: Colors.white,)),
                        ),
                      ),
                      CoolText(text:widget.product.price.toString()+"€",size:"b",color:Colors.white,)

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  backImage(){
    ImageProvider imageP=widget.product.urlPropic!=null?NetworkImage(widget.product.urlPropic):NetworkImage("https://picsum.photos/300");
    return AnimatedPositioned(

      duration: Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
      top: isHover?-100-mousePos.dy:0,
      left: isHover?-100-mousePos.dx:-100,
      width: 500,
      height: isHover?600:300,
      child: Container(
        width: 500,
        height: 600,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitHeight,


            image: imageP
          )
        ),
      ),
    );
  }
}