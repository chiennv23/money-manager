import 'package:coresystem/Core/BaseResponse.dart';

class registerItem {
  String fullname;
  String phoneNumber;
  String email;
  String address;
  String provinceCode;
  String districtCode;
  String communeCode;
  String password;

  registerItem(
      {this.fullname,
      this.phoneNumber,
      this.email,
      this.address,
      this.provinceCode,
      this.districtCode,
      this.communeCode,
      this.password});

  registerItem.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    address = json['address'];
    provinceCode = json['provinceCode'];
    districtCode = json['districtCode'];
    communeCode = json['communeCode'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = fullname;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['address'] = address;
    data['provinceCode'] = provinceCode;
    data['districtCode'] = districtCode;
    data['communeCode'] = communeCode;
    data['password'] = password;
    return data;
  }
}

class registerSuccessItem {
  String username;
  String fullname;
  String phoneNumber;
  String email;
  String address;
  String provinceCode;
  String districtCode;
  String communeCode;
  String password;
  String roles;
  String type;

  registerSuccessItem(
      {this.username,
      this.fullname,
      this.phoneNumber,
      this.email,
      this.address,
      this.provinceCode,
      this.districtCode,
      this.communeCode,
      this.password,
      this.roles,
      this.type});

  registerSuccessItem.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullname = json['fullname'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    address = json['address'];
    provinceCode = json['provinceCode'];
    districtCode = json['districtCode'];
    communeCode = json['communeCode'];
    password = json['password'];
    roles = json['roles'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['fullname'] = this.fullname;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['address'] = this.address;
    data['provinceCode'] = this.provinceCode;
    data['districtCode'] = this.districtCode;
    data['communeCode'] = this.communeCode;
    data['password'] = this.password;
    data['roles'] = this.roles;
    data['type'] = this.type;
    return data;
  }
}
