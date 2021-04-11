import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendors/Models/ProductModel.dart';

class CartModel with ChangeNotifier {
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
  void setQuantity(int quantity) {
    if (quantity > 0) this.quantity = quantity;
    notifyListeners();
  }
}

class Cart with ChangeNotifier {
  List<CartModel> cartModel;
  SharedPreferences sharedUser;

  Cart({this.cartModel}) {
    sharedPref();
  }
  Cart.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson['cart'] != null) {
      cartModel = <CartModel>[];
      parsedJson['cart'].forEach((v) {
        cartModel.add(new CartModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {"cart": cartModel};

  void setCartModel(CartModel value) {
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
    encodingFunction();
  }

  void removeCart(int index) {
    cartModel.removeAt(index);
    encodingFunction();
  }

  void removeAllCart() {
    cartModel.clear();
    encodingFunction();
  }

  Future<void> sharedPref() async {
    sharedUser = await SharedPreferences.getInstance();
    cartModel =
        Cart.fromJson(jsonDecode(sharedUser.getString("cart"))).cartModel;
    print(cartModel.length);
    notifyListeners();
  }

  void encodingFunction() {
    String user = jsonEncode(Cart(cartModel: cartModel).toJson());
    sharedUser.setString('cart', user);
    notifyListeners();
  }

  List<CartModel> get getCartModel => cartModel;
}
