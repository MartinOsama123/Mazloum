import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vendors/AppColor.dart';
import 'package:vendors/Models/CartModel.dart';

import 'package:vendors/Models/ProductModel.dart';
import 'package:vendors/Screens/DetailedScreen.dart';

class ProductWidget extends StatelessWidget {
  final Products productsModel;

  const ProductWidget({
    Key key,
    this.productsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
              style: TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            )),
        Row(
          children: [
            PriceText(price: productsModel.productPrice),
            Spacer(),
            Consumer<Cart>(builder: (context, value, child) {
              return IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: AppColor.PrimaryColor,
                  ),
                  onPressed: () {
                    value.setCartModel(
                        CartModel(product: productsModel, quantity: 1));
                    print(value.getCartModel.length);
                  });
            }),
          ],
        ),
        Spacer()
      ],
    );
  }
}

class PriceText extends StatelessWidget {
  const PriceText({
    Key key,
    @required this.price,
  }) : super(key: key);

  final price;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$price L.E",
      style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColor.PrimaryColor),
    );
  }
}

class ImageView extends StatelessWidget {
  final width;
  final height;
  const ImageView({
    Key key,
    @required this.productsModel,
    this.width = 150.0,
    this.height = 150.0,
  }) : super(key: key);

  final Products productsModel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: CachedNetworkImage(
            width: this.width,
            height: this.width,
            imageUrl:
                "https://mazloum.genesiscreations.co/core/img/${productsModel.productImages[0]}",
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  backgroundColor: Colors.red,
                )),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.fill));
  }
}
