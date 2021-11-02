import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  late var status;
  late List<Products>? products;
  late var totalProducts;
  late  var totalPages;
  late  List<SpecificationsAll>? colors;
  late  List<SpecificationsAll>? materials;
  late  List<SpecificationsAll>? brands;
  late  List<SpecificationsAll>? dimensions;
  late  var lowestPrice;
  late  var highestPrice;

  ProductModel(
      {this.status,
      this.products,
      this.totalProducts,
      this.totalPages,
      this.colors,
      this.materials,
      this.brands,
      this.dimensions,
      this.lowestPrice,
      this.highestPrice});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    totalProducts = json['total_products'];
    totalPages = json['total_pages'];
    if (json['colors'] != null) {
      colors = <SpecificationsAll>[];
      json['colors'].forEach((v) {
        colors!.add(new SpecificationsAll.fromJson(v));
      });
    }
    if (json['materials'] != null) {
      materials = <SpecificationsAll>[];
      json['materials'].forEach((v) {
        materials!.add(new SpecificationsAll.fromJson(v));
      });
    }
    if (json['brands'] != null) {
      brands = <SpecificationsAll>[];
      json['brands'].forEach((v) {
        brands!.add(new SpecificationsAll.fromJson(v));
      });
    }
    if (json['dimensions'] != null) {
      dimensions = <SpecificationsAll>[];
      json['dimensions'].forEach((v) {
        dimensions!.add(new SpecificationsAll.fromJson(v));
      });
    }
    lowestPrice = json['lowest_price'];
    highestPrice = json['highest_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['total_products'] = this.totalProducts;
    data['total_pages'] = this.totalPages;
    if (this.colors != null) {
      data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    }
    if (this.materials != null) {
      data['materials'] = this.materials!.map((v) => v.toJson()).toList();
    }
    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }
    if (this.dimensions != null) {
      data['dimensions'] = this.dimensions!.map((v) => v.toJson()).toList();
    }
    data['lowest_price'] = this.lowestPrice;
    data['highest_price'] = this.highestPrice;
    return data;
  }
}

class Products {
  late var productId;
  late var productNameEn;
  late var productCategoryId;
  late var productCategoryNameEn;
  late var productCategoryNameAr;
  late var productPrice;
  late List<String>? productImages;
  late  var productBrandId;
  late  var productBrandNameEn;
  late  var productBrandNameAr;
  late  var isWishlisted;
  late  var isAvailable;
  late  List<Specifications>? specifications;
  late List<String>? relatedProducts;
  late var numberInUnit;
  late  var tilesInUnit;
  late var productDiscount;

  Products(
      {this.productId,
      this.productNameEn,
      this.productCategoryId,
      this.productCategoryNameEn,
      this.productCategoryNameAr,
      this.productPrice,
      this.productImages,
      this.productBrandId,
      this.productBrandNameEn,
      this.productBrandNameAr,
      this.isWishlisted,
      this.isAvailable,
      this.specifications,
      this.relatedProducts,
      this.numberInUnit,
      this.tilesInUnit,
      this.productDiscount});
  String get productImage {
    return "https://mazloum.genesiscreations.co/core/img/${productImages![0]}";
  }

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productNameEn = json['product_name_en'];
    productCategoryId = json['product_category_id'];
    productCategoryNameEn = json['product_category_name_en'];
    productCategoryNameAr = json['product_category_name_ar'];
    productPrice = json['product_price'];
    productImages = json['product_images'].cast<String>();
    productBrandId = json['product_brand_id'];
    productBrandNameEn = json['product_brand_name_en'];
    productBrandNameAr = json['product_brand_name_ar'];
    isWishlisted = json['is_wishlisted'];
    isAvailable = json['is_available'];
    if (json['specifications'] != null) {
      specifications = <Specifications>[];
      json['specifications'].forEach((v) {
        specifications!.add(new Specifications.fromJson(v));
      });
    }
    relatedProducts = json['related_products'].cast<String>();
    numberInUnit = json['number_in_unit'];
    tilesInUnit = json['tiles_in_unit'];
    productDiscount = json['product_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name_en'] = this.productNameEn;
    data['product_category_id'] = this.productCategoryId;
    data['product_category_name_en'] = this.productCategoryNameEn;
    data['product_category_name_ar'] = this.productCategoryNameAr;
    data['product_price'] = this.productPrice;
    data['product_images'] = this.productImages;
    data['product_brand_id'] = this.productBrandId;
    data['product_brand_name_en'] = this.productBrandNameEn;
    data['product_brand_name_ar'] = this.productBrandNameAr;
    data['is_wishlisted'] = this.isWishlisted;
    data['is_available'] = this.isAvailable;
    if (this.specifications != null) {
      data['specifications'] =
          this.specifications!.map((v) => v.toJson()).toList();
    }
    data['related_products'] = this.relatedProducts;
    data['number_in_unit'] = this.numberInUnit;
    data['tiles_in_unit'] = this.tilesInUnit;
    data['product_discount'] = this.productDiscount;
    return data;
  }
}

class Specifications {
  var specId;
  var specNameEn;
  var specNameAr;
  var valueId;
  var valueNameEn;
  var valueNameAr;

  Specifications(
      {this.specId,
      this.specNameEn,
      this.specNameAr,
      this.valueId,
      this.valueNameEn,
      this.valueNameAr});

  Specifications.fromJson(Map<String, dynamic> json) {
    specId = json['spec_id'];
    specNameEn = json['spec_name_en'];
    specNameAr = json['spec_name_ar'];
    valueId = json['value_id'];
    valueNameEn = json['value_name_en'];
    valueNameAr = json['value_name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spec_id'] = this.specId;
    data['spec_name_en'] = this.specNameEn;
    data['spec_name_ar'] = this.specNameAr;
    data['value_id'] = this.valueId;
    data['value_name_en'] = this.valueNameEn;
    data['value_name_ar'] = this.valueNameAr;
    return data;
  }
}
class SpecificationsAll with ChangeNotifier {
  var id;
  var nameEn;
  var nameAr;

  var selected = false;

  SpecificationsAll(
      {this.id,
        this.nameEn,
        this.nameAr});

  SpecificationsAll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    return data;
  }
  void setSelected(bool b){
    selected = b;
    notifyListeners();
  }
}
