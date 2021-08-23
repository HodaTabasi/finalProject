import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helper/LocalStorage/sp_helper.dart';
import 'package:shop_app/helper/backendHelper/firebase_helper.dart';
import 'package:shop_app/helper/backendHelper/firestore_helper.dart';
import 'package:shop_app/helper/providers/ProductProvider.dart';
import 'package:shop_app/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key key,
    @required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    String userId = SPHelper.sp.sharedPreferences.getString("id");
    return FutureBuilder<bool>(
      future:
          FireStoreHelper.fireStoreHelper.getIsFav(context, product.id, userId),
      // async work
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading....');
          case ConnectionState.done:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Text(
                    product.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                    width: getProportionateScreenWidth(64),
                    decoration: BoxDecoration(
                      color: product.isFavourite
                          ? Color(0xFFFFE6E6)
                          : Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: InkWell(
                      onTap: () async {
                        if (!Provider.of<ProductProvider>(context,
                                listen: false)
                            .isFav) {
                          bool isFav = await FireStoreHelper.fireStoreHelper
                              .addFav(product.id, userId, product);
                          if (isFav) {
                            Provider.of<ProductProvider>(context, listen: false)
                                .putIsFav(isFav);
                          }
                        } else {
                          bool isFav = await FireStoreHelper.fireStoreHelper
                              .removeFromFav(product.id);

                          if (isFav) {
                            Provider.of<ProductProvider>(context, listen: false)
                                .removeFromFav();
                          }
                        }
                      },
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color: Provider.of<ProductProvider>(context).isFav
                            ? Color(0xFFFF4848)
                            : Color(0xFFDBDEE4),
                        height: getProportionateScreenWidth(16),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(20),
                    right: getProportionateScreenWidth(64),
                  ),
                  child: Text(
                    product.description,
                    maxLines: 3,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          "See More Detail",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                )
              ],
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
