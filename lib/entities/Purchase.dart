import 'package:ecommerce_view/entities/Product.dart';
import 'package:ecommerce_view/entities/User.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

Purchase purchaseFromJson(String str) => Purchase.fromJson(json.decode(str));

String purchaseToJson(Purchase data) => json.encode(data.toJson());

class Purchase {
  Purchase({
    this.id,
    required this.purchaseTime,
    required this.buyer,
    required this.buyed,
    required this.quantity,
    required this.fixedPrice,
    required this.done,
  });

  dynamic id;
  DateTime purchaseTime;
  User buyer;
  Product buyed;
  int quantity;
  double fixedPrice;
  bool done;

  factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
    id: json["id"],
    purchaseTime: DateTime.parse(json["purchaseTime"].split("T")[0]),//prendo solo il giorno, lo crea da solo con 00 come minuti
    buyer: User.fromJson(json["buyer"]),
    buyed: Product.fromJson(json["buyed"]),
    quantity: json["quantity"],
    fixedPrice: json["fixed_price"],
    done: json['done'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "purchaseTime": purchaseTime.toIso8601String(),
    "buyer": buyer.toJson(),
    "buyed": buyed.toJson(),
    "quantity": quantity,
    "fixed_price":fixedPrice,
    "done":done,
  };

  DateTime getPurchaseTime(){
    return purchaseTime;
  }
  @override
  String toString() {
    return "purhcase{when: "+purchaseTime.toString()+" buyer: "+buyer.toString()+" buyed: "+buyed.toString()+"quantity: "+quantity.toString()+" fixed_price: "+fixedPrice.toString()+" done:"+done.toString()+"}";
  }

}
