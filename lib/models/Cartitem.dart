class CartItem {
  final String id;
  final String producttitle;
  final int productquantity;
  final double productprice;

  CartItem(
      {required this.id,
      required this.producttitle,
      required this.productquantity,
      required this.productprice});

  Map<String,dynamic> toJson()=>{
    "product_id":int.parse(id),
    "user_id":2,// Hard Code kalo user sudah login dan dapat user id
    "qty":productquantity,
  };
}
