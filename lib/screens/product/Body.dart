import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/helper/backendHelper/firebase_helper.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/product/item_product.dart';

import '../../size_config.dart';

class Body extends StatefulWidget {
  String catId;

  Body(this.catId);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    // FirebaseHelper.firebaseHelper.getProduct(context,widget.catId);

    return FutureBuilder<List<Product>>(
      future: FirebaseHelper.firebaseHelper.getProduct(context, widget.catId),
      // async work
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading....');
          case ConnectionState.done:
            return Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(20)),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductItem(product: snapshot.data[index]);
                  }),
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
