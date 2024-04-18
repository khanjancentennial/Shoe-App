class TopFiveProductsModel {
  bool? success;
  String? message;
  String? num1Name;
  int? num1Totalquantity;
  String? num2Name;
  int? num2Totalquantity;
  String? num3Name;
  int? num3Totalquantity;
  String? num4Name;
  int? num4Totalquantity;
  String? num5Name;
  int? num5Totalquantity;

  TopFiveProductsModel(
      {this.success,
        this.message,
        this.num1Name,
        this.num1Totalquantity,
        this.num2Name,
        this.num2Totalquantity,
        this.num3Name,
        this.num3Totalquantity,
        this.num4Name,
        this.num4Totalquantity,
        this.num5Name,
        this.num5Totalquantity});

  TopFiveProductsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    num1Name = json['num_1_name'];
    num1Totalquantity = json['num_1_totalquantity'];
    num2Name = json['num_2_name'];
    num2Totalquantity = json['num_2_totalquantity'];
    num3Name = json['num_3_name'];
    num3Totalquantity = json['num_3_totalquantity'];
    num4Name = json['num_4_name'];
    num4Totalquantity = json['num_4_totalquantity'];
    num5Name = json['num_5_name'];
    num5Totalquantity = json['num_5_totalquantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['num_1_name'] = this.num1Name;
    data['num_1_totalquantity'] = this.num1Totalquantity;
    data['num_2_name'] = this.num2Name;
    data['num_2_totalquantity'] = this.num2Totalquantity;
    data['num_3_name'] = this.num3Name;
    data['num_3_totalquantity'] = this.num3Totalquantity;
    data['num_4_name'] = this.num4Name;
    data['num_4_totalquantity'] = this.num4Totalquantity;
    data['num_5_name'] = this.num5Name;
    data['num_5_totalquantity'] = this.num5Totalquantity;
    return data;
  }
}
