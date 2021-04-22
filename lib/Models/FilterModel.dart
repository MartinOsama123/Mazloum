import 'package:flutter/material.dart';

class FilterModel with ChangeNotifier{
  List<dynamic> brands= [],colors = [],dims = [],mats=[];
  String filterQuery = "";
  void addBrand(final temp){
    brands.add(temp);
    notifyListeners();
  }
  void addColor(final temp){
    colors.add(temp);
    notifyListeners();
  }
  void addDim(final temp){
    dims.add(temp);
    notifyListeners();
  }
  void addMat(final temp){
    mats.add(temp);
    notifyListeners();
  }
  void removeBrand(final temp){
    brands.remove(brands.where((element) => temp == element));
    notifyListeners();
  }
  void removeColor(final temp){
    colors.remove(colors.where((element) => temp == element));
    notifyListeners();
  }
  void removeMat(final temp){
    mats.remove(mats.where((element) => temp == element));
    notifyListeners();
  }
  void removeDim(final temp){
    dims.remove(dims.where((element) => temp == element));
    notifyListeners();
  }
  void changeFilterQuery(String temp){
    filterQuery = temp;
    notifyListeners();
  }
}