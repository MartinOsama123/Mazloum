import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:vendors/Models/ProductModel.dart';
import 'package:vendors/Screens/GridViewWidget.dart';
import 'package:vendors/Screens/HomeScreen/Widgets/ProductWidget.dart';

import '../Data.dart';

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
    try {
      final newItems = await Data.getProductsList(page: pageKey);
      print(newItems);
      final isLastPage = newItems.length < 10;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () => Future.sync(
        () => _pagingController.refresh(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SingleChildScrollView(
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
                  height: 70,
                  child: ListView.builder(

                    scrollDirection: Axis.horizontal,
                    itemCount: 15,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black,
                          ),
                          Text("Item")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: PagedGridView<int, Products>(
                  pagingController: _pagingController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.7,
                      crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  builderDelegate: PagedChildBuilderDelegate<Products>(
                      itemBuilder: (context, item, index) => ProductWidget(
                            productsModel: item,
                          )),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
