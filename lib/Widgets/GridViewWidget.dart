
import 'package:flutter/material.dart';
import 'package:vendors/Models/ProductModel.dart';
import 'package:vendors/Widgets/ProductWidget.dart';

class GridViewWidget extends StatelessWidget {
  final int length;
  final List<Products> products;
  const GridViewWidget({
    required this.length, required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          childAspectRatio: 0.7,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: List.generate(
            length, (index) {
              return ProductWidget(
              productsModel: products[index]);
          },
          ),
        ),
      ),
    );
  }
}
