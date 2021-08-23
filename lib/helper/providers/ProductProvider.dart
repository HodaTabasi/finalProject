import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<String> peoductFavIds = [];
  bool isFav = false;

  putIsFav(fav) {
    this.isFav = fav;
    notifyListeners();
  }

  removeFromFav() {
    this.isFav = false;
    notifyListeners();
  }

  resetProductId() {
    this.peoductFavIds = [];
  }
}
