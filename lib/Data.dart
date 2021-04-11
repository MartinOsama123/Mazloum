import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:vendors/Models/ProductModel.dart';
import 'package:http/http.dart' as http;

class Data with ChangeNotifier {
  static const IP_ADDRESS = "https://mazloum.genesiscreations.co/core/core.php";
  static const PRODUCTS = "products";
  static Future<ProductModel> getProducts() async {
    ProductModel productModel;

    var response = await http.get(Uri.parse("$IP_ADDRESS?q=$PRODUCTS"));
    if (response != null && response.statusCode == 200) {
      try {
        productModel = ProductModel.fromJson(jsonDecode(response.body));
      } catch (e) {
        print(e.toString());
      }
    }
    print("Finished");
    return productModel;
  }

  static Future<List<Products>> getProductsList({int page = 1}) async {
    ProductModel productModel;

    var response =
        await http.get(Uri.parse("$IP_ADDRESS?q=$PRODUCTS&page=$page"));
    if (response != null && response.statusCode == 200) {
      try {
        productModel = ProductModel.fromJson(jsonDecode(response.body));
      } catch (e) {
        print(e.toString());
      }
    }
    print("Finished");
    return productModel.products;
  }
}
