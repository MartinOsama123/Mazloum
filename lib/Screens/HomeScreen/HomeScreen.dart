import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:vendors/Data.dart';
import 'package:vendors/Models/ProductModel.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
   Future<ProductModel> productModel;
  @override
  void initState(){
    super.initState();
    productModel = Data.getProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder<ProductModel>(future: productModel,
      builder: (context,snapshot)
    {
      if (snapshot.hasData){
        return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 500,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(borderRadius: BorderRadius.circular(10.0),
                  child:
              CachedNetworkImage(
                imageUrl: "https://mazloum.genesiscreations.co/core/img/${snapshot.data.products[index].productImages[0]}",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,),);
            },
            itemCount: snapshot.data.products.length,
            itemWidth: 400.0,
            itemHeight: 400.0,
            index: _currentIndex,
            onIndexChanged: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },

            layout: SwiperLayout.TINDER,

            pagination: SwiperPagination(
                builder: const DotSwiperPaginationBuilder(
                    size: 5.0,
                    activeSize: 13.0,
                    space: 10.0,
                    color: Colors.black)),
          ),

        ),
      );
    }else {
        return Center(child: CircularProgressIndicator());
      }
  }
        )

    );
  }
}
