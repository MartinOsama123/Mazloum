import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:vendors/AppColor.dart';
import 'package:vendors/Data.dart';
import 'package:vendors/Models/ProductModel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  Future<ProductModel>? productModel;
  final List<String> titles = ["On Sale","New Arrived","Most Sold"];
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
                 child: ListView.builder(itemBuilder: (context, index) {
                   return GestureDetector(
                     onTap: (){
                       setState(() {
                         _currentIndex = index;
                         productModel = null;
                         productModel = Data.getProducts();
                       });
                     },
                     child: Column(
                       children: [
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                           child: AnimatedContainer(
                             duration: const Duration(milliseconds: 500),
                               padding: EdgeInsets.only(
                                 bottom: 3, // Space between underline and text
                               ),
                               decoration: _currentIndex == index ?  BoxDecoration(
                                   border: Border(bottom: BorderSide(
                                     color: AppColor.PrimaryColor,
                                     width: 2.0, // Underline thickness
                                   )),
                               ) : BoxDecoration(),
                               child: AnimatedDefaultTextStyle(
                                 duration: const Duration(milliseconds: 500),
                                 style:
                                 TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: _currentIndex == index ? AppColor.PrimaryColor : AppColor.SecondColor),
                                 child: Text(titles[index]),
                               )),
                         ),

                       ],
                     ),
                   );
                 },itemCount: titles.length,scrollDirection: Axis.horizontal,shrinkWrap: true,),
               ),
               FutureBuilder<ProductModel>(
                    future: productModel,
                    builder: (context, snapshot) {
                      if (productModel != null) {
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
                                snapshot.data!.products.length,
                                (index) {
                                  return ProductWidget(
                                      productsModel: snapshot.data!.products[index], key: null,);
                                },
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),

            ],
          ),
        ));
  }
}

class ProductWidget extends StatelessWidget {
  final Products productsModel;

  const ProductWidget({
    required Key key,
    required this.productsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 150,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(
                  imageUrl:
                      "https://mazloum.genesiscreations.co/core/img/${productsModel.productImages[0]}",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        backgroundColor: Colors.red,
                      )),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.fill)),
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
            Text("${productsModel.productPrice} L.E",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700,color: AppColor.PrimaryColor),),
            Spacer(),
            IconButton(icon: Icon(Icons.add_shopping_cart,color: AppColor.PrimaryColor,), onPressed: () {})
          ],
        ),
        Spacer()
      ],
    );
  }
}
