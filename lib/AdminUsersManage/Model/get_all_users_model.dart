class GetAllCustomersModel {
  bool? success;
  List<Users>? users;

  GetAllCustomersModel({this.success, this.users});

  GetAllCustomersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phoneNumber;
  String? address;
  String? userType;
  String? salt;
  String? hash;
  int? iV;

  Users(
      {this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.gender,
        this.phoneNumber,
        this.address,
        this.userType,
        this.salt,
        this.hash,
        this.iV});

  Users.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    userType = json['userType'];
    salt = json['salt'];
    hash = json['hash'];
    iV = json['__v'];
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
    data['userType'] = this.userType;
    data['salt'] = this.salt;
    data['hash'] = this.hash;
    data['__v'] = this.iV;
    return data;
  }
}
