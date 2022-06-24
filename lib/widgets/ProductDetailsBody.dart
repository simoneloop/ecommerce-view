import 'package:ecommerce_view/Uti/Consts.dart';
import 'package:ecommerce_view/managers/Proxy.dart';
import 'package:ecommerce_view/widgets/CoolText.dart';
import 'package:ecommerce_view/widgets/CoolTextButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Uti/Support.dart';
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
                  margin: EdgeInsets.only(top: size.height * 0.45),
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

                      CoolText(text:"${product.name}", size: "m",color: Colors.white,),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CoolText(text:"Prezzo\n${product.price}€\nDisponibilità\n${product.quantity}pz", size: "m",color: Colors.white,),
                          /*CoolText(text: "Disponibile: ${product.quantity}pz", size: "m",color: Colors.white,),*/
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: InteractiveViewer(
                                  child: Container(
                                    child: product.urlPropic!=null?Image.network(product.urlPropic):Image.network("https://picsum.photos/300"),
                                    /*constraints: BoxConstraints(maxHeight: 200),*/
                                  ),
                                )),
                          )
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(top:10,bottom: 30,left: 10,right:10),
                          child: CoolText(text: product.description, size: 'm',)),
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
                              showCoolSnackbar(context,"prodotto aggiunto con successo","ok");

                            }
                            else if(value==addToCartResult.quantityUnavailable){
                              showCoolSnackbar(context,"Non puoi aggiungere al carrello più della quantità disponibile","err");

                            }
                            else{
                              showCoolSnackbar(context,"errore sconosciuto","err");
                            }
                          });


                        }
                        else{
                          Navigator.pushNamed(context, "LoginPage");
                          showCoolSnackbar(context,Consts.REQUIRED_LOGIN_EXCEPTION,"err");

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
                        child: CoolTextButton(text: 'Compra ora',press: (){

                          if(Proxy.appState.getValue(Consts.USER_LOGGED_DETAILS)!=null){

                            Proxy.sharedProxy.setQuantity(widget.product.name,numOfItems).then((value) {
                              if(value==addToCartResult.setted){
                                Navigator.pushNamed(context, "UserCartPage");
                              }
                              else if(value==addToCartResult.quantityUnavailable){
                                showCoolSnackbar(context,"Non puoi aggiungere al carrello più della quantità disponibile","err");

                              }
                              else{
                                showCoolSnackbar(context,"errore sconosciuto","err");
                              }
                            });


                          }
                          else{
                            Navigator.pushNamed(context, "LoginPage");
                            showCoolSnackbar(context,Consts.REQUIRED_LOGIN_EXCEPTION,"err");
                          }},gradient: Consts.kBlueGradient,),
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
