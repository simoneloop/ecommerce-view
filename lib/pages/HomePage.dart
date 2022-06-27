import 'dart:ui';

import 'package:ecommerce_view/widgets/AppBarWidget.dart';
import 'package:ecommerce_view/widgets/CoolText.dart';
import 'package:flutter/material.dart';

import '../Uti/Consts.dart';
import '../Uti/Support.dart';
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

  dynamic typoSelected = null;
  List<Product> _searchedProducts = [];
  TextEditingController _searchController = TextEditingController();
  String? _searchError = null;
  String _radioValue = "ascending";
  List<Product>? productsList = [];
  late Future<List<Product>> hots;
  int indexOfPage=0;
  bool isFirstPage=true;
  bool isLastPage=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Proxy.sharedProxy
        .getProductPageable(order: _radioValue, page: 0, pageSize: Consts.PAGE_SIZE)
        .then((value) => {
              setState(() {
                productsList = value['value'];
                isFirstPage=value['isFirstPage'];
                if(isFirstPage){
                  indexOfPage=0;
                }
                isLastPage=value['isLastPage'];
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child:CoolText(text: "Prodotti in vetrina",size: "m",)),
            ),
            homeHotProducts(data: hots),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: CoolText(text: "Cerca il prodotto perfetto per te", size: "m")),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 15),
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
                                      pageSize: Consts.PAGE_SIZE,
                                      typo: typoSelected)
                                      .then((value) => {
                                    setState(() {
                                      productsList = value['value'];
                                      isFirstPage=value['isFirstPage'];
                                      if(isFirstPage){
                                        indexOfPage=0;
                                      }
                                      isLastPage=value['isLastPage'];
                                    })
                                  });
                                });

                              })),
                    ),
                  ),
                  Flexible(
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            /*padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),*/
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).hintColor.withOpacity(0.2),
                                      offset: Offset(0, 10),
                                      blurRadius: 20)
                                ]),

                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (value) {
                                if(value.isEmpty){
                                  Proxy.sharedProxy
                                      .getProductPageable(
                                      order: _radioValue,
                                      page: 0,
                                      pageSize: Consts.PAGE_SIZE,
                                      typo: typoSelected)
                                      .then((value) => {
                                    setState(() {
                                      productsList = value['value'];
                                      isFirstPage=value['isFirstPage'];
                                      if(isFirstPage){
                                        indexOfPage=0;
                                      }
                                      isLastPage=value['isLastPage'];
                                    })
                                  });
                                }
                                else{
                                  Proxy.sharedProxy.getProductByName(
                                      value).then((value) {
                                    if(value!=getProductResult.notExist){
                                      setState(() {
                                        productsList=[value];
                                      });
                                    }
                                    else if(value==getProductResult.notExist){
                                      showCoolSnackbar(context,"Il prodotto non esiste","err");

                                    }
                                  });
                                }

                              },
                              controller: _searchController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  hintStyle: Consts.smallTextStyle,

                                  hintText: "Cerca prodotto per nome",
                                  errorText:
                                      _searchError != null ? _searchError : null,
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent)),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Consts.kBlueColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                                      pageSize: Consts.PAGE_SIZE,
                                      typo: typoSelected)
                                  .then((value) => {
                                        setState(() {
                                          productsList = value['value'];
                                          isFirstPage=value['isFirstPage'];
                                          if(isFirstPage){
                                            indexOfPage=0;
                                          }
                                          isLastPage=value['isLastPage'];
                                        })
                                      });
                            });
                          }),
                      CoolText(text: "Dal meno caro", size: "s")
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
                                      pageSize: Consts.PAGE_SIZE,
                                      typo: typoSelected)
                                  .then((value) => {

                                        setState(() {print(_radioValue);
                                        productsList = value['value'];
                                        isFirstPage=value['isFirstPage'];
                                        if(isFirstPage){
                                          indexOfPage=0;
                                        }
                                        isLastPage=value['isLastPage'];
                                        })
                                      });
                              /*_radioValue=value;*/
                            });
                          }),
                      CoolText(text: "Dal più caro", size: "s")
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
                                          ])),
                                );
                              }),
                        ),
                      )
                    : CircularProgressIndicator()
                : Stack(

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
                  child: Text("Sembra che non ci siano prodotti",
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center,),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isFirstPage?buildOutlinedButton(icon: Icons.arrow_back_ios_outlined):buildOutlinedButton(icon: Icons.arrow_back_ios_outlined, press: (){prevPage();}),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CoolText(text: "${indexOfPage+1}", size: "xs"),
                ),
                isLastPage?buildOutlinedButton(icon: Icons.arrow_forward_ios_outlined):buildOutlinedButton(icon: Icons.arrow_forward_ios_outlined, press: (){nextPage();}),
              ],
            )
          ],
        ),
      ),
    );
  }
  nextPage(){

    Proxy.sharedProxy
        .getProductPageable(
        order: _radioValue,
        page: indexOfPage+=1,
        pageSize: Consts.PAGE_SIZE,
        typo: typoSelected)
        .then((value) => {
      setState(() {
        productsList = value['value'];
        isFirstPage=value['isFirstPage'];
        if(isFirstPage){
          indexOfPage=0;
        }
        isLastPage=value['isLastPage'];
      })
    });
  }
  prevPage(){

    Proxy.sharedProxy
        .getProductPageable(
        order: _radioValue,
        page: indexOfPage-=1,
        pageSize: Consts.PAGE_SIZE,
        typo: typoSelected)
        .then((value) => {
      setState(() {
        productsList = value['value'];
        isFirstPage=value['isFirstPage'];
        if(isFirstPage){
          indexOfPage=0;
        }
        isLastPage=value['isLastPage'];
      })
    });
  }
  ClipRRect buildOutlinedButton(
      {required IconData icon,Function()? press}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child:press==null?Container(
              decoration: const BoxDecoration(
                gradient: Consts.kOrangeGradient
              ),
            ):Container(
              decoration: const BoxDecoration(
                gradient: Consts.kBlueGradient
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
