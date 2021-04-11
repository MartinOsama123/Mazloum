import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendors/Models/CartModel.dart';
import 'package:vendors/Screens/HomeScreen/Widgets/ProductWidget.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("My Cart"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          actions: [
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => value.removeAllCart())
          ],
        ),
        body: ListView.builder(
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
              leading: ImageView(
                productsModel: value.cartModel[index].product,
                width: 130.0,
                height: 200.0,
              ),
              title: Column(
                children: [
                  Text(
                    value.cartModel[index].product.productNameEn,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (value.cartModel[index].quantity-- > 0)
                              value.cartModel[index]
                                  .setQuantity(value.cartModel[index].quantity);
                            else
                              value.removeCart(index);
                          }),
                      Text(value.cartModel[index].quantity.toString()),
                      IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            value.cartModel[index].quantity++;
                          })
                    ],
                  )
                ],
              ),
              isThreeLine: true,
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