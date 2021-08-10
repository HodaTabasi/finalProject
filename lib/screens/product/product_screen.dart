import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/product/body.dart';

import '../details/components/custom_app_bar.dart';
import 'Body.dart';

class ProductPage extends StatefulWidget {
  static String routeName = "/productPage";

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final ProductArguments agrs =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar:AppBar(title: Text("product"),),
      body: Body(agrs.catId),
    );
  }
}

class ProductArguments {
  final String catId;

  ProductArguments({@required this.catId});
}
