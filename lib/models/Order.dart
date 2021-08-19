import 'package:cloud_firestore/cloud_firestore.dart';

class Order{
  String id;
  String totalPrice;
  String userId;
  String address;
  String stauts;

  Order(this.id, this.totalPrice, this.userId, this.address);

  toMap() {
    return {
      "id": id,
      "totalPrice": totalPrice,
      "userId": userId,
      "address": address,
      "stauts": "wait",
    };
  }

  Order.toMap(DocumentSnapshot<Map> snapshot){
    Map map = snapshot.data();
    id = map['id'];
    totalPrice =map['totalPrice'];
    userId =map['totalPrice'];
    address =map['address'];
    stauts =map['stauts'];
  }
}