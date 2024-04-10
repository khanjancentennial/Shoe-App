class TopFiveProductsModel {
  bool? success;
  String? message;
  String? product1Name;
  int? product1Totalquantity;
  String? product2Name;
  int? product2Totalquantity;
  String? product3Name;
  int? product3Totalquantity;
  String? product4Name;
  int? product4Totalquantity;
  String? product5Name;
  int? product5Totalquantity;

  TopFiveProductsModel(
      {this.success,
        this.message,
        this.product1Name,
        this.product1Totalquantity,
        this.product2Name,
        this.product2Totalquantity,
        this.product3Name,
        this.product3Totalquantity,
        this.product4Name,
        this.product4Totalquantity,
        this.product5Name,
        this.product5Totalquantity});

  TopFiveProductsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    product1Name = json['product_1_name'];
    product1Totalquantity = json['product_1_totalquantity'];
    product2Name = json['product_2_name'];
    product2Totalquantity = json['product_2_totalquantity'];
    product3Name = json['product_3_name'];
    product3Totalquantity = json['product_3_totalquantity'];
    product4Name = json['product_4_name'];
    product4Totalquantity = json['product_4_totalquantity'];
    product5Name = json['product_5_name'];
    product5Totalquantity = json['product_5_totalquantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['product_1_name'] = this.product1Name;
    data['product_1_totalquantity'] = this.product1Totalquantity;
    data['product_2_name'] = this.product2Name;
    data['product_2_totalquantity'] = this.product2Totalquantity;
    data['product_3_name'] = this.product3Name;
    data['product_3_totalquantity'] = this.product3Totalquantity;
    data['product_4_name'] = this.product4Name;
    data['product_4_totalquantity'] = this.product4Totalquantity;
    data['product_5_name'] = this.product5Name;
    data['product_5_totalquantity'] = this.product5Totalquantity;
    return data;
  }
}
