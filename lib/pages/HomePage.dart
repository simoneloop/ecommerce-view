import 'dart:ui';

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
  dynamic typoSelected = "bracciale";
  List<Product> _searchedProducts = [];
  TextEditingController _searchController = TextEditingController();
  String? _searchError = null;
  String _radioValue = "ascending";
  List<Product>? productsList = [];
  late Future<List<Product>> hots;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Proxy.sharedProxy
        .getProductPageable(order: _radioValue, page: 0, pageSize: 10)
        .then((value) => {
              setState(() {
                productsList = value;
              })
            });
    hots = Proxy.sharedProxy.getHotProduct();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          /*Container(
              constraints: BoxConstraints(maxWidth: 150, maxHeight: 150),
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
                  ))),*/
          homeHotProducts(data: hots),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 15),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Consts.kBlueColor))),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Container(
                          width: 1000,
                          child: Categories(
                              callback: (val){
                                if (val!="all") {
                                  typoSelected = val;}
                                else{
                                  typoSelected=null;}
                                setState(() {
                                  Proxy.sharedProxy
                                      .getProductPageable(
                                      order: _radioValue,
                                      page: 0,
                                      pageSize: 10,
                                      typo: typoSelected)
                                      .then((value) => {
                                    setState(() {
                                      productsList = value;
                                    })
                                  });
                                });

                              })),
                    ),
                  ),
                  Flexible(
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      child: Container(
                        width: 200,
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (value) {
                            Proxy.sharedProxy.getProductByName(
                                value).then((value) {
                                  if(value!=getProductResult.notExist){
                                    setState(() {
                                      productsList=[value];
                                    });
                                  }
                            }); /*Proxy.sharedProxy.getProductPageable(order:_radioValue,page: 0,pageSize: 10,typo: typoSelected);*/
                          },
                          controller: _searchController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: "Cerca prodotto per nome",
                              errorText:
                                  _searchError != null ? _searchError : null,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Consts.kTextLightBlack)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Consts.kBlueColor)),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Consts.kBlueColor,
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Radio(
                        value: "ascending",
                        groupValue: _radioValue,
                        onChanged: (value) {
                          setState(() {
                            _radioValue = value.toString();
                            Proxy.sharedProxy
                                .getProductPageable(
                                    order: _radioValue,
                                    page: 0,
                                    pageSize: 10,
                                    typo: typoSelected)
                                .then((value) => {
                                      setState(() {
                                        productsList = value;
                                      })
                                    });
                          });
                        }),
                    Text(
                      "Dal più economico",
                      style: Theme.of(context).textTheme.headline4,
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: "descending",
                        groupValue: _radioValue,
                        onChanged: (value) {
                          setState(() {
                            _radioValue = value.toString();
                            Proxy.sharedProxy
                                .getProductPageable(
                                    order: _radioValue,
                                    page: 0,
                                    pageSize: 10,
                                    typo: typoSelected)
                                .then((value) => {

                                      setState(() {print(_radioValue);
                                        productsList = value;
                                      })
                                    });
                            /*_radioValue=value;*/
                          });
                        }),
                    Text(
                      "Dal più caro",
                      style: Theme.of(context).textTheme.headline4,
                    )
                  ],
                )
              ],
            ),
          ),
          productsList != null
              ? productsList!.length > 0
                  ? Container(
                      constraints: BoxConstraints(
                          minWidth: size.width,
                          minHeight: size.height / 3,
                          maxWidth: size.width,
                          maxHeight: size.height / 3),
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse
                            }),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: productsList!.length,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: 200, maxHeight: 220),
                                    child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: ProductCard(
                                            product: productsList![i],
                                            press: () {},
                                            actions: [
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                      Icons.wifi_tethering)),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                      Icons.add_shopping_cart))
                                            ]))),
                              );
                            }),
                      ),
                    )
                  : CircularProgressIndicator()
              : CircularProgressIndicator()
        ],
      ),
    );
  }
}
