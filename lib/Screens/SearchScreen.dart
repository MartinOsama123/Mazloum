import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:vendors/AppColor.dart';
import 'package:vendors/Data.dart';
import 'package:vendors/Models/ProductModel.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchQueryController = TextEditingController();
  String searchQuery = "", previousSearch = "";
  bool _showClearButton = false;
  bool _isLoading = true;
  final PagingController<int, Products> _pagingController =
  PagingController(firstPageKey: 1);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(searchQuery, pageKey);
    });
    _searchQueryController.addListener(() {
      setState(() {
        _showClearButton = _searchQueryController.text.length > 0;
      });
    });
    super.initState();
  }

  Future<void> _fetchPage(String query, int pageKey) async {
    try {
      if (searchQuery != previousSearch) {
        _pagingController.itemList = [];
      }
      previousSearch = searchQuery;
      final newItems = await Data.getProductsList(query: "&search=$searchQuery", page: pageKey);

      final isLastPage = newItems.length < 12;
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
      key: _scaffoldKey,
      appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildSearchField(),
      ),leading: IconButton(icon: Icon(Icons.arrow_back,color: AppColor.SecondColor),onPressed: () => Navigator.pop(context),),centerTitle: true,actions: [
        IconButton(
          icon: Icon(Icons.filter_list,color: AppColor.SecondColor),
          onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
        )
      ],),
      endDrawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: ListView(

            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                title: Text('Item 1'),
                onTap: () {

                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {

                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 10),
          child: Column(
            children: [
              if (searchQuery.isNotEmpty)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                    child: PagedListView<int, Products>(
                      pagingController: _pagingController,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      builderDelegate: PagedChildBuilderDelegate<Products>(
                          noItemsFoundIndicatorBuilder: (context) => Center(
                            child: _isLoading
                                ? CircularProgressIndicator()
                                : Text(
                              "No items found...",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                          ),
                          itemBuilder: (context, item, index) => Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // print(item.id);
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder:
                                    //             (BuildContext context) =>
                                    //             DetailedScreen(
                                    //               movieResult: item,
                                    //             )));
                                  },
                                  child: ListTile(
                                    leading: Container(
                                      width: 100,
                                      height: 150,
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                            imageUrl: item.productImage,
                                            progressIndicatorBuilder: (context,
                                                url,
                                                downloadProgress) =>
                                                Center(
                                                    child:
                                                    CircularProgressIndicator(
                                                      value: downloadProgress
                                                          .progress,
                                                      backgroundColor:
                                                      Colors.red,
                                                    )),
                                            errorWidget:
                                                (context, url, error) =>
                                                Container(
                                                    child: Image.asset(
                                                      "assets/download.png",
                                                      fit: BoxFit.cover,
                                                    )),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    title: Text(item.productNameEn,
                                        style:
                                        TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w600)),
                                    subtitle: Text("${item.productPrice} L.E",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColor.PrimaryColor),),

                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                              )
                            ],
                          )),
                    ),
                  ),
                )
              else
                Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
        controller: _searchQueryController,
        autofocus: false,
        decoration: InputDecoration(
          hintText: "Search Data...",
          contentPadding: const EdgeInsets.all(10),
          suffixIcon: _getClearButton(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintStyle: TextStyle(color: Colors.grey),
        ),
        style: TextStyle(color: Colors.black, fontSize: 16.0),
        //     onChanged: (value) {
        //       setState(() {
        //         _isLoading = true;
        //       });
        //       updateSearchQuery(value);
        //
        //       new Timer(const Duration(milliseconds: 1000), () {
        //         setState(() {
        // _isLoading = false;
        // }
        //         );
        //       });
        //
        //     },
        onSubmitted: (value) {
          updateSearchQuery(value);
          setState(() {
            _isLoading = true;
          });
          _pagingController.refresh();
          new Timer(const Duration(milliseconds: 8000), () {
            setState(() {
              _isLoading = false;
            });
          });
        });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  Widget _getClearButton() {
    if (!_showClearButton) {
      return null;
    }
    return IconButton(
      onPressed: () => _searchQueryController.clear(),
      icon: Icon(Icons.clear),
    );
  }
}
