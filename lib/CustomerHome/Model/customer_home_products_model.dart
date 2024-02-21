class ProductsModel {
  bool? success;
  List<Products>? products;

  ProductsModel({this.success, this.products});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? sId;
  String? productName;
  String? brandName;
  String? shoeType;
  int? price;
  String? details;
  List<String>? imagesArray;
  List<double>? sizeArray;
  String? shoeColor;
  String? shoeSizeText;
  int? iV;

  Products(
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

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    brandName = json['brandName'];
    shoeType = json['shoeType'];
    price = json['price'];
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
