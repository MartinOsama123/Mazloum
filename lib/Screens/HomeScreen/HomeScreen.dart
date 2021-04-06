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
          child:  GridView.count(
    crossAxisCount: 2,
    crossAxisSpacing: 10.0,
    mainAxisSpacing: 10.0,
    shrinkWrap: true,
    children: List.generate(snapshot.data.products.length, (index) {
              return ClipRRect(borderRadius: BorderRadius.circular(20.0),
                  child:
              CachedNetworkImage(
                imageUrl: "https://mazloum.genesiscreations.co/core/img/${snapshot.data.products[index].productImages[0]}",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(child: CircularProgressIndicator(value: downloadProgress.progress,backgroundColor: Colors.red,)),
                errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,),);
            },
          ),

        ),
      ));
    }else {
        return Center(child: CircularProgressIndicator());
      }
  }
        )

    );
  }
}
