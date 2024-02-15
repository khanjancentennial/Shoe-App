class LoginModel {
  bool? success;
  User? user;

  LoginModel({this.success, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? userType;
  String? gender;
  String? phoneNumber;
  String? address;

  User(
      {this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.userType,
        this.gender,
        this.phoneNumber,
        this.address});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    userType = json['userType'];
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
    data['userType'] = this.userType;
    data['gender'] = this.gender;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    return data;
  }
}
