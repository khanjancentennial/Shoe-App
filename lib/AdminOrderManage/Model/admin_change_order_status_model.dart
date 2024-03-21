class AdminChangeOrderStatusModel {
  bool? success;
  String? message;

  AdminChangeOrderStatusModel({this.success, this.message});

  AdminChangeOrderStatusModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}