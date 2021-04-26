import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:im_stepper/stepper.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:vendors/Models/CartModel.dart';
import 'package:vendors/Models/CategoryModel.dart';
import 'package:vendors/Models/ProductModel.dart';
import 'package:vendors/Screens/SearchScreen.dart';
import 'package:vendors/Widgets/ImageView.dart';
import 'package:vendors/Widgets/ProductWidget.dart';

import '../AppColor.dart';
import '../Data.dart';
import 'CartScreen.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final PagingController<int, Products> _pagingController =
      PagingController(firstPageKey: 1);

  final List<String> titles = ["On Sale", "New Arrived", "Most Sold"];


  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    // print(_scrollPosition);
    if(pageKey < 5) {
      try {
        final newItems = await Data.getProductsList(page: pageKey);

        final isLastPage = newItems.length < 12;
        if (isLastPage) {
          _pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      } catch (error) {
        _pagingController.error = error;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.person),
            color: AppColor.SecondColor,
            onPressed: () {},
          ),
          title: const Text(
            'MAZLOUM',
            style: TextStyle(fontSize: 35, color: AppColor.PrimaryColor),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.search),
                color: AppColor.SecondColor,
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()))),
            Consumer<Cart>(builder: (context, value, child) {
              child:
              return Badge(
                position: BadgePosition.topEnd(end: 5, top: 0),
                badgeColor: AppColor.PrimaryColor,
                badgeContent: Text(
                  '${value.getCartModel?.length ?? 0}',
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  color: AppColor.SecondColor,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  },
                ),
              );
            }),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => Future.sync(
            () => _pagingController.refresh(),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: AppColor.HorizontalPadding),
                child: Scrollbar(
                  showTrackOnHover: true,
                  child: SingleChildScrollView(
                    //   controller: _scrollController,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Container(
                            height: 100,
                            child: Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {},
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      "https://www.manilaonsale.com/wp-content/uploads/2019/11/National-Everything-On-Sale-2019-Poster-1920x812.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              itemCount: titles.length,
                              viewportFraction: 0.85,
                              scale: 0.9,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 12),
                          child: Container(
                            height: 90,
                            child: FutureBuilder<CategoryModel>(
                                future: Data.getCategory(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData)
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 15,
                                      itemBuilder: (context, index) =>
                                          CategoryView(
                                              category: snapshot
                                                  .data.categories[index]),
                                    );
                                  else
                                    return  Center(
                                          child: CircularProgressIndicator()
                                    );
                                }),
                          ),
                        ),
                        Flexible(
                          child: PagedGridView<int, Products>(
                            pagingController: _pagingController,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.7,
                                    crossAxisCount:
                                        MediaQuery.of(context).size.width ~/
                                            150,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            builderDelegate:
                                PagedChildBuilderDelegate<Products>(
                                    itemBuilder: (context, item, index) =>
                                        ProductWidget(
                                          productsModel: item,
                                        )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 10,
                  child: Consumer<Cart>(
                    builder: (context, value, child) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));
                        },
                        child: value.getCartModel.isNotEmpty ? Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadiusDirectional.circular(8)),
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.white),
                                child: Text(
                                    value.getCartModel?.length.toString() ?? "0"),
                              ),

                              Text("View Cart",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400)),
                              Text(value.getCartModel.isNotEmpty ? "${value.getCartModel.map((e) => e.product.productPrice * e.count).reduce((value, element) => value + element)} L.E" : "0",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),)
                            ],
                          ),
                        ) : Container(),
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}

class CategoryView extends StatelessWidget {
  final Categories category;
  const CategoryView({
    Key key,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.ShadowColor,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(category.image, fit: BoxFit.fill),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
                height: 15,
                child: Text(
                  category.categoryNameEn,
                  style: TextStyle(
                      fontSize: 12,
                      color: AppColor.SilverColor,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                )),
          )
        ],
      ),
    );
  }
}
