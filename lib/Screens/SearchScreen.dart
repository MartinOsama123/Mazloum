import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:vendors/AppColor.dart';
import 'package:vendors/Data.dart';
import 'package:vendors/Models/FilterModel.dart';
import 'package:vendors/Models/ProductModel.dart';
import 'package:vendors/Screens/DetailedScreen.dart';
import 'package:vendors/Widgets/ImageView.dart';
import 'package:vendors/Widgets/PriceText.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchQueryController = TextEditingController();
  String searchQuery = "", previousSearch = "", filterQuery = "";
  bool _showClearButton = false;
  bool _isLoading = true;
  List<bool> expandedList = [false, false, false, false];
  final PagingController<int, Products> _pagingController =
      PagingController(firstPageKey: 1);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  FilterModel filterModel;
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(searchQuery, pageKey);
    });
    print("State entered");
    _searchQueryController.addListener(() {
      setState(() {
        _showClearButton = _searchQueryController.text.length > 0;
      });
    });
    filterModel = FilterModel();
    super.initState();
  }

  Future<void> _fetchPage(String query, int pageKey) async {
    try {
      if (searchQuery != previousSearch) {
        _pagingController.itemList = [];
      }
      previousSearch = searchQuery;
      final newItems = await Data.getProductsList(
          query:
              "${searchQuery.isNotEmpty ? "&search=$searchQuery" : ""}$filterQuery",
          page: pageKey);
      print("entereeeed");
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FilterModel>.value(
      value: filterModel,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildSearchField(),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColor.SecondColor),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list, color: AppColor.SecondColor),
              onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
            )
          ],
        ),
        endDrawer: Drawer(
          child: FutureBuilder<ProductModel>(
            future: Data.getProducts(query: searchQuery.isNotEmpty ? "&search=$searchQuery" : ""),
            builder: (context, snapshot) => snapshot.hasData
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: ListView(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      children: <Widget>[
                        ExpansionPanelList(
                          animationDuration: Duration(milliseconds: 800),
                          expansionCallback: (panelIndex, isExpanded) {setState(() {
                            expandedList[panelIndex] = !isExpanded;
                          });},
                          children: [
                            ExpansionPanel(
                                headerBuilder: (context, isExpanded) =>
                                    ListTile(
                                      title: Text("Brands"),
                                    ),
                                body: FilterList(
                                    title: "Brands",
                                    productModel: snapshot.data.brands),isExpanded: expandedList[0]),
                            ExpansionPanel(
                                headerBuilder: (context, isExpanded) =>
                                    ListTile(
                                      title: Text("Colors"),
                                    ),
                                body: FilterList(
                                    title: "Colors",
                                    productModel: snapshot.data.colors),isExpanded: expandedList[1]),
                            ExpansionPanel(
                                headerBuilder: (context, isExpanded) =>
                                    ListTile(
                                      title: Text("Dimensions"),
                                    ),
                                body: FilterList(
                                    title: "Dimensions",
                                    productModel: snapshot.data.dimensions),isExpanded: expandedList[2]),
                            ExpansionPanel(
                                headerBuilder: (context, isExpanded) =>
                                    ListTile(
                                      title: Text("Materials"),
                                    ),
                                body: FilterList(
                                    title: "Materials",
                                    productModel: snapshot.data.materials),isExpanded: expandedList[3])
                          ],
                        ),
                        Consumer<FilterModel>(
                          builder: (context, value, child) =>
                            FlatButton(
                                onPressed: () {
                                  filterQuery = "";
                                  setState(() {
                                    if (filterModel.brands != null &&
                                        filterModel.brands.isNotEmpty) {
                                      filterQuery = "&brand=";
                                      filterQuery +=
                                          filterModel.brands[0].toString();
                                      for (int i = 1;
                                          i < filterModel.brands.length;
                                          i++) {
                                        filterQuery +=
                                            "-${filterModel.brands[i]}";
                                      }
                                    }
                                    if (filterModel.colors != null &&
                                        filterModel.colors.isNotEmpty) {
                                      filterQuery = "&colors=";
                                      filterQuery +=
                                          filterModel.colors[0].toString();
                                      for (int i = 1;
                                          i < filterModel.colors.length;
                                          i++) {
                                        filterQuery +=
                                            "-${filterModel.colors[i]}";
                                      }
                                    }
                                    if (filterModel.dims != null &&
                                        filterModel.dims.isNotEmpty) {
                                      filterQuery = "&dimensions=";
                                      filterQuery +=
                                          filterModel.dims[0].toString();
                                      for (int i = 1;
                                          i < filterModel.dims.length;
                                          i++) {
                                        filterQuery += "-${filterModel.dims[i]}";
                                      }
                                    }
                                    if (filterModel.mats != null &&
                                        filterModel.mats.isNotEmpty) {
                                      filterQuery = "&materials=";
                                      filterQuery +=
                                          filterModel.mats[0].toString();
                                      for (int i = 1;
                                          i < filterModel.mats.length;
                                          i++) {
                                        filterQuery += "-${filterModel.mats[i]}";
                                      }
                                    }

                                    filterModel = FilterModel();
                                  });
                                  _pagingController.refresh();
                                  Navigator.pop(context, true);
                                },
                                child: Text("Apply")),

                        )
                      ],
                    ),
                  )
                : CircularProgressIndicator(),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 10),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                    child: Consumer<FilterModel>(
                      builder: (context, value, child) =>
                          PagedListView<int, Products>(
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          DetailedScreen(
                                                              product: item)));
                                        },
                                        child: ListTile(
                                            leading: Container(
                                              width: 100,
                                              height: 150,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: ImageView(
                                                    productsModel: item),
                                              ),
                                            ),
                                            title: Text(item.productNameEn,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            subtitle: Align(
                                                alignment: Alignment.centerLeft,
                                                child: PriceText(
                                                  price: item.productPrice,
                                                  discount:
                                                      item.productDiscount,
                                                ))),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    )
                                  ],
                                )),
                      ),
                    ),
                  ),
                )
              ],
            ),
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
          print("Etter");
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

class FilterList extends StatefulWidget {
  final productModel;
  final String title;

  const FilterList({Key key, this.productModel, this.title}) : super(key: key);
  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FilterModel>(
      builder: (context, filter, child) => ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.productModel.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
                value: widget.productModel[index].selected,
                title: Text(widget.productModel[index].nameEn ?? ""),
                onChanged: (bool value) {
                  widget.productModel[index].setSelected(value);
                  if (widget.productModel[index].selected) {
                    if (widget.title == "Brands") {
                      filter.addBrand(widget.productModel[index].id);
                    } else if (widget.title == "Colors") {
                      filter.addColor(widget.productModel[index].id);
                    } else if (widget.title == "Dimensions") {
                      filter.addDim(widget.productModel[index].id);
                    } else if (widget.title == "Materials") {
                      filter.addMat(widget.productModel[index].id);
                    }
                  } else {
                    if (widget.title == "Brands") {
                      filter.removeBrand(widget.productModel[index].id);
                    } else if (widget.title == "Colors") {
                      filter.removeColor(widget.productModel[index].id);
                    } else if (widget.title == "Dimensions") {
                      filter.removeDim(widget.productModel[index].id);
                    } else if (widget.title == "Materials") {
                      filter.removeMat(widget.productModel[index].id);
                    }
                  }
                });
          }),
    );
  }
}
