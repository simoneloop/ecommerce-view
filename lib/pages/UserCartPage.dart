import 'dart:ui';

import 'package:ecommerce_view/Uti/Consts.dart';
import 'package:ecommerce_view/entities/ProductInPurchase.dart';
import 'package:ecommerce_view/widgets/AppBarWidget.dart';
import 'package:ecommerce_view/widgets/CoolText.dart';
import 'package:ecommerce_view/widgets/CoolTextButton.dart';
import 'package:flutter/material.dart';

import '../Uti/Support.dart';
import '../managers/Proxy.dart';
import '../managers/Proxy.dart';
import '../widgets/PIPCard.dart';
class UserCartPage extends StatefulWidget {
  const UserCartPage({Key? key}) : super(key: key);

  @override
  _UserCartPageState createState() => _UserCartPageState();
}


class _UserCartPageState extends State<UserCartPage> {
  late Future<List<ProductInPurchase>> userCart;
  double totale=0.0;
  late List<ProductInPurchase> listPip;
  bool isTotaleModified=false;
  bool isInit=false;
  bool isIncrementedByUser=false;



  @override
  void initState() {
    isInit=true;
    // TODO: implement initState
    if(!Proxy.appState.existsValue(Consts.USER_LOGGED_DETAILS)){
      WidgetsBinding.instance.addPostFrameCallback((_) {
       Proxy.sharedProxy.autoLogin(context,2);
      });
    }
    super.initState();
    cartModified();
  }


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(index: 2,),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Container(
        height: size.height,
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(minWidth:size.width,maxWidth: size.width,maxHeight: size.height/1.25),
              child: FutureBuilder(
              future: userCart,
              builder: (BuildContext ctx,AsyncSnapshot<List> snapshot){
              if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
                return ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
                  child:snapshot.data!.length>0?
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context,i){
                        return PIPCard(pip:snapshot.data![i],callback: (){isIncrementedByUser=true;cartModified();},);
                      }):
                      Stack(

                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).hintColor.withOpacity(0.2),
                                      offset: Offset(0, 10),
                                      blurRadius: 20)
                                ]),
                            child:CoolText(text:"Sembra che tu non abbia prodotti nel carrello" ,size: "m",textAlign: TextAlign.center,),
                          )
                        ],
                      )
                );
              }
              else{
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                );
              }
    },),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CoolText(text: "totale: $totale€", size: "m"),
                          CoolTextButton(text: "Compra tutto",gradient: Consts.PrimoGradient,press:  (){
                            userCart.then((value) {
                              if(value.length>0){
                                cartModified().then((value) {
                                  if(value==HttpResult.done){
                                    if(isTotaleModified){
                                      setState(() {
                                        isTotaleModified=false;
                                        showCoolSnackbar(context, "Attenzione, il totale è stato modificato controlla prima di cliccare di nuovo", "tip",seconds: 4);
                                      });
                                    }
                                    else{
                                      Proxy.sharedProxy.buyMyCart().then((value) {

                                        if(value==HttpResult.done){
                                          cartModified();
                                          showCoolSnackbar(context,"Pagamento avvenuto con successo","ok");

                                        }else if(value==HttpResult.notAmountException){
                                          showCoolSnackbar(context,"Pagamento rifiutato, probabilmente non abbastanza credito","err");
                                        }
                                        else if(value==HttpResult.cartIsEmpty){
                                          cartModified();
                                          showCoolSnackbar(context,"Il carrello è vuoto, forse qualche prodotto è stato eliminato","err");
                                        }
                                        else if(value==HttpResult.productDoesNotExist){
                                          cartModified();
                                          showCoolSnackbar(context,"Un prodotto che avevi nel carrello è stato recentemente eliminato","err");
                                        }
                                        else if(value==HttpResult.quantityUnavailable){
                                          /*userCart=Proxy.sharedProxy.getUserCart();
                                          userCart.then((value) {
                                            List<ProductInPurchase> listPip=value;
                                            setState(() {
                                              totale=0.0;
                                              listPip.forEach((element) {
                                                if(element.buyed.quantity==0){
                                                  totale+=0;
                                                }
                                                else{totale+=element.buyed.price*element.quantity;}
                                                totale+=element.buyed.price*element.quantity;
                                                totale=double.parse((totale).toStringAsFixed(2));
                                              });
                                            });
                                          });*/
                                          cartModified();
                                          showCoolSnackbar(context,"Acquisto rifiutato, probabilmente è cambiata la quantità disponibile del prodotto","err");

                                        }
                                        else{
                                          showCoolSnackbar(context,"Problema sconosciuto","err");
                                        }

                                      });

                                    }
                                  }
                                });
                                }
                                else{
                                  showCoolSnackbar(context,"Carrello vuoto","err");
                                }

                            });


                          },)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
  Future<HttpResult> cartModified()async {
    double newTotale=0.0;
    userCart=Proxy.sharedProxy.getUserCart();
    await userCart.then((value) {
      List<ProductInPurchase> listPip=value;
      setState(() {
        for (var element in listPip) {
          if(element.buyed.quantity==0){
            newTotale+=0;
          }
          else{newTotale+=element.buyed.price*element.quantity;}

          newTotale=double.parse((newTotale).toStringAsFixed(2));
        }
        if(isInit ){
          isInit=false;
          totale=newTotale;
          return ;
        }
        if(isIncrementedByUser){
          isIncrementedByUser=false;
          totale=newTotale;
          return;

        }

        if(totale!=newTotale){
          isTotaleModified=true;
          totale=newTotale;
        }
        totale=newTotale;

      });
      return HttpResult.done;
    });
    return HttpResult.done;
  }
}
