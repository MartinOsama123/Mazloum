import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vendors/AppColor.dart';
import 'package:vendors/Models/ProductModel.dart';

class DetailedScreen extends StatelessWidget {
  final Products product;

  const DetailedScreen({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,leading: IconButton(icon: Icon(Icons.arrow_back,color: AppColor.PrimaryColor),onPressed: (){Navigator.pop(context);},),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              child: CachedNetworkImage(
                  imageUrl:
                      "https://mazloum.genesiscreations.co/core/img/${product.productImages[0]}",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        backgroundColor: Colors.red,
                      )),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.fill),
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
                            onPressed: () {}),
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
                    child: Row(children: [
                      Column(
                        children: [
                          const  Text("Color"),
                          Text(product.specifications.firstWhere((element) => element.specId == 1).valueNameEn,style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                        const  Text("Made In"),
                          Text(product.specifications.firstWhere((element) => element.specId == 7).valueNameEn,style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Spacer()
                    ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Align(alignment: Alignment.centerLeft,child: const Text("Details")),
                  ),
                  Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy ext ever since the 1500s, when an u")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
