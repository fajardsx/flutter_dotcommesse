import 'package:dotcom_mart/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartWidget extends StatelessWidget {
  final String id;
  final int productid;
  final double price;
  final int qty;
  final String title;

  const CartWidget(
    this.id,
    this.productid,
    this.price,
    this.qty,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    final cartcontroller = Get.put(CartController());

    return Dismissible(
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        print("Delete Cart");
      },
      key: ValueKey(id),
      child: Expanded(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Text("Rp. ${price.toString()}"),
              title: Text(title),
              subtitle: Text("Total : Rp. ${price * qty}"),
              trailing: Text("${qty} X"),
            ),
          ),
        ),
      ),
    );
  }
}
