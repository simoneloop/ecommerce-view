import 'package:ecommerce_view/Uti/Consts.dart';
import 'package:ecommerce_view/managers/Proxy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../entities/Product.dart';

class ProductDetailsBody extends StatelessWidget {
  final Product product;

  const ProductDetailsBody({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  height: 500,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "over",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(color: Colors.white),
                      ),
                      Text(
                        product.name,
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(color: Colors.white),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Prezzo\n",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(color: Colors.white)),
                            TextSpan(
                                text: "${product.price}€",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    ?.copyWith(color: Colors.white))
                          ])),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  child: Image.network(
                                      "https://picsum.photos/300"),
                                  constraints: BoxConstraints(maxHeight: 200),
                                )),
                          )
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(top:10,bottom: 30,left: 10,right:10),
                          child: Text(
                            product.description,
                            style: Theme.of(context).textTheme.headline3,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CartCounter(
                            product: product,
                          ),
                        ],
                      ),

                    ],
                  ),
                )
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
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    widget.product;
    return FittedBox(
      fit: BoxFit.contain,
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Row(
              children: [
                buildOutlinedButton(
                    icon: Icons.remove,
                    press: () {
                      setState(() {
                        if (numOfItems > 1) {
                          numOfItems--;
                        }
                      });
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    numOfItems.toString().padLeft(2, "0"),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                buildOutlinedButton(
                    icon: Icons.add,
                    press: () {
                      if (numOfItems < widget.product.quantity) {
                        setState(() {
                          numOfItems++;
                        });
                      }
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 60,top: 50),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                            width: 2, color: Consts.kBlueColor)),
                    child: IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        if(Proxy.appState.getValue(Consts.USER_LOGGED_DETAILS)!=null){

                          Proxy.sharedProxy.addToCart(widget.product.name,numOfItems).then((value) {
                            if(value==addToCartResult.added){
                              final snackBar=SnackBar(content: Text("prodotto aggiunto con successo"));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                            else if(value==addToCartResult.quantityUnavailable){
                              final snackBar=SnackBar(content: Text("Non puoi aggiungere al carrello più della quantità disponibile"));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                            else{
                              final snackBar=SnackBar(content: Text("errore sconosciuto"));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          });


                        }
                        else{
                          Navigator.pushNamed(context, "LoginPage");
                          final snackBar=SnackBar(content: Text(Consts.REQUIRED_LOGIN_EXCEPTION));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }

                        },
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(

                            gradient: Consts.kBlueGradient
                        ),
                        child: TextButton(
                          child: Text(
                            "BUY NOW",
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
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
