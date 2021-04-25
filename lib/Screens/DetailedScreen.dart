import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vendors/AppColor.dart';
import 'package:vendors/Models/ProductModel.dart';
import 'package:vendors/Widgets/ImageView.dart';

import '../Data.dart';

class DetailedScreen extends StatelessWidget {
  final Products product;

  const DetailedScreen({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.PrimaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 300,
                  child: ImageView(productsModel: product,)
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppColor.HorizontalPadding),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 8),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                product.productNameEn,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                                icon: Icon(
                                  Icons.aspect_ratio_outlined,
                                  color: Colors.green,
                                ),
                                onPressed: () => _ar()),
                            IconButton(
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: AppColor.PrimaryColor,
                                ),
                                onPressed: () {}),
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${product.productPrice} L.E",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.PrimaryColor),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 18, 0, 40),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                const Text("Color"),
                                Text(
                                  product.specifications
                                      .firstWhere(
                                          (element) => element.specId == 1)
                                      .valueNameEn,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                const Text("Made In"),
                                Text(
                                    product.specifications
                                        .firstWhere(
                                            (element) => element.specId == 7)
                                        .valueNameEn,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Spacer()
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: const Text("Details")),
                      ),
                      Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy ext ever since the 1500s, when an u"),
                    ],
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          AddCartWidget(),
        ],
      ),
    );
  }
  void _ar() async {
    List<String> temp = _parseDim();
    var sendMap = <String, dynamic>{
      "image": product.productImage ?? "",
      "dimX": temp[0] ?? "0",
      "dimY": temp[1] ?? "1",
      "tilesUnit": product.tilesInUnit ?? 1.0
    };
    var value;
    try {
      value = await Data.PLATFORM.invokeMethod("printy",sendMap);
    } catch (e) {
      print(e.toString());
    }
    print(value);
  }
  List<String> _parseDim() => product.specifications.firstWhere((element) => element.specId == 3).valueNameEn.toString().replaceAll(new RegExp(r'[^0-9]^(.*)'),'').split("*").toList();

}


class AddCartWidget extends StatefulWidget {
  const AddCartWidget({
    Key key,
  }) : super(key: key);

  @override
  _AddCartWidgetState createState() => _AddCartWidgetState();
}

class _AddCartWidgetState extends State<AddCartWidget> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppColor.HorizontalPadding, vertical: 12),
      child: Row(children: [
        IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              if (quantity > 1)
                setState(() {
                  quantity--;
                });
            }),
        Text("$quantity"),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              quantity++;
            });
          },
          splashColor: Colors.green,
        ),
        Expanded(
          child: SizedBox(
            height: 45,
            child: RaisedButton(
              onPressed: () {},
              child: const Text(
                "Add to Cart",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white),
              ),
              color: AppColor.PrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        )
      ]),
    );
  }
}
