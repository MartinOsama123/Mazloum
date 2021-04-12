
import 'package:flutter/material.dart';


import '../AppColor.dart';

class PriceText extends StatelessWidget {
  const PriceText({
    Key key,
    @required this.price,
    this.size = 14
  }) : super(key: key);

  final price;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$price L.E",
      style: TextStyle(
          fontSize: this.size,
          fontWeight: FontWeight.w600,
          color: AppColor.PrimaryColor),
    );
  }
}

