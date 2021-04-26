import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendors/AppColor.dart';
import 'package:vendors/Models/CartModel.dart';
import 'package:vendors/Screens/CheckoutScreen.dart';
import 'package:vendors/Widgets/ImageView.dart';
import 'package:vendors/Widgets/PriceText.dart';


class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text("My Cart",style: TextStyle( color: AppColor.SecondColor,fontSize: 16),),
          leading: IconButton(
            color: AppColor.SecondColor,
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          actions: [
            IconButton(
                color: AppColor.SecondColor,
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
                  key: Key(value.getCartModel[index].product.productId),
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

                    leading:  ImageView(
                        productsModel: value.getCartModel[index].product,
                      width: 100.0,
                      ),

                    title: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36,vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value.getCartModel[index].product.productNameEn,
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              IconButton(

                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    value.decrement(index);
                                  }),
                              Text(value.getCartModel[index].count.toString(),style: TextStyle(color: AppColor.PrimaryColor),),
                              IconButton(

                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    value.increment(index);
                                  })
                            ],
                          ),
                          PriceText(
                            price: value.getCartModel[index].product.productPrice,
                          ),
                        ],
                      ),
                    ),

                  ),
                ),
                itemCount: value.getCartModel.length ?? 0,
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34),
              child: Row(
                children: [
                  const Text("Total",style: TextStyle(color: AppColor.SecondColor,fontWeight: FontWeight.w600),),
                  Spacer(),
                  PriceText(
                    size: 16,
                      price: value.cartModel.isNotEmpty ? value.cartModel
                          .map((e) => e.product.productPrice * e.count)
                          .reduce((value, element) => value + element) : 0)
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
                    onPressed: value.getCartModel.isNotEmpty ? () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CheckoutScreen()));
                    }: null,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("CHECKOUT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14),),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
