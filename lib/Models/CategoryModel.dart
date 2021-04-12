class CategoryModel {
  String status;
  List<Categories> categories;

  CategoryModel({String status, List<Categories> categories}) {
    this.status = status;
    this.categories = categories;
  }


  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int categoryId;
  String categoryNameEn;
  String categoryNameAr;
  int parentCategoryId;
  String _image;

  String get image => "https://mazloum.genesiscreations.co/core/img/categories/$categoryId.png";

  Categories(
      {int categoryId,
        String categoryNameEn,
        String categoryNameAr,
        int parentCategoryId}) {
    this.categoryId = categoryId;
    this.categoryNameEn = categoryNameEn;
    this.categoryNameAr = categoryNameAr;
    this.parentCategoryId = parentCategoryId;
  }



  Categories.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryNameEn = json['category_name_en'];
    categoryNameAr = json['category_name_ar'];
    parentCategoryId = json['parent_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name_en'] = this.categoryNameEn;
    data['category_name_ar'] = this.categoryNameAr;
    data['parent_category_id'] = this.parentCategoryId;
    return data;
  }
}
