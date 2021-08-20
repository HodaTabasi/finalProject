import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String id;
  String email;
  String password;

  String firstName;
  String lastName;
  String phone;
  String address;

  AppUser({this.id, this.email, this.password});

  AppUser.complete({this.firstName, this.lastName, this.phone, this.address});

  AppUser.update(
      {this.id,
      this.email,
      this.password,
      this.firstName,
      this.lastName,
      this.phone,
      this.address});

  toMap() {
    return {'id': this.id, 'email': this.email, 'password': this.password};
  }

  updateToMap() {
    return {
      'password': this.password,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'phone': this.phone,
      'address': this.address
    };
  }

  AppUser.fromDataSnapShot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map map = snapshot.data();
    this.id = map['id'];
    this.email = map['email'];
    this.password = map['password'];
    this.firstName = map['firstName'];
    this.lastName = map['lastName'];
    this.phone = map['phone'];
    this.address = map['address'];
  }

  toMapCompleteProfile() {
    return {
      'firstName': this.firstName,
      'lastName': this.lastName,
      'phone': this.phone,
      'address': this.address
    };
  }

  fromMapToObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.email = map['email'];
    this.password = map['password'];
    this.firstName = map['firstName'];
    this.lastName = map['lastName'];
    this.phone = map['phone'];
    this.address = map['address'];
  }
}
