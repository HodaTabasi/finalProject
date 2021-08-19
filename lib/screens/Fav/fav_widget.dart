import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/Product.dart';

// ignore: must_be_immutable
class FavWidget extends StatelessWidget {
  Product product;

  FavWidget(this.product);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(10),
      child: Stack(
        children: [
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              product.mainImage,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 150,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    //   Provider.of<MyProvider>(context, listen: false)
                    //       .addToFavourit( Provider.of<MyProvider>(context,listen: false).products.where((element) => element.id==id).first);
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black.withOpacity(0.4),
                    child: Icon(
                      Icons.favorite,
                      size: 20,
                      color: Colors.red,
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.white54.withOpacity(0.4),
                    child: Text(
                      product.title,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300,color: Colors.black),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
