class CategoryModel {
  String _status;
  List<Categories> _categories;

  CategoryModel({String status, List<Categories> categories}) {
    this._status = status;
    this._categories = categories;
  }


  CategoryModel.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    if (json['categories'] != null) {
      _categories = <Categories>[];
      json['categories'].forEach((v) {
        _categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    if (this._categories != null) {
      data['categories'] = this._categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int _categoryId;
  String _categoryNameEn;
  String _categoryNameAr;
  int _parentCategoryId;

  Categories(
      {int categoryId,
        String categoryNameEn,
        String categoryNameAr,
        int parentCategoryId}) {
    this._categoryId = categoryId;
    this._categoryNameEn = categoryNameEn;
    this._categoryNameAr = categoryNameAr;
    this._parentCategoryId = parentCategoryId;
  }



  Categories.fromJson(Map<String, dynamic> json) {
    _categoryId = json['category_id'];
    _categoryNameEn = json['category_name_en'];
    _categoryNameAr = json['category_name_ar'];
    _parentCategoryId = json['parent_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this._categoryId;
    data['category_name_en'] = this._categoryNameEn;
    data['category_name_ar'] = this._categoryNameAr;
    data['parent_category_id'] = this._parentCategoryId;
    return data;
  }
}
