import 'package:ecommerce_view/entities/Purchase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class PurchaseCard extends StatefulWidget {
  final Purchase purchase;

  const PurchaseCard({Key? key, required this.purchase}) : super(key: key);
  @override
  _PurchaseCardState createState() => _PurchaseCardState();
}

class _PurchaseCardState extends State<PurchaseCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,

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
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius:BorderRadius.only(topLeft: Radius.circular(16),bottomLeft: Radius.circular(16)),
                    child: Image.network("https://picsum.photos/300")),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Prodotto",style:Theme.of(context).textTheme.headline3),
                      Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${widget.purchase.buyed.name}",style:Theme.of(context).textTheme.headline4),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text("${widget.purchase.buyed.price}€",style:Theme.of(context).textTheme.headline4),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Column(
                  children: [
                    Text("Quantità",style:Theme.of(context).textTheme.headline3),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text("${widget.purchase.quantity}",style:Theme.of(context).textTheme.headline4),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("Pagato",style:Theme.of(context).textTheme.headline3),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text("${widget.purchase.quantity*widget.purchase.buyed.price}€",style:Theme.of(context).textTheme.headline4),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("Data",style:Theme.of(context).textTheme.headline3),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text(formatData(widget.purchase.purchaseTime.toString()),style:Theme.of(context).textTheme.headline4),
                    ),
                  ],
                ),

              ],
            ),
          ),
        )
      ],
    );
  }
  String formatData(String data){
    List<String> ymd=data.split(" ")[0].split("-");
    String res="";
    res+=ymd[2]+"-";
    res+=ymd[1]+"-";
    res+=ymd[0];
    return res;
  }
}
