import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  bool isFav= false;
  putIsFav(fav){
    this.isFav = fav;
    notifyListeners();
  }

  removeFromFav(){
    this.isFav = false;
    notifyListeners();
  }
}