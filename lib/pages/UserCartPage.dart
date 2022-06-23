import 'dart:ui';

import 'package:ecommerce_view/Uti/Consts.dart';
import 'package:ecommerce_view/entities/ProductInPurchase.dart';
import 'package:ecommerce_view/widgets/AppBarWidget.dart';
import 'package:ecommerce_view/widgets/CoolTextButton.dart';
import 'package:flutter/material.dart';

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



  @override
  void initState() {
    // TODO: implement initState
    /*if(!Proxy.appState.existsValue(Consts.USER_LOGGED_DETAILS)){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, "LoginPage");
      });
    }*/
    super.initState();
    userCart=Proxy.sharedProxy.getUserCart();
    cartModified();
    /*userCart.then((value) {
      List<ProductInPurchase> listPip=value;
      setState(() {
        listPip.forEach((element) {totale+=(element.buyed.price*element.quantity);});
      });
    });*/



  }


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(index: 2,),
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
                        return PIPCard(pip:snapshot.data![i],callback: cartModified,);
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
                            child: Text("Sembra che tu non abbia prodotti nel carrello",
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,),
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
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("totale: $totale",style: Theme.of(context).textTheme.headline3,),
                          CoolTextButton(text: "Compra tutto",gradient: Consts.kBlueGradient,press:  (){
                            userCart.then((value) {
                              if(value.length>0){
                                Proxy.sharedProxy.buyMyCart().then((value) {
                                  if(value==HttpResult.done){
                                    final snackBar=SnackBar(content: Text("Pagamento avvenuto con successo"));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    cartModified();
                                  }else if(value==HttpResult.notAmountException){
                                    final snackBar=SnackBar(content: Text("Pagamento rifiutato, probabilmente non abbastanza credito"));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                  else{
                                    final snackBar=SnackBar(content: Text("Problema sconosciuto"));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    cartModified();
                                  }

                                });
                              }
                              else{
                                final snackBar=SnackBar(content: Text("Carrello vuoto"));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
  double calcolaTotale(){
    totale=0.0;
    if(listPip!=null){
      setState(() {
        listPip.forEach((element) {
          totale+=element.buyed.price*element.quantity;
          totale=double.parse((totale).toStringAsFixed(2));
        });
      });

    }
    return totale;
  }
  void cartModified(){

    userCart=Proxy.sharedProxy.getUserCart();
    userCart.then((value) {
      List<ProductInPurchase> listPip=value;
      setState(() {
        totale=0.0;
        listPip.forEach((element) {
          totale+=element.buyed.price*element.quantity;
          totale=double.parse((totale).toStringAsFixed(2));
        });
      });
    });
  }
}
