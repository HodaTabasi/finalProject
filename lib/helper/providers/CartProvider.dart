import 'package:flutter/material.dart';
import 'package:shop_app/models/Cart.dart';

class CartProvider extends ChangeNotifier {
  int listCount = 0;
  int total = 0;
  List<Cart> carts;

  setCartListCount(int categories) {
    listCount = categories;
    // notifyListeners();
  }

  // calculateTotalPrice(Cart cart) {
  //   int sum = 0;
  //   notifyListeners();
  // }

  setCart(List<Cart> cats) {
    this.carts = cats;
    int sum = 0;
    carts.forEach((element) {
      sum += int.parse(element.price) * element.numOfItem;
      total = sum;
    });
    // notifyListeners();
  }

  deleteFromList(int index) {
    carts.removeAt(index);
    int sum = 0;
    carts.forEach((element) {
      sum += int.parse(element.price) * element.numOfItem;
      total = sum;
    });
    listCount = carts.length;
    notifyListeners();
  }
}