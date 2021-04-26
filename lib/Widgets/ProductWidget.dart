import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vendors/AppColor.dart';
import 'package:vendors/Models/CartModel.dart';

import 'package:vendors/Models/ProductModel.dart';
import 'package:vendors/Screens/DetailedScreen.dart';

import 'ImageView.dart';
import 'PriceText.dart';

class ProductWidget extends StatelessWidget {
  final Products productsModel;

  const ProductWidget({
    Key key,
    this.productsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 200,
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),boxShadow:[
        BoxShadow(
          color: AppColor.ShadowColor,
          blurRadius:  5,
          offset: Offset(0, 3),
        ),
      ]),
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => DetailedScreen(
                              product: productsModel,
                            )));
              },
              child: ImageView(productsModel: productsModel),
            ),
            Spacer(),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  productsModel.productNameEn,
                  style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PriceText(price: productsModel.productPrice,discount: productsModel.productDiscount,),
                Spacer(),
               // SizedBox(width: 18,child: IconButton(icon: Icon(Icons.favorite_border), onPressed: (){},color: AppColor.SecondColor,iconSize: 18,)),
                Consumer<Cart>(builder: (context, value, child) {
                  return IconButton(
                      icon: Icon(
                        Icons.add_shopping_cart,

                        color: AppColor.PrimaryColor,
                      ),
                      iconSize: 20,
                      onPressed: () {
                        value.setCartModel(
                            CartModel(product: productsModel, count: 1));
                        return showDialog<void>(
                          context: context,
                          barrierDismissible: true, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Added Successfully'),
                              content: Icon(Icons.check,color: Colors.green,size: 50,),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK!'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                }),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

