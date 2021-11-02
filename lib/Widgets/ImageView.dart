import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vendors/Models/ProductModel.dart';

class ImageView extends StatelessWidget {
  final width;
  final height;
  const ImageView({
    required this.productsModel,
    this.width = 100.0,
    this.height = 100.0,
  });

  final Products productsModel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: CachedNetworkImage(
            width: this.width,
            height: this.width,
            imageUrl:
            "https://mazloum.genesiscreations.co/core/img/${productsModel.productImages![0]}",
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
