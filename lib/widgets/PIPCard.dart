import 'package:ecommerce_view/Uti/Consts.dart';
import 'package:ecommerce_view/entities/ProductInPurchase.dart';
import 'package:ecommerce_view/pages/DetailsPage.dart';
import 'package:flutter/material.dart';
import '../managers/Proxy.dart';
import 'CoolText.dart';
class PIPCard extends StatefulWidget {
  final ProductInPurchase pip;
  final Function callback;


  const PIPCard({Key? key, required this.pip, required this.callback}) : super(key: key);
  @override
  _PIPCardState createState() => _PIPCardState();
}
enum ProductStatus{
  available,
  unavailable,
  lessAvailable,
}

class _PIPCardState extends State<PIPCard> {
  ProductStatus productStatus=ProductStatus.available;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.pip.buyed.quantity==0){
      productStatus=ProductStatus.unavailable;
    }
    else if(widget.pip.quantity>widget.pip.buyed.quantity){
      productStatus=ProductStatus.lessAvailable;
    }
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(product: widget.pip.buyed)));
      },
      child: Stack(
        children: [
          Container(


            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                      offset: Offset(0, 10),
                      blurRadius: 20)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  constraints: BoxConstraints(maxWidth:100,maxHeight: 100),
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(16),bottomLeft: Radius.circular(16)),
                      child: widget.pip.buyed.urlPropic!=null?Image.network(widget.pip.buyed.urlPropic):Image.network("https://picsum.photos/300")),
                ),
                CoolText(text:widget.pip.buyed.name, size: "s"),
                Text("${widget.pip.buyed.price}€",style: Theme.of(context).textTheme.headline4,),
                CoolText(text:"Disponibilità: ${widget.pip.buyed.quantity}pz", size: "s"),
                  alert(productStatus),
                  CartCounter(callback: widget.callback,pip: widget.pip,productStatus:productStatus),
              ],

            ),
          )
        ],
      ),
    );
  }
  Column alert(ProductStatus ps){
     if(ps==ProductStatus.unavailable){
       return Column(
         children: [
           Icon(Icons.warning_amber_outlined,color: Colors.red,),
           CoolText(text: "prodotto non più disponibile", size: "s",color: Colors.red,),
         ],
       );
     }
     else if(ps==ProductStatus.available){
       return Column(
         children: [
           Icon(Icons.warning_amber_outlined,color: Colors.transparent,),
           CoolText(text: "prodotto non più disponibile", size: "s",color: Colors.transparent,),
         ],
       );
     }
     else{
       return Column(
         children: [
           Icon(Icons.warning_amber_outlined,color: Colors.amber,),
           CoolText(text: "quantità non disponibile", size: "s",color: Colors.amber,),
         ],
       );
     }
  }

}

class CartCounter extends StatefulWidget {
  const CartCounter({
    Key? key,
    required this.pip, required this.callback, required this.productStatus,
  }) : super(key: key);
  final ProductInPurchase pip;
  final Function callback;
  final ProductStatus productStatus;

  @override
  _CartCounterState createState() => _CartCounterState(callback:callback);
}
class _CartCounterState extends State<CartCounter> {
  int numOfItems=1;
  final Function callback;

  _CartCounterState({required this.callback});
  @override
  void initState() {
    numOfItems=widget.pip.quantity;
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(

        child: widget.productStatus==ProductStatus.unavailable?Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildOutlinedButton(
                productStatus: widget.productStatus,
                icon: Icons.remove,
                press: () {
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                  "0".padLeft(2, "0"),
                style: Theme
                    .of(context)
                    .textTheme
                    .headline4,
              ),
            ),
            buildOutlinedButton(

                productStatus: widget.productStatus,
                icon: Icons.add,
                press: () {
                }),
            IconButton(onPressed: (){
              Proxy.sharedProxy.removeFromMyCart(widget.pip.buyed.name).then((value) {callback();});
            }, icon: Icon(Icons.delete,color: Colors.red,))
          ],
        ):Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildOutlinedButton(
                productStatus: widget.productStatus,
                icon: Icons.remove,
                press: () {
                  setState(() {
                    if (numOfItems > 1) {

                      numOfItems--;
                      Proxy.sharedProxy.setQuantity(widget.pip.buyed.name, numOfItems).then((value){callback();});
                      /*callback();*/
                    }
                  });
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                numOfItems.toString().padLeft(2, "0"),
                style: Theme
                    .of(context)
                    .textTheme
                    .headline4,
              ),
            ),
            buildOutlinedButton(
                productStatus: widget.productStatus,
                icon: Icons.add,
                press: () {
                  if (numOfItems < widget.pip.buyed.quantity) {
                    setState(() {
                      numOfItems++;
                      Proxy.sharedProxy.setQuantity(widget.pip.buyed.name, numOfItems).then((value) {callback();});
                    });
                  }
                }),
            IconButton(onPressed: (){
              Proxy.sharedProxy.removeFromMyCart(widget.pip.buyed.name).then((value) {callback();});
              }, icon: Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
    ClipRRect buildOutlinedButton(
        {required IconData icon, required Function() press,required ProductStatus productStatus}) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: productStatus==ProductStatus.unavailable?Container(
                decoration: const BoxDecoration(
                    gradient: Consts.kOrangeGradient
                ),
              ):Container(
                decoration: const BoxDecoration(
                  gradient: Consts.kBlueGradient
                ),
              )
            ),
            IconButton(
                onPressed: press,
                icon: Icon(
                  icon,
                  color: Colors.white,
                ))
          ],
        ),
      );
  }
}