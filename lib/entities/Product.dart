// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.typo,
    this.urlPropic,
    required this.hot,
  });

  dynamic id;
  String name;
  String description;
  int quantity;
  double price;
  String typo;
  dynamic urlPropic;
  bool hot;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    quantity: json["quantity"],
    price: json["price"],
    typo: json["typo"],
    urlPropic: json["urlPropic"],
    hot: json["hot"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "quantity": quantity,
    "price": price,
    "typo": typo,
    "urlPropic": urlPropic,
    "hot": hot,
  };

  @override
  String toString() {
    // TODO: implement toString
    return "product{name: "+name+" desc: "+description+" quantity: "+quantity.toString()+"\n  price: "+price.toString()+" typo: "+typo+" urlPropic: "+(urlPropic!=null?urlPropic:"")+" isHot: "+hot.toString()+"}";
  }
}
