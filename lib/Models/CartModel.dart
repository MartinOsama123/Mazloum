import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendors/Models/ProductModel.dart';

class CartModel with ChangeNotifier {
  late  Products product;
  late int count;
  CartModel({required this.product, required this.count});
  Map<String, dynamic> toJson() => {
        'product': product,
        'count': count,
      };

  CartModel.fromJson(Map<String, dynamic> parsedJson) {
    product = Products.fromJson(parsedJson['product']);
    count = parsedJson['count'];
  }
  void setQuantity(int quantity) {
    if (quantity > 0) this.count = quantity;
    notifyListeners();
  }
}
class SendCart {
  var productId;
  var count;

  SendCart(this.productId, this.count);

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'count': count,
  };
}

class Cart with ChangeNotifier {
  late List<CartModel> cartModel;
  late SharedPreferences sharedUser;

  Cart({required this.cartModel}) {
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
    if (temp!.isEmpty) {
      cartModel.add(value);
    } else {
      cartModel
          .firstWhere(
              (element) => element.product.productId == value.product.productId)
          .count += value.count;
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
  void increment(int i){
    cartModel[i].count += 1;
    encodingFunction();
    notifyListeners();
  }
  void decrement(int i){
    cartModel[i].count -= 1;
    if(cartModel[i].count <= 0) removeCart(i);
    encodingFunction();
    notifyListeners();
  }

  Future<void> sharedPref() async {
    sharedUser = await SharedPreferences.getInstance();
    cartModel =
        Cart.fromJson(jsonDecode(sharedUser.getString("cart") ?? "")).cartModel;
    notifyListeners();
  }

  void encodingFunction() {
    String user = jsonEncode(Cart(cartModel: cartModel).toJson());
    sharedUser.setString('cart', user);
    notifyListeners();
  }

  List<CartModel> get getCartModel {cartModel = <CartModel>[]; return cartModel; }
}
