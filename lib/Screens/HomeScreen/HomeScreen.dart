import 'package:flutter/material.dart';
import 'package:vendors/AppColor.dart';
import 'package:vendors/Data.dart';
import 'package:vendors/Models/ProductModel.dart';

import '../GridViewWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  Future<ProductModel> productModel;
  bool isLoading = false;
  final List<String> titles = ["On Sale", "New Arrived", "Most Sold"];
  @override
  void initState() {
    super.initState();
    productModel = Data.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = index;

                      productModel = Data.getProducts();
                    });
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            padding: EdgeInsets.only(
                              bottom: 3, // Space between underline and text
                            ),
                            decoration: _currentIndex == index
                                ? BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                      color: AppColor.PrimaryColor,
                                      width: 2.0, // Underline thickness
                                    )),
                                  )
                                : BoxDecoration(),
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 500),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _currentIndex == index
                                      ? AppColor.PrimaryColor
                                      : AppColor.SecondColor),
                              child: Text(titles[index]),
                            )),
                      ),
                    ],
                  ),
                );
              },
              itemCount: titles.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
            ),
          ),
          FutureBuilder<ProductModel>(
              future: productModel,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return GridViewWidget(
                    length: snapshot.data.products.length,
                    products: snapshot.data.products,
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Center(child: Text("No Products were found..."));
                }
              }),
        ],
      ),
    ));
  }
}
