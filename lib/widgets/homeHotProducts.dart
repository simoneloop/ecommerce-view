import 'package:flutter/material.dart';
import '../widgets/ProductCard.dart';
import '../managers/Proxy.dart';

class homeHotProducts extends StatelessWidget {
  const homeHotProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:BoxConstraints(maxWidth: 700,maxHeight: 300),
      child: FutureBuilder(future: Proxy.sharedProxy.getHotProduct(),
        builder: (BuildContext ctx, AsyncSnapshot<List> snapshot){
          if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
            return ListView.builder(
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
                });
          }
          else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}