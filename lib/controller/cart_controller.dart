import 'dart:convert';

import 'package:dotcom_mart/models/Cartitem.dart';
import 'package:dotcom_mart/models/Products.dart';
import 'package:dotcom_mart/models/save_response.dart';
import 'package:dotcom_mart/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var isLoading = true.obs;
  Map<int, CartItem> _items = {};
  // Get all item
  Map<int, CartItem> get items {
    return {..._items};
  }

  // get item qty
  int get itemCount {
    return _items.length;
  }

  //
  int get itemQtyCount {
    var total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.productquantity;
    });
    return total;
  }

  //Amount harga x qty
  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartitem) {
      total += cartitem.productquantity * cartitem.productprice;
    });
    return total;
  }

  //update item data
  void updateItem(Product product) {
    if (_items.containsKey(product.id)) {
      print("Item sudah ada di cart => update items");
      _items.update(
          product.id,
          (existingItem) => CartItem(
              id: existingItem.id,
              producttitle: existingItem.producttitle,
              productquantity: existingItem.productquantity + 1,
              productprice: existingItem.productprice));
      update(); //update get x
      Get.snackbar("info", "${product.title} Success update cart",
          backgroundColor: Colors.green);
    } else {
      print("Item blum ada => tambah baru");
      _items.putIfAbsent(
          product.id,
          () => CartItem(
              id: product.id.toString(),
              producttitle: product.title,
              productquantity: product.id,
              productprice: product.price));
      update();
      Get.snackbar("info", "${product.title} Success add cart",
          backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<SaveResponse> saveOrder() async {
    isLoading(true);
    try {
      List<CartItem> items = []; // container 
      _items.forEach((key, value) {
        items.add(value);
      });
      //warper pertama
      Map<String, dynamic> content = {'items': items};

      var response = await ApiService.orderItem(content);
      // print(response.body);
      // var message = jsonDecode(response.body)['message'];
      // print(message);
      var jsbody = SaveResponse.fromJson(jsonDecode(response.body));
      if(jsbody.message == "success"){
        _items.clear();
        update();
      }
      return jsbody;
    } finally {
      isLoading(false);
    }
  }
}
