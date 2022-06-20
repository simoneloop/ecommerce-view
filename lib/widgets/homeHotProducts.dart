import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../entities/Product.dart';
import '../widgets/ProductCard.dart';
import '../managers/Proxy.dart';

class homeHotProducts extends StatelessWidget {
  const homeHotProducts({
    Key? key,
     required this.data,
  }) : super(key: key);
  final Future<List<Product>> data;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      constraints:BoxConstraints(minWidth:size.width,minHeight: size.height/4,maxWidth: size.width,maxHeight: size.height/4),
      child: FutureBuilder(future: data,
        builder: (BuildContext ctx, AsyncSnapshot<List> snapshot){
          if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
            return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
              child: ListView.builder(

                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context,i){
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                          constraints:BoxConstraints(maxWidth:200,maxHeight: 220),
                          child: FittedBox(
                              fit: BoxFit.fill,
                              child: ProductCard(product: snapshot.data![i], press: (){},actions: [IconButton(onPressed: (){}, icon: Icon(Icons.wifi_tethering)),IconButton(onPressed: (){}, icon: Icon(Icons.add_shopping_cart))]))),
                    );
                  }),
            );
          }
          else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}