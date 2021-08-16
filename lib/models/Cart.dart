import 'package:flutter/material.dart';
import 'package:shop_app/helper/LocalStorage/sp_helper.dart';
import 'package:shop_app/helper/backendHelper/SQLHelper.dart';

import 'Product.dart';
import 'Product.dart';

class Cart {
  int id;
  Product product;
  int numOfItem;
  String userId;
  String price;
  String name;
  String imageUrl;

  Cart( {this.id, this.userId, this.price, this.name, this.imageUrl, this.product, this.numOfItem});

  toMap() {
    return {
      SQLHelper.ID :this.id,
      SQLHelper.NAME: this.name,
      SQLHelper.PRICE: this.price ,
      SQLHelper.imageUrl: this.imageUrl ,
      SQLHelper.COUNT: this.numOfItem ,
    };
  }

  Cart.fromMap(Map map) {
    this.id = map['id'];
    this.name = map['name'];
    this.price = map['price'];
    this.imageUrl = map['imageUrl'];
    this.numOfItem = map['count'];
  }
}

// Demo data for our cart

List<Cart> demoCarts = [
  Cart(product: demoProducts[0], numOfItem: 2),
  Cart(product: demoProducts[1], numOfItem: 1),
  Cart(product: demoProducts[3], numOfItem: 1),
];
