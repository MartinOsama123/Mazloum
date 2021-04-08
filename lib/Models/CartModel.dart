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
  factory CartModel.fromJson(Map<String, dynamic> parsedJson) {
    return new CartModel(
        product: parsedJson['product'], quantity: parsedJson['quantity']);
  }
}

class Cart with ChangeNotifier {
  List<CartModel> cartModel = <CartModel>[];
  Cart({this.cartModel});

  factory Cart.fromJson(Map<String, dynamic> parsedJson) {
    return new Cart(cartModel: parsedJson['name']);
  }

  Map<String, dynamic> toJson() {
    return {"name": this.cartModel};
  }

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
    SharedPreferences sharedUser = await SharedPreferences.getInstance();

    cartModel.forEach((element) => print(element.product.productNameEn));
    String user = jsonEncode(cartModel);
    sharedUser.setString('user', user);
    print("get Sring: ${sharedUser.getString('user')}");
    notifyListeners();
  }

  List<CartModel> get getCartModel => cartModel;
}
