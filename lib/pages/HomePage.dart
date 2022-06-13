import 'package:ecommerce_view/widgets/AppBarWidget.dart';
import 'package:flutter/material.dart';

import '../Uti/Consts.dart';
import '../entities/Product.dart';
import '../managers/Proxy.dart';
import '../widgets/ProductCard.dart';
import 'DetailsPage.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Product pr=Product(quantity:10, description: "Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", name: 'product1', price: 3.14, typo: 'bracciale', hot: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBarWidget(index: 0,),
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text("Prodotti in vetrina",style: Theme.of(context).textTheme.headline3,)),
          ),
          Container(
              constraints:BoxConstraints(maxWidth: 200,maxHeight: 200),
              child: FittedBox(
                  fit:BoxFit.fill ,
                  child: ProductCard(product: pr, press: ()=>{Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(product: pr,)))},actions: [IconButton(onPressed: (){}, icon: Icon(Icons.wifi_tethering)),IconButton(onPressed: (){}, icon: Icon(Icons.add_shopping_cart))],)))
          /*Container(
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
          )*/
        ],
      ),
    );
  }
}



