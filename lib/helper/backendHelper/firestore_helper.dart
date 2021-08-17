import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/helper/LocalStorage/sp_helper.dart';
import 'package:shop_app/helper/providers/CartProvider.dart';
import 'package:shop_app/models/AppUser.dart';
import 'package:shop_app/models/Category.dart';
import 'package:shop_app/models/Order.dart';
import 'package:shop_app/models/Product.dart';
import 'package:provider/provider.dart';

class FireStoreHelper {
  FireStoreHelper._();

  static FireStoreHelper fireStoreHelper = FireStoreHelper._();
  FirebaseFirestore fbs = FirebaseFirestore.instance;

  Future<bool> saveUser(AppUser user) async {
    Future<bool> future = fbs
        .collection("Users")
        .doc(user.id)
        .set(user.toMap())
        .then((value) => true)
        .catchError((error) => false);

    return future;
  }

  Future<bool> saveUserComplete(AppUser user, id) async {
    Future<bool> future = fbs
        .collection("Users")
        .doc(id)
        .update(user.toMapCompleteProfile())
        .then((value) => true)
        .catchError((error) => false);

    return future;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(id) async {
    Future<DocumentSnapshot<Map<String, dynamic>>> document =
        fbs.collection("Users").doc(id).get();
    return document;
  }

  Future<List<Category>> getCat() async {
    QuerySnapshot<Map<String, dynamic>> doc =
        await fbs.collection("Categories").get();

    return doc.docs.map((e) {
      return Category.toMap(e);
    }).toList();
  }

  Future<List<Product>> getProduct(String catId) async {
    QuerySnapshot<Map<String, dynamic>> doc =
        await fbs.collection("Products").where('catId', isEqualTo: catId).get();
    return doc.docs.map((e) {
      return Product.toMap(e);
    }).toList();
  }

  Future<bool> addOrder(context){
    String userId = SPHelper.sp.sharedPreferences.getString("id");
    Order order = Order("", "${Provider.of<CartProvider>(context,listen: false).total}", userId, Provider.of<CartProvider>(context,listen: false).address);
    Future<bool> future = fbs
        .collection("Orders")
        .add(order.toMap())
        .then((value) => true)
        .catchError((error) => false);

    return future;
  }
}
