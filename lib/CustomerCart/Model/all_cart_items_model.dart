class AllCartItemsModel {
  bool? success;
  List<CartItems>? cartItems;

  AllCartItemsModel({this.success, this.cartItems});

  AllCartItemsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItems {
  String? sId;
  Product? product;
  String? userId;
  int? quantity;
  double? totalPrice;

  CartItems(
      {this.sId, this.product, this.userId, this.quantity, this.totalPrice});

  CartItems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    userId = json['userId'];
    quantity = json['quantity'];
    totalPrice = json['totalPrice'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['userId'] = this.userId;
    data['quantity'] = this.quantity;
    data['totalPrice'] = this.totalPrice;
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
  List<double>? sizeArray;
  String? shoeColor;
  String? shoeSizeText;
  int? iV;

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
        this.iV});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    brandName = json['brandName'];
    shoeType = json['shoeType'];
    price = json['price'].toDouble();
    details = json['details'];
    imagesArray = json['imagesArray'].cast<String>();
    sizeArray = json['sizeArray'].cast<double>();
    shoeColor = json['shoeColor'];
    shoeSizeText = json['shoeSizeText'];
    iV = json['__v'];
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
    data['__v'] = this.iV;
    return data;
  }
}
