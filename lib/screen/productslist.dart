import 'package:dotcom_mart/controller/cart_controller.dart';
import 'package:dotcom_mart/controller/product_controller.dart';
import 'package:dotcom_mart/screen/productdetailscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    final cartController = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Obx(() {
        if(productController.isLoading.value){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            Container(
              height: 100,
              color: Colors.red,
              child: Center(
                child: Text("banner"),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: productController.items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GetBuilder(
                    init: ProductController(),
                    builder: (value) => Container(
                      height: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GridTile(
                          child: GestureDetector(
                            onTap: () => {
                              Get.to(() => ProductDetailScreen(
                                  productController.items[index]))
                            },
                            child: Image.network(
                              productController.items[index].imageUrl,
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
                          header: Text(productController.items[index].title),
                          footer: GridTileBar(
                            backgroundColor: Colors.black87,
                            leading: Icon(Icons.favorite_outline),
                            title: Text(
                                "Rp. ${productController.items[index].price}"),
                            trailing: IconButton(
                              onPressed: () => cartController
                                  .updateItem(productController.items[index]),
                              icon: Icon(Icons.shopping_cart,
                                  color: Colors.red.shade500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
