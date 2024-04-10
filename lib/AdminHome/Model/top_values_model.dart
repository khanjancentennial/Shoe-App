class TopValuesModel {
  bool? success;
  List<Orders>? orders;
  int? mondayRevenue;
  double? tuesdayRevenue;
  double? wednesdayRevenue;
  int? thursdayRevenue;
  double? fridayRevenue;
  int? saturdayRevenue;
  int? sundayRevenue;
  String? message;

  TopValuesModel(
      {this.success,
        this.orders,
        this.mondayRevenue,
        this.tuesdayRevenue,
        this.wednesdayRevenue,
        this.thursdayRevenue,
        this.fridayRevenue,
        this.saturdayRevenue,
        this.sundayRevenue,
        this.message});

  TopValuesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
    mondayRevenue = json['mondayRevenue'];
    tuesdayRevenue = json['tuesdayRevenue'];
    wednesdayRevenue = json['wednesdayRevenue'];
    thursdayRevenue = json['thursdayRevenue'];
    fridayRevenue = json['fridayRevenue'];
    saturdayRevenue = json['saturdayRevenue'];
    sundayRevenue = json['sundayRevenue'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    data['mondayRevenue'] = this.mondayRevenue;
    data['tuesdayRevenue'] = this.tuesdayRevenue;
    data['wednesdayRevenue'] = this.wednesdayRevenue;
    data['thursdayRevenue'] = this.thursdayRevenue;
    data['fridayRevenue'] = this.fridayRevenue;
    data['saturdayRevenue'] = this.saturdayRevenue;
    data['sundayRevenue'] = this.sundayRevenue;
    data['message'] = this.message;
    return data;
  }
}

class Orders {
  String? sId;
  String? productId;
  String? userId;
  int? quantity;
  double? totalPrice;
  String? status;
  String? creationDate;
  Null? updateDate;
  int? iV;

  Orders(
      {this.sId,
        this.productId,
        this.userId,
        this.quantity,
        this.totalPrice,
        this.status,
        this.creationDate,
        this.updateDate,
        this.iV});

  Orders.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['productId'];
    userId = json['userId'];
    quantity = json['quantity'];
    totalPrice = json['totalPrice'].toDouble();
    status = json['status'];
    creationDate = json['creationDate'];
    updateDate = json['updateDate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productId'] = this.productId;
    data['userId'] = this.userId;
    data['quantity'] = this.quantity;
    data['totalPrice'] = this.totalPrice;
    data['status'] = this.status;
    data['creationDate'] = this.creationDate;
    data['updateDate'] = this.updateDate;
    data['__v'] = this.iV;
    return data;
  }
}
