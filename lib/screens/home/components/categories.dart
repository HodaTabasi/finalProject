import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helper/backendHelper/firebase_helper.dart';
import 'package:shop_app/helper/backendHelper/firestore_helper.dart';
import 'package:shop_app/helper/providers/cat_provider.dart';
import 'package:shop_app/models/Category.dart';
import 'package:shop_app/screens/product/product_screen.dart';

import '../../../size_config.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: FirebaseHelper.firebaseHelper.getCategories(context),
      // async work
      builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading....');
          case ConnectionState.done:
            return Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  snapshot.data.length,
                  (index) => CategoryCard(
                    cat: snapshot.data[index],
                    press: () {
                      Navigator.pushNamed(
                        context,
                        ProductPage.routeName,
                        arguments: ProductArguments(catId: snapshot.data[index].id),
                      );
                    },
                  ),
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

    // return Selector<CatProvider, List<Category>>(builder: (context, list, w) {
    //   if (list.isEmpty) {
    //     return Center(
    //       child: Text("no data found"),
    //     );
    //   } else {
    //     return Padding(
    //       padding: EdgeInsets.all(getProportionateScreenWidth(20)),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: List.generate(
    //           list.length,
    //           (index) => CategoryCard(
    //             cat: list[index],
    //             press: () {},
    //           ),
    //         ),
    //       ),
    //     );
    //   }
    // }, selector: (context, provider) {
    //   return provider.cat;
    // });
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.cat,
    @required this.press,
  }) : super(key: key);

  final Category cat;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(cat.icon),
            ),
            SizedBox(height: 5),
            Text(cat.name, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
