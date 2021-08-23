import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helper/backendHelper/SQLHelper.dart';
import 'package:shop_app/helper/providers/CartProvider.dart';
import 'package:shop_app/models/Cart.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // List<Cart> list;

  @override
  Widget build(BuildContext context) {
    // getData() async {
    //   list = await SQLHelper.helper.getAllData();
    //   print(list.length);
    // }
    //
    // getData();

    return FutureBuilder<List<Cart>>(
      future: SQLHelper.helper.getAllData(context),
      // async work
      builder: (BuildContext context, AsyncSnapshot<List<Cart>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading....');
          case ConnectionState.done:
            // Provider.of<CartProvider>(context, listen: false).setCartListCount(snapshot.data.length);
            // Provider.of<CartProvider>(context, listen: false).calculateTotalPrice(snapshot.data);
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                    key: Key(snapshot.data[index].id.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() async {
                        int numRow = await SQLHelper.helper
                            .deleteTask(snapshot.data[index].id,context,index);
                        if (numRow > 0) {
                          Fluttertoast.showToast(
                              msg: "Data Delete successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Error",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                        demoCarts.removeAt(index);
                      });
                    },
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          SvgPicture.asset("assets/icons/Trash.svg"),
                        ],
                      ),
                    ),
                    child: CartCard(cart: snapshot.data[index]),
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
  }
}
