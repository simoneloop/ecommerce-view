import 'package:ecommerce_view/entities/ProductInPurchase.dart';
import 'package:ecommerce_view/pages/DetailsPage.dart';
import 'package:flutter/material.dart';
import '../managers/Proxy.dart';
class PIPCard extends StatefulWidget {
  final ProductInPurchase pip;
  final Function callback;

  const PIPCard({Key? key, required this.pip, required this.callback}) : super(key: key);
  @override
  _PIPCardState createState() => _PIPCardState();
}

class _PIPCardState extends State<PIPCard> {
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
            width: double.infinity,

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
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth:100,maxHeight: 100),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(16),bottomLeft: Radius.circular(16)),
                        child: Image.network("https://picsum.photos/300")),
                  ),
                ),
                Text(widget.pip.buyed.name,style: Theme.of(context).textTheme.headline4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text("${widget.pip.buyed.price}€",style: Theme.of(context).textTheme.headline4,),
                ),
                CartCounter(callback: widget.callback,pip: widget.pip)
              ],
            ),
          )
        ],
      ),
    );
  }

}

class CartCounter extends StatefulWidget {
  const CartCounter({
    Key? key,
    required this.pip, required this.callback,
  }) : super(key: key);
  final ProductInPurchase pip;
  final Function callback;

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

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(

          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildOutlinedButton(
                  icon: Icons.remove,
                  press: () {
                    setState(() {
                      if (numOfItems > 1) {

                        numOfItems--;
                        Proxy.sharedProxy.setQuantity(widget.pip.buyed.name, numOfItems).then((value){callback();});
                        callback();
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
      ),
    );
  }
    ClipRRect buildOutlinedButton(
        {required IconData icon, required Function() press}) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF0D47A1),
                      Color(0xFF1976D2),
                      Color(0xFF42A5F5),
                    ],
                  ),
                ),
              ),
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