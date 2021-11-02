import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vendors/Models/CategoryModel.dart';
import 'package:vendors/Models/GateModel.dart';
import 'package:vendors/Models/ProductModel.dart';
import 'package:http/http.dart' as http;
import 'package:vendors/Models/UserModel.dart';

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
        productModel = ProductModel.fromJson(jsonDecode(response.body));

    return productModel;
  }
  static Future<CategoryModel> getCategory() async {
    CategoryModel categoryModel;

    var response = await http.get(Uri.parse("$IP_ADDRESS?q=$CATEGORY"));

        categoryModel = CategoryModel.fromJson(jsonDecode(response.body));

    return categoryModel;
  }

  static Future<List<Products>?> getProductsList({int page = 1,String query = ""}) async {
    ProductModel productModel;

    var response = await http.get(Uri.parse("$IP_ADDRESS?q=$PRODUCTS&page=$page$query"));
        productModel = ProductModel.fromJson(jsonDecode(response.body));

    return productModel.products;
  }
  static Future<GateModel> payment({required String cart}) async {
    GateModel gateModel;

    var response =
    await http.get(Uri.parse("$IP_ADDRESS?q=$PAYMENT&user_id=-10&auth_token=test&shopping_cart=$cart&mobile=1"));

    gateModel = GateModel.fromJson(jsonDecode(response.body));

    return gateModel;
  }
  static Future<String> token({required String sessionId, required String orderId}) async {


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
  static Future<String> register(UserModel userModel) async {
    print(jsonEncode(userModel));
    var response = await http.post(Uri.parse("https://localhost:9080/register"),  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: jsonEncode(userModel));
    if (response.statusCode == 200) {
      try {
        return "Success";
      } catch (e) {
        print(e.toString());
      }
    }
    return "Failed";
  }
}
