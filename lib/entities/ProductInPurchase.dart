// To parse this JSON data, do
//
//     final purchase = purchaseFromJson(jsonString);

import 'package:ecommerce_view/entities/Product.dart';
import 'package:ecommerce_view/entities/User.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

ProductInPurchase purchaseFromJson(String str) => ProductInPurchase.fromJson(json.decode(str));

String purchaseToJson(ProductInPurchase data) => json.encode(data.toJson());

class ProductInPurchase {
  ProductInPurchase({
    this.id,
    required this.buyer,
    required this.buyed,
    required this.quantity,
  });

  dynamic id;
  User buyer;
  Product buyed;
  int quantity;

  factory ProductInPurchase.fromJson(Map<String, dynamic> json) => ProductInPurchase(
    id: json["id"],
    buyer: User.fromJson(json["buyer"]),
    buyed: Product.fromJson(json["buyed"]),
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "buyer": buyer.toJson(),
    "buyed": buyed.toJson(),
    "quantity": quantity,
  };

  @override
  String toString() {
    return "productInPurchase{buyer: "+buyer.toString()+" buyed: "+buyed.toString()+"quantity: "+quantity.toString()+"}";
  }
}

