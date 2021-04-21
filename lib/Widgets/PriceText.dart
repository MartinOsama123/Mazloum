import 'package:flutter/material.dart';

import '../AppColor.dart';

class PriceText extends StatelessWidget {
  const PriceText(
      {Key key, @required this.price, this.size =14, this.discount})
      : super(key: key);

  final price;
  final discount;
  final double size;

  @override
  Widget build(BuildContext context) {
    // return Text(
    //   "$price L.E",
    //   style: TextStyle(
    //       fontSize: this.size,
    //       fontWeight: FontWeight.w600,
    //       color: AppColor.PrimaryColor),
    // );
    return Column(children: [
      Text("$price L.E",
            style: TextStyle(
                fontSize: size,
                color: discount != null ? AppColor.SecondColor : AppColor.PrimaryColor,
                fontWeight: discount != null ? FontWeight.normal : FontWeight.w600,
                decoration: discount != null
                    ? TextDecoration.lineThrough
                    : TextDecoration.none)),

      Text(discount != null ? "${(price * (discount/100)).ceil()} L.E" : "",style: TextStyle( fontSize: size,
                      color: discount == null ? Colors.grey : AppColor.PrimaryColor,
                      fontWeight: discount == null ? FontWeight.normal : FontWeight.w600)),

    ],);
    // return RichText(
    //   text: TextSpan(
    //       text: "$price",
    //       style: TextStyle(
    //           fontSize: size,
    //           color: discount != null ? Colors.grey : AppColor.PrimaryColor,
    //           fontWeight: discount != null ? FontWeight.normal : FontWeight.w600,
    //           decoration: discount != null
    //               ? TextDecoration.lineThrough
    //               : TextDecoration.none),children: <TextSpan>[
    //                 TextSpan(text: discount != null ? "${price * (discount/100)} L.E" : " L.E",style: TextStyle( fontSize: size,
    //                   color: discount != null ? Colors.grey : AppColor.PrimaryColor,
    //                   fontWeight: discount != null ? FontWeight.normal : FontWeight.w600))
    //   ]),
    // );
  }
}
