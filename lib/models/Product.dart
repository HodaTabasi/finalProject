import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  String id;
  String title, description;
  List<String> images;
  final List<Color> colors = [
    Color(0xFFF6625E),
    Color(0xFF836DB8),
    Color(0xFFDECB9C),
    Colors.white,
  ];
  double rating, price;
  String price1;
  bool isFavourite, isPopular;
  String mainImage;
  String catId;
  String views;

  Product({
    this.id,
    this.images,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    this.title,
    this.price,
    this.description,
    this.mainImage,
    this.views,
    this.catId,
    this.price1,
  });

  Product.toMap(DocumentSnapshot<Map> snapshot) {
    Map map = snapshot.data();
    this.id = map['id'];
    this.title = map['name'];
    this.price1 = map['price'];
    this.description = map['desc'];
    this.catId = map['catId'];
    this.views = map['views'];
    this.mainImage = map['image'];
    this.isFavourite = false;
    this.isPopular = false;
  }

    fromMap(){
    return {
      "name":this.title,
      "price":price1,
      "id":this.id,
      "catId":this.catId,
      "views":this.views,
      "image":this.mainImage,
      "desc":this.description
    };
  }
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: '1',
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    title: "Wireless Controller for PS4™",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: '2',
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    title: "Nike Sport White - Man Pant",
    price: 50.5,
    description: description,
    rating: 4.1,
    isPopular: true,
  ),
  Product(
    id: '3',
    images: [
      "assets/images/glap.png",
    ],
    title: "Gloves XC Omega - Polygon",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: '4',
    images: [
      "assets/images/wireless headset.png",
    ],
    title: "Logitech Head",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavourite: true,
  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
