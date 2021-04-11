import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendors/Models/ProductModel.dart';

class CartModel {
  Products product;
  int quantity;
  CartModel({this.product, this.quantity});
  Map<String, dynamic> toJson() => {
        'product': product,
        'quantity': quantity,
      };
  CartModel.fromJson(Map<String, dynamic> parsedJson) {
    product = Products.fromJson(parsedJson['product']);
    quantity = parsedJson['quantity'];
  }
}

class Cart with ChangeNotifier {
  List<CartModel> cartModel;
  Cart({this.cartModel});
  Cart.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson['cart'] != null) {
      cartModel = <CartModel>[];
      parsedJson['cart'].forEach((v) {
        cartModel.add(new CartModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {"cart": cartModel};

  Future<void> setCartModel(CartModel value) async {
    // print("VALUEEEEEE: ${value.product.productNameEn} ${value.quantity}");
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
    await encodingFunction();
    notifyListeners();
  }

  void removeCart(int index) async {
    cartModel.removeAt(index);
    await encodingFunction();
    notifyListeners();
  }

  Future<void> encodingFunction() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();

    String user = jsonEncode(Cart(cartModel: cartModel).toJson());
    sharedUser.setString('cart', user);
  }

  List<CartModel> get getCartModel => cartModel;
}
