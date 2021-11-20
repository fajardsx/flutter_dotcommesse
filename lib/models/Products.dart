class Product {
  final int id;
  final String title;
  final String imageUrl;
  final String description;
  final double price;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.description,
      required this.price,
      this.isFavorite = false});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: int.parse(json["id"]),
        title: json["title"],
        description: json["description"],
        price: double.parse(json["price"]),
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "imageUrl": imageUrl,
      };
}
