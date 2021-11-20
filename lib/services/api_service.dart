import 'dart:convert';

import 'package:dotcom_mart/models/Productsresponse.dart';
import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static var client = http.Client();
  static var url = "http://dotcom.lingkarinteractive.com/";

  static Future<ProductResponse> getProducts() async {
    var response = await client.get(Uri.parse("$url/productlists.php"));
    if (response.statusCode == 200) {
      print(response.body);
      ProductResponse productResponse =
          ProductResponse.fromJson(jsonDecode(response.body));
      return productResponse;
    } else {
      throw "Gagal dapat data";
    }
  }

  static Future<http.Response> orderItem(Map<String, dynamic> map) async {
    String body = json.encode(map);
    var response = await client.post(Uri.parse("$url/ordercreate.php"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    return response;
  }
}
