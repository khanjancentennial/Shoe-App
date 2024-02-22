class ProductDetailModel {
  bool? success;
  Product? product;

  ProductDetailModel({this.success, this.product});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  String? sId;
  String? productName;
  String? brandName;
  String? shoeType;
  double? price;
  String? details;
  List<String>? imagesArray;
  List<String>? sizeArray;
  String? shoeColor;
  String? shoeSizeText;
  bool? isSelected;

  Product(
      {this.sId,
        this.productName,
        this.brandName,
        this.shoeType,
        this.price,
        this.details,
        this.imagesArray,
        this.sizeArray,
        this.shoeColor,
        this.shoeSizeText,
        this.isSelected});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    brandName = json['brandName'];
    shoeType = json['shoeType'];
    price = json['price'].toDouble();
    details = json['details'];
    imagesArray = json['imagesArray'].cast<String>();
    sizeArray = json['sizeArray'].cast<String>();
    shoeColor = json['shoeColor'];
    shoeSizeText = json['shoeSizeText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productName'] = this.productName;
    data['brandName'] = this.brandName;
    data['shoeType'] = this.shoeType;
    data['price'] = this.price;
    data['details'] = this.details;
    data['imagesArray'] = this.imagesArray;
    data['sizeArray'] = this.sizeArray;
    data['shoeColor'] = this.shoeColor;
    data['shoeSizeText'] = this.shoeSizeText;
    return data;
  }
}
