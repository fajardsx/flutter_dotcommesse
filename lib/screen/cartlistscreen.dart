import 'package:dotcom_mart/controller/cart_controller.dart';
import 'package:dotcom_mart/widgets/WidgetsCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartcontroller = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: GetBuilder<CartController>(
        init: CartController(),
        builder: (controller) {
          return Column(
            children: [
              Card(
                margin: EdgeInsets.all(5),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Chip(
                        label: Text("Rp. ${controller.totalAmount.toString()}"),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) => CartWidget(
                    cartcontroller.items.values.toList()[index].id,
                    int.parse(cartcontroller.items.values.toList()[index].id),
                    cartcontroller.items.values.toList()[index].productprice,
                    cartcontroller.items.values.toList()[index].productquantity,
                    cartcontroller.items.values.toList()[index].producttitle,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
