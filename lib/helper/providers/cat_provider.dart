import 'package:flutter/material.dart';
import 'package:shop_app/models/Category.dart';

class CatProvider extends ChangeNotifier {

  List<Category> cat = [];
  setCategory(categories){
    this.cat = categories;
    notifyListeners();
  }

}