class ProductModel {
  String _status;
  List<Products> _products;
  int _totalProducts;
  int _totalPages;
  List<Specifications> _colors;
  List<Specifications> _materials;
  List<Specifications> _brands;
  List<Specifications> _dimensions;
  int _lowestPrice;
  int _highestPrice;

  ProductModel(
      {String status,
        List<Products> products,
        int totalProducts,
        int totalPages,
        List<Specifications> colors,
        List<Specifications> materials,
        List<Specifications> brands,
        List<Specifications> dimensions,
        int lowestPrice,
        int highestPrice}) {
    this._status = status;
    this._products = products;
    this._totalProducts = totalProducts;
    this._totalPages = totalPages;
    this._colors = colors;
    this._materials = materials;
    this._brands = brands;
    this._dimensions = dimensions;
    this._lowestPrice = lowestPrice;
    this._highestPrice = highestPrice;
  }


  ProductModel.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    if (json['products'] != null) {
      _products = <Products>[];
      json['products'].forEach((v) {
        _products.add(new Products.fromJson(v));
      });
    }
    _totalProducts = json['total_products'];
    _totalPages = json['total_pages'];
    if (json['colors'] != null) {
      _colors = <Specifications>[];
      json['colors'].forEach((v) {
        _colors.add(new Specifications.fromJson(v));
      });
    }
    if (json['materials'] != null) {
      _materials = <Specifications>[];
      json['materials'].forEach((v) {
        _materials.add(new Specifications.fromJson(v));
      });
    }
    if (json['brands'] != null) {
      _brands = <Specifications>[];
      json['brands'].forEach((v) {
        _brands.add(new Specifications.fromJson(v));
      });
    }
    if (json['dimensions'] != null) {
      _dimensions = <Specifications>[];
      json['dimensions'].forEach((v) {
        _dimensions.add(new Specifications.fromJson(v));
      });
    }
    _lowestPrice = json['lowest_price'];
    _highestPrice = json['highest_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    if (this._products != null) {
      data['products'] = this._products.map((v) => v.toJson()).toList();
    }
    data['total_products'] = this._totalProducts;
    data['total_pages'] = this._totalPages;
    if (this._colors != null) {
      data['colors'] = this._colors.map((v) => v.toJson()).toList();
    }
    if (this._materials != null) {
      data['materials'] = this._materials.map((v) => v.toJson()).toList();
    }
    if (this._brands != null) {
      data['brands'] = this._brands.map((v) => v.toJson()).toList();
    }
    if (this._dimensions != null) {
      data['dimensions'] = this._dimensions.map((v) => v.toJson()).toList();
    }
    data['lowest_price'] = this._lowestPrice;
    data['highest_price'] = this._highestPrice;
    return data;
  }
}

class Products {
  String _productId;
  String _productNameEn;
  int _productCategoryId;
  String _productCategoryNameEn;
  String _productCategoryNameAr;
  int _productPrice;
  List<String> _productImages;
  int _productBrandId;
  String _productBrandNameEn;
  String _productBrandNameAr;
  int _productDiscount;
  String _isWishlisted;
  String _isAvailable;
  List<Specifications> _specifications;
  List<String> _relatedProducts;
  int _numberInUnit;
  int _tilesInUnit;

  Products(
      {String productId,
        String productNameEn,
        int productCategoryId,
        String productCategoryNameEn,
        String productCategoryNameAr,
        int productPrice,
        List<String> productImages,
        int productBrandId,
        String productBrandNameEn,
        String productBrandNameAr,
        int productDiscount,
        String isWishlisted,
        String isAvailable,
        List<Specifications> specifications,
        List<String> relatedProducts,
        int numberInUnit,
        int tilesInUnit}) {
    this._productId = productId;
    this._productNameEn = productNameEn;
    this._productCategoryId = productCategoryId;
    this._productCategoryNameEn = productCategoryNameEn;
    this._productCategoryNameAr = productCategoryNameAr;
    this._productPrice = productPrice;
    this._productImages = productImages;
    this._productBrandId = productBrandId;
    this._productBrandNameEn = productBrandNameEn;
    this._productBrandNameAr = productBrandNameAr;
    this._productDiscount = productDiscount;
    this._isWishlisted = isWishlisted;
    this._isAvailable = isAvailable;
    this._specifications = specifications;
    this._relatedProducts = relatedProducts;
    this._numberInUnit = numberInUnit;
    this._tilesInUnit = tilesInUnit;
  }



  Products.fromJson(Map<String, dynamic> json) {
    _productId = json['product_id'];
    _productNameEn = json['product_name_en'];
    _productCategoryId = json['product_category_id'];
    _productCategoryNameEn = json['product_category_name_en'];
    _productCategoryNameAr = json['product_category_name_ar'];
    _productPrice = json['product_price'];
    _productImages = json['product_images'].cast<String>();
    _productBrandId = json['product_brand_id'];
    _productBrandNameEn = json['product_brand_name_en'];
    _productBrandNameAr = json['product_brand_name_ar'];
    _productDiscount = json['product_discount'];
    _isWishlisted = json['is_wishlisted'];
    _isAvailable = json['is_available'];
    if (json['specifications'] != null) {
      _specifications = <Specifications>[];
      json['specifications'].forEach((v) {
        _specifications.add(new Specifications.fromJson(v));
      });
    }
    _relatedProducts = json['related_products'].cast<String>();
    _numberInUnit = json['number_in_unit'];
    _tilesInUnit = json['tiles_in_unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this._productId;
    data['product_name_en'] = this._productNameEn;
    data['product_category_id'] = this._productCategoryId;
    data['product_category_name_en'] = this._productCategoryNameEn;
    data['product_category_name_ar'] = this._productCategoryNameAr;
    data['product_price'] = this._productPrice;
    data['product_images'] = this._productImages;
    data['product_brand_id'] = this._productBrandId;
    data['product_brand_name_en'] = this._productBrandNameEn;
    data['product_brand_name_ar'] = this._productBrandNameAr;
    data['product_discount'] = this._productDiscount;
    data['is_wishlisted'] = this._isWishlisted;
    data['is_available'] = this._isAvailable;
    if (this._specifications != null) {
      data['specifications'] =
          this._specifications.map((v) => v.toJson()).toList();
    }
    data['related_products'] = this._relatedProducts;
    data['number_in_unit'] = this._numberInUnit;
    data['tiles_in_unit'] = this._tilesInUnit;
    return data;
  }
}

class Specifications {
  int _specId;
  String _specNameEn;
  String _specNameAr;
  int _valueId;
  String _valueNameEn;
  String _valueNameAr;

  Specifications(
      {int specId,
        String specNameEn,
        String specNameAr,
        int valueId,
        String valueNameEn,
        String valueNameAr}) {
    this._specId = specId;
    this._specNameEn = specNameEn;
    this._specNameAr = specNameAr;
    this._valueId = valueId;
    this._valueNameEn = valueNameEn;
    this._valueNameAr = valueNameAr;
  }



  Specifications.fromJson(Map<String, dynamic> json) {
    _specId = json['spec_id'];
    _specNameEn = json['spec_name_en'];
    _specNameAr = json['spec_name_ar'];
    _valueId = json['value_id'];
    _valueNameEn = json['value_name_en'];
    _valueNameAr = json['value_name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spec_id'] = this._specId;
    data['spec_name_en'] = this._specNameEn;
    data['spec_name_ar'] = this._specNameAr;
    data['value_id'] = this._valueId;
    data['value_name_en'] = this._valueNameEn;
    data['value_name_ar'] = this._valueNameAr;
    return data;
  }
}


