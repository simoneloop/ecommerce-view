import 'dart:ui';

import 'package:ecommerce_view/widgets/AppBarWidget.dart';
import 'package:ecommerce_view/widgets/CoolText.dart';
import "package:flutter/material.dart";
import 'package:ecommerce_view/entities/Purchase.dart';

import '../managers/Proxy.dart';
import '../widgets/LogOutButton.dart';
import '../widgets/PurchaseCard.dart';
class BalancePage extends StatefulWidget {
  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  late Future<List<Purchase>> purchases;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    purchases=Proxy.sharedProxy.getAllPurchase();
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarWidget(index: 2,),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SingleChildScrollView(
        child:Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.only(bottom:10,left: 20,right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                            offset: Offset(0, 10),
                            blurRadius: 20)
                      ]),
                  child:Column(
                    children: [
                      LogOutButton(),
                      CoolText(text: "Ordini effettuati", size: "m"),
                      Container(
                        constraints:BoxConstraints(minWidth:size.width,minHeight: size.height/4,maxWidth: size.width,maxHeight: size.height),
                        child: FutureBuilder(
                            future: purchases,
                            builder: (BuildContext ctx, AsyncSnapshot<List> snapshot){
                              if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
                                return ScrollConfiguration(behavior: ScrollConfiguration.of(context).copyWith(
                                    dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context,i){
                                        return PurchaseCard(purchase:snapshot.data![i]);
                                      }),);
                              }
                              else{
                                return CircularProgressIndicator();
                              }
                            }),
                      )
                    ],
                  ),
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}
