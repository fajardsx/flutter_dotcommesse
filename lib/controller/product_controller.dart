import 'package:dotcom_mart/models/Products.dart';
import 'package:dotcom_mart/services/api_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  // List<Product> _items = [
  //   Product(
  //     id: 1,
  //     title: 'Red Shirt',
  //     description: 'A red shirt - it is pretty red!',
  //     price: 2500,
  //     imageUrl:
  //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  //   ),
  //   Product(
  //       id: 2,
  //       title: 'Legend',
  //       description:
  //           'Built to last with matte leather uppers, StormKing™ lug rubber outsoles and a flexible elastic goring, the Legend blends form and function like nothing you\'ve seen anywhere else.',
  //       price: 12000,
  //       imageUrl:
  //           'https://cdn.shopify.com/s/files/1/0419/1525/products/1024x1024-Men-Legend-BlackMatte-3.4_672x672.jpg?v=1600886623'),
  //   Product(
  //       id: 3,
  //       title: 'The Chelsea',
  //       description: 'Functional and Fashionable.',
  //       price: 4900,
  //       imageUrl:
  //           'https://cdn.shopify.com/s/files/1/0419/1525/products/1024x1024-Cavalier-Black-1.jpg?v=1589391819'),
  //   Product(
  //       id: 4,
  //       title: 'Men\'s Sneakers',
  //       description: 'Clean & Comfortable Sneakers made with classic Leathers.',
  //       price: 5000,
  //       imageUrl:
  //           'https://cdn.shopify.com/s/files/1/0419/1525/products/1024x1024-Men-PremierLowTop-Black-3.4.jpg?v=1600270679'),
  //   Product(
  //       id: 5,
  //       title: 'The Chelsea',
  //       description:
  //           'This hardwearing Chelsea is every bit as comfortable as you\'d expect from a slip-on boot but with the durability of our Rugged & Resilient collection.',
  //       price: 4000,
  //       imageUrl:
  //           'https://cdn.shopify.com/s/files/1/0419/1525/products/1024x1024-Captain-Natural-3.jpg?v=1584114360'),
  //   Product(
  //       id: 6,
  //       title: 'Men\'s Sneakers',
  //       description: 'Clean & Comfortable Sneakers made with classic Leathers.',
  //       price: 10000,
  //       imageUrl:
  //           'https://cdn.shopify.com/s/files/1/0419/1525/products/1024x1024-Men-PremierLowTop-Black-3.4.jpg?v=1600270679'),
  //   Product(
  //       id: 7,
  //       title: 'The Chelsea',
  //       description:
  //           'Handcrafted for the men who wear their boots hard, every detail was carefully selected so you can go the extra mile with confidence.',
  //       price: 20000,
  //       imageUrl:
  //           'https://cdn.shopify.com/s/files/1/0419/1525/products/1024x1024-Men-Cavalier-Toffee-210402-2.jpg?v=1618424894'),
  //   Product(
  //       id: 8,
  //       title: 'Men\'s Sneakers',
  //       description: 'Clean & Comfortable Sneakers made with classic Leathers.',
  //       price: 6000,
  //       imageUrl:
  //           'https://cdn.shopify.com/s/files/1/0419/1525/products/1024x1024-Men-Cavalier-Toffee-210402-3.jpg?v=1618424894'),
  //   Product(
  //       id: 9,
  //       title: 'The Chelsea',
  //       description: 'Functional and Fashionable.',
  //       price: 7000,
  //       imageUrl:
  //           'https://cdn.shopify.com/s/files/1/0419/1525/products/1024x1024-Cavalier-Black-1.jpg?v=1589391819'),
  //   Product(
  //       id: 10,
  //       title: 'Men\'s Sneakers',
  //       description: 'Clean & Comfortable Sneakers made with classic Leathers.',
  //       price: 2000,
  //       imageUrl:
  //           'https://cdn.shopify.com/s/files/1/0419/1525/products/1024x1024-Men-PremierLowTop-Black-3.4.jpg?v=1600270679'),
  // ];
  var isLoading = true.obs;

  List<Product> _items = [];

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  List<Product> get items {
    return [..._items];
  }

  void fetchProducts() async {
    isLoading(true);
    try {
      var result = await ApiService.getProducts();
      if (result != null) {
        _items = result.rows;
        update();
      }
    } finally {
      isLoading(false);
    }
  }
}
