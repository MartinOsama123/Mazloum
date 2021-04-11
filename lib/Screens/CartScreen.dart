import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendors/Models/CartModel.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Cart>(
        builder: (context, value, child) => ListView.builder(
          itemBuilder: (context, index) => Dismissible(
            key: Key(value.cartModel[index].product.productId),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              value.removeCart(index);
            },
            background: Container(
                color: Colors.red,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                        size: 30,
                      ),
                    ))),
            child: ListTile(
              leading:
                  Image.network(value.cartModel[index].product.productImage),
              title: Text(value.cartModel[index].product.productNameEn),
              subtitle:
                  Text(value.cartModel[index].product.productPrice.toString()),
            ),
          ),
          itemCount: value.cartModel.length,
        ),
      ),
    );
  }
}
