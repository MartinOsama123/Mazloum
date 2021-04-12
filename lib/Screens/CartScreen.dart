import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendors/AppColor.dart';
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
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
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
                                  value.decrement(index);
                                }),
                            Text(value.cartModel[index].quantity.toString()),
                            IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  value.increment(index);
                                })
                          ],
                        )
                      ],
                    ),
                    isThreeLine: true,
                    subtitle: PriceText(
                      price: value.cartModel[index].product.productPrice,
                    ),
                  ),
                ),
                itemCount: value.cartModel.length,
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34),
              child: Row(
                children: [
                  const Text("Total"),
                  Spacer(),
                  PriceText(
                    size: 16,
                      price: value.cartModel
                          .map((e) => e.product.productPrice * e.quantity)
                          .reduce((value, element) => value + element))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: RaisedButton(
                    color: AppColor.PrimaryColor,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("Checkout",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16),),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
