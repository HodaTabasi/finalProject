import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  static SPHelper sp = SPHelper._();
  SharedPreferences sharedPreferences;

  SPHelper._(); //برايفت ما بقدر اعمل من اوبجيكت ولغيب الديفولت كونستراكتور
  initSP() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  bool checkFirstTime() {
    return sharedPreferences.getBool("firstTime") ?? true;
  }

  insertFirstTime() {
    sharedPreferences.setBool("firstTime", false);
  }

// تخزين البيانات بتاخد شويه وقت
  insetStringData(String key, String value) {
    sharedPreferences.setString(key, value);
  }

  insetDoubleData(String key, double value) {
    sharedPreferences.setDouble(key, value);
  }

  insetIntData(String key, int value) {
    sharedPreferences.setInt(key, value);
  }

  insetBoolData(String key, bool value) {
    sharedPreferences.setBool(key, value);
  }

//  ومتزامنة استرجاع البيانتا بتكون فورية
  dynamic getData(String key) {
    var x = sharedPreferences.get(key);
    return x;
  }
}
