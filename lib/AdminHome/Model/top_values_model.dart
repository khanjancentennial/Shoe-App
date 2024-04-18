class TopValuesModel {
  bool? success;
  List<Orders>? orders;
  double? mondayRevenue;
  double? tuesdayRevenue;
  double? wednesdayRevenue;
  double? thursdayRevenue;
  double? fridayRevenue;
  double? saturdayRevenue;
  double? sundayRevenue;
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
    mondayRevenue = json['mondayRevenue'].toDouble();
    tuesdayRevenue = json['tuesdayRevenue'].toDouble();
    wednesdayRevenue = json['wednesdayRevenue'].toDouble();
    thursdayRevenue = json['thursdayRevenue'].toDouble();
    fridayRevenue = json['fridayRevenue'].toDouble();
    saturdayRevenue = json['saturdayRevenue'].toDouble();
    sundayRevenue = json['sundayRevenue'].toDouble();
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
  String? updateDate;
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
