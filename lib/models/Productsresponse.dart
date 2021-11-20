import 'package:dotcom_mart/models/Products.dart';

class ProductResponse {
  final int itemCount;
  final List<Product> rows;

  ProductResponse({
    required this.itemCount,
    required this.rows,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        itemCount: json['itemCount'],
        rows: List<Product>.from(json['rows'].map((x) => Product.fromJson(x))),
      );
}
