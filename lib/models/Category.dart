import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/screens/home/components/categories.dart';

class Category {
  String id;
  String name;
  String icon;

  Category({this.id, this.name, this.icon});

  Category.toMap(DocumentSnapshot<Map> snapshot){
    Map map = snapshot.data();
    this.id = map['id'];
    this.name = map['name'];
    this.icon = map['icon'];
  }
}