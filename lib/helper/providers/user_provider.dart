import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/AppUser.dart';

class UserProvider extends ChangeNotifier {
  AppUser appUser = AppUser();

  saveCompleteProfile(AppUser user) {
    appUser.firstName = user.firstName;
    appUser.lastName = user.lastName;
    appUser.phone = user.phone;
    appUser.address = user.address;
  }

  getLoginData(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    appUser.fromMapToObject(snapshot.data());
    notifyListeners();
  }
}
