class AllNumbersReport {
  bool? success;
  int? orders;
  int? users;
  int? products;

  AllNumbersReport({this.success, this.orders, this.users, this.products});

  AllNumbersReport.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    orders = json['orders'];
    users = json['users'];
    products = json['products'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['orders'] = this.orders;
    data['users'] = this.users;
    data['products'] = this.products;
    return data;
  }
}
