import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendors/Models/ProductModel.dart';

class CartModel {
  Products product;
  int quantity;
  CartModel({this.product, this.quantity});
}

class Cart with ChangeNotifier {
  List<CartModel> cartModel;
  Cart({this.cartModel});

  factory Cart.fromJson(Map<String, dynamic> parsedJson) {
    return new Cart(cartModel: parsedJson['name'] ?? <CartModel>[]);
  }

  Map<String, dynamic> toJson() {
    return {"name": this.cartModel};
  }

  Future<void> setCartModel(CartModel value) async {
    print("VALUEEEEEE: ${value.product.productNameEn} ${value.quantity}");
    if (cartModel == null) {
      cartModel = <CartModel>[];
    }
    var temp = cartModel.where((element) =>
            element.product.productId == value.product.productId) ??
        null;
    if (temp.isEmpty) {
      cartModel.add(value);
    } else {
      cartModel
          .firstWhere(
              (element) => element.product.productId == value.product.productId)
          .quantity += 1;
    }
    SharedPreferences sharedUser = await SharedPreferences.getInstance();

    print(this.toJson());
    String user = jsonEncode(this.toJson());
    sharedUser.setString('user', user);
    notifyListeners();
  }

  List<CartModel> get getCartModel => cartModel;
}
