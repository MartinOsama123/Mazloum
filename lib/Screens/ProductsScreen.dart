import 'package:flutter/material.dart';
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
     body:   RefreshIndicator(
       onRefresh: () => Future.sync(
             () => _pagingController.refresh(),
       ),
       child: PagedListView<int, Products>(
           pagingController: _pagingController,
           builderDelegate: PagedChildBuilderDelegate<Products>(
             itemBuilder: (context, item, index) => GridViewWidget(length: _pagingController.itemList.length,products: _pagingController.itemList)
           ),
         ),
     )

   );
  }
}