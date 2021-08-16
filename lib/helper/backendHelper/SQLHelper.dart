import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helper/providers/CartProvider.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static SQLHelper helper = SQLHelper._();
  Database database;
  static String TABLE_NAME = "cart";
  static String ID = "id";
  static String NAME = "name";
  static String PRICE = "price";
  static String COUNT = "count";
  static String imageUrl = "imageUrl";

  SQLHelper._();

  initDataBase() async {
    if (database == null) {
      return database = await onCreateDataBase();
    } else
      return database;
  }

  Future<Database> onCreateDataBase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path + '/myCart.db';

    Database database =
        await openDatabase(appDocPath, version: 1, onCreate: (db, v) async {
      db.execute(
          'CREATE TABLE $TABLE_NAME ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $NAME TEXT,$PRICE TEXT,$imageUrl TEXT, $COUNT INTEGER)');
    });

    return database;
  }

  Future<int> insertData(Cart cart) async {
    var rowNum = await database.insert(TABLE_NAME, cart.toMap());
    print(rowNum);
    return rowNum;
  }

  Future<List<Cart>> getAllData(context) async {
    List<Map> data = await database.query(TABLE_NAME);
    List<Cart> dd = data.map( (entry) {
      return Cart.fromMap(entry);
    }).toList();
    Provider.of<CartProvider>(context, listen: false).setCart(dd);
    return dd;
  }

  getSingleData(int id) async {
    List<Map> data =
        await database.query(TABLE_NAME, where: '$ID=?', whereArgs: [id]);
    // List<Map> data = await database.query(TABLE_NAME,where: '$ID=$id');
    print(data);
  }

  Future<int> deleteTask(int id,context,int index) async {
    int deleteRowNum =
        await database.delete(TABLE_NAME, where: '$ID=?', whereArgs: [id]);
    Provider.of<CartProvider>(context, listen: false).deleteFromList(index);
    return deleteRowNum;
    // print(deleteRowNum);
  }

  // updateTask(TaskDB taskDB) async {
  //   var x = await database.update(TABLE_NAME, taskDB.toMap(),
  //       where: '$ID=?', whereArgs: [taskDB.id]);
  //   print(x);
  // }
  //
  // updateTaskMap(TaskDB taskDB) async {
  //   Map<String, dynamic> row = {IS_COMPLETE: taskDB.isComplete?1:0};
  //   var x = await database
  //       .update(TABLE_NAME, row, where: '$ID=?', whereArgs: [taskDB.id]);
  //   print(x);
  // }

  Future close() async => database.close();
}
