import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 500,
            child: Swiper(
              itemBuilder: (BuildContext context,int index){
                return  ClipRRect( borderRadius: BorderRadius.circular(8.0),child: Image.network("https://mazloum.genesiscreations.co/core/img/RemoteImages/images/0860110009.jpg",fit: BoxFit.fill,));
              },
              itemCount: 3,
              itemWidth: 400.0,
              itemHeight:400.0,
              index: _currentIndex,
              onIndexChanged: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },

              layout: SwiperLayout.TINDER,

              pagination:  SwiperPagination(
                  builder: const DotSwiperPaginationBuilder(
                      size: 5.0, activeSize: 13.0, space: 10.0,color: Colors.black)),
            ),

          ),
        )
      ],),
    );
  }
}
