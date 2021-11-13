import 'package:dotcom_mart/controller/cart_controller.dart';
import 'package:dotcom_mart/models/Products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product _product;

  const ProductDetailScreen(this._product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this._product.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: Image.network(
                        _product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.amber,
                            alignment: Alignment.center,
                            child: const Text(
                              'Whoops!',
                              style: TextStyle(fontSize: 30),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Chip(
                            label: Text(
                              "Price Rp. ${_product.price.toString()}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      this._product.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 60,
            color: Colors.cyan,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => {},
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.red.shade800,
                  ),
                ),
                GetBuilder<CartController>(
                  init: CartController(),
                  builder: (controller) {
                    return IconButton(
                      onPressed: () => {
                        controller.updateItem(_product)
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.red.shade800,
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
