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
}