import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/helper/LocalStorage/sp_helper.dart';
import 'package:shop_app/helper/backendHelper/auth_helper.dart';
import 'package:shop_app/helper/backendHelper/firestore_helper.dart';
import 'package:shop_app/helper/providers/cat_provider.dart';
import 'package:shop_app/helper/providers/user_provider.dart';
import 'package:shop_app/models/AppUser.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/Category.dart';
import 'package:shop_app/models/Product.dart';

class FirebaseHelper {
  FirebaseHelper._();

  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  Future<bool> saveUser(email, password, context) async {
    String id =
        await FireAuthHelper.fireAuthHelper.createAccount(email, password);
    if (id != null) {
      AppUser user = AppUser(id: id, email: email, password: password);
      bool boo = await FireStoreHelper.fireStoreHelper.saveUser(user);
      Provider.of<UserProvider>(context, listen: false).appUser = user;
      return boo;
    }
  }

  Future<bool> saveUserComplete(AppUser user, context) async {
    String id = Provider.of<UserProvider>(context, listen: false).appUser.id;

    bool boo = await FireStoreHelper.fireStoreHelper.saveUserComplete(user, id);
    Provider.of<UserProvider>(context, listen: false).saveCompleteProfile(user);
    return boo;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> Login(
      email, password, context) async {
    String id =
        await FireAuthHelper.fireAuthHelper.getUserAccount(email, password);
    if (id != null) {
      SPHelper.sp.sharedPreferences.setString("id", id);
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FireStoreHelper.fireStoreHelper.getUser(id);

      Provider.of<UserProvider>(context, listen: false).getLoginData(snapshot);
      return snapshot;
    }
  }

//Future<List<Category>>
  Future<List<Category>> getCategories(context) async {
    List<Category> cats = await FireStoreHelper.fireStoreHelper.getCat();
    Provider.of<CatProvider>(context, listen: false).setCategory(cats);
    print(cats.length);
    return cats;
  }

  Future<List<Product>> getProduct(context, catId) async {
    List<Product> cats =
        await FireStoreHelper.fireStoreHelper.getProduct(catId);
    Provider.of<CatProvider>(context, listen: false).setCategory(cats);
    print(cats.length);
    return cats;
  }
}
