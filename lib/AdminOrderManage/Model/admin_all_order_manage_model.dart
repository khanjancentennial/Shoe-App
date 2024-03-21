class AdminOrdersManageModel {
  bool? success;
  List<Orders>? orders;

  AdminOrdersManageModel({this.success, this.orders});

  AdminOrdersManageModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  String? sId;
  Product? product;
  User? user;
  int? quantity;
  double? totalPrice;
  String? status;
  String? creationDate;
  String? updateDate;

  Orders(
      {this.sId,
        this.product,
        this.user,
        this.quantity,
        this.totalPrice,
        this.status,
        this.creationDate,
        this.updateDate});

  Orders.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    quantity = json['quantity'];
    totalPrice = json['totalPrice'].toDouble();
    status = json['status'];
    creationDate = json['creationDate'];
    updateDate = json['updateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['quantity'] = this.quantity;
    data['totalPrice'] = this.totalPrice;
    data['status'] = this.status;
    data['creationDate'] = this.creationDate;
    data['updateDate'] = this.updateDate;
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

class User {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phoneNumber;
  String? address;

  User(
      {this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.gender,
        this.phoneNumber,
        this.address});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    return data;
  }
}
