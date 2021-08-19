import 'package:flutter/material.dart';
import 'package:shop_app/models/Order.dart';

class OrderItem extends StatelessWidget {
  Order order;

  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.amber.shade200.withOpacity(0.8),
        child: InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () {
        print('Card tapped.');
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
            width: 300,
            height: 120,
            child: Center(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "order address ${order.address}",
                        textAlign: TextAlign.start,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "order price ${order.totalPrice} \$",
                        textAlign: TextAlign.start,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "order stauts ${order.stauts}",
                        textAlign: TextAlign.start,
                      )),
                ],
              ),
            )),
      ),
    ));
  }
}
