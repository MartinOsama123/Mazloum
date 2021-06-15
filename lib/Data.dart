import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vendors/Models/CategoryModel.dart';
import 'package:vendors/Models/GateModel.dart';
import 'package:vendors/Models/ProductModel.dart';
import 'package:http/http.dart' as http;

class Data with ChangeNotifier {
  static const IP_ADDRESS = "https://mazloum.genesiscreations.co/core/core.php";
  static const PRODUCTS = "products";
  static const CATEGORY = "categories";
  static const PAYMENT = "payment";
  static const TOKENIZE = "tokenize";
  static const PLATFORM = const MethodChannel("com.flutter.epic/epic");
  static Future<ProductModel> getProducts({String query = ""}) async {
    ProductModel productModel;

    var response = await http.get(Uri.parse("$IP_ADDRESS?q=$PRODUCTS$query"));
    if (response != null && response.statusCode == 200) {
      try {
        productModel = ProductModel.fromJson(jsonDecode(response.body));
      } catch (e) {
        print(e.toString());
      }
    }
    return productModel;
  }
  static Future<CategoryModel> getCategory() async {
    CategoryModel categoryModel;

    var response = await http.get(Uri.parse("$IP_ADDRESS?q=$CATEGORY"));
    if (response != null && response.statusCode == 200) {
      try {
        categoryModel = CategoryModel.fromJson(jsonDecode(response.body));
      } catch (e) {
        print(e.toString());
      }
    }

    return categoryModel;
  }

  static Future<List<Products>> getProductsList({int page = 1,String query = ""}) async {
    ProductModel productModel;

    var response =
        await http.get(Uri.parse("$IP_ADDRESS?q=$PRODUCTS&page=$page$query"));
    if (response != null && response.statusCode == 200) {
      try {
        productModel = ProductModel.fromJson(jsonDecode(response.body));
      } catch (e) {
        print(e.toString());
      }
    }
    return productModel.products;
  }
  static Future<GateModel> payment({String cart}) async {
    GateModel gateModel;

    var response =
    await http.get(Uri.parse("$IP_ADDRESS?q=$PAYMENT&user_id=-10&auth_token=test&shopping_cart=$cart&mobile=1"));
    if (response != null && response.statusCode == 200) {
      try {
        gateModel = GateModel.fromJson(jsonDecode(response.body));
      } catch (e) {
        print(e.toString());
      }
    }
    return gateModel;
  }
  static Future<String> token({String sessionId, String orderId}) async {


    var response =
    await http.post(Uri.parse("$IP_ADDRESS?q=$TOKENIZE&user_id=-10&auth_token=test&session_id=$sessionId&order_id=$orderId&mobile=1"));
    if (response != null && response.statusCode == 200) {
      try {
        return "Success";
      } catch (e) {
        print(e.toString());
      }
    }
    return "Failed";
  }
}
