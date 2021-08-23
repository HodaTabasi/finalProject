import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helper/backendHelper/firestore_helper.dart';
import 'package:shop_app/helper/providers/ProductProvider.dart';
import 'package:shop_app/models/Product.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: FireStoreHelper.fireStoreHelper.getFavProductId(context),
      // async work
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading....');
          case ConnectionState.done:
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(20)),
                    HomeHeader(),
                    SizedBox(height: getProportionateScreenWidth(10)),
                    DiscountBanner(),
                    Categories(),
                    // SpecialOffers(),
                    SizedBox(height: getProportionateScreenWidth(30)),
                    PopularProducts(),
                    SizedBox(height: getProportionateScreenWidth(30)),
                  ],
                ),
              ),
            );
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              return Text('Result: ${snapshot.data}');
        }
      },
    );
  }
}
