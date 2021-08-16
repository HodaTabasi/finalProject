import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helper/providers/CartProvider.dart';
import 'package:shop_app/models/Cart.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${Provider.of<CartProvider>(context).listCount} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
