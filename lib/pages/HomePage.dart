import 'package:ecommerce_view/widgets/AppBarWidget.dart';
import 'package:flutter/material.dart';

import '../Uti/Consts.dart';
import '../entities/Product.dart';
import '../managers/Proxy.dart';
import '../widgets/Categories.dart';
import '../widgets/ProductCard.dart';
import '../widgets/homeHotProducts.dart';
import 'DetailsPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Product pr = Product(
      quantity: 10,
      description:
          "Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      name: 'product1',
      price: 3.14,
      typo: 'bracciale',
      hot: true);
  String typoSelected="bracciali";
  List<Product> _searchedProducts=[];
  TextEditingController _searchController=TextEditingController();
  String _searchError="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        index: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              "Prodotti in vetrina",
              style: Theme.of(context).textTheme.headline3,
            )),
          ),
          Container(
              constraints: BoxConstraints(maxWidth: 200, maxHeight: 200),
              child: FittedBox(
                  fit: BoxFit.fill,
                  child: ProductCard(
                    product: pr,
                    press: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                    product: pr,
                                  )))
                    },
                    actions: [
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.add_shopping_cart,color: Colors.white,size: 20,))
                    ],
                  ))),
          /*homeHotProducts(),*/
          Categories(callback:(val)=>{typoSelected=val}),
          Center(

            child: Container(
              width: 200,
              child: TextFormField(
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value){Proxy.sharedProxy.getProductPageable(page: 0,pageSize: 10,typo: typoSelected);},
                controller: _searchController,
                keyboardType: TextInputType.name,

                decoration: InputDecoration(
                    hintText: "Cerca",
                    errorText: _searchError,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Consts.kBlueColor)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Consts.kBlueColor)),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Consts.kBlueColor,
                    )),
              ),
            ),
          ),


          /*homeHotProducts()*/
        ],
      ),
    );
  }
}



