class AuthModel {
  AuthModel({
      this.status, 
      this.message, 
      this.user,});

  AuthModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? status;
  String? message;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

class User {
  User({
      this.name, 
      this.email, 
      this.phone, 
      this.nationalId, 
      this.gender, 
      this.profileImage, 
      this.token,});

  User.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    nationalId = json['nationalId'];
    gender = json['gender'];
    profileImage = json['profileImage'];
    token = json['token'];
  }
  String? name;
  String? email;
  String? phone;
  String? nationalId;
  String? gender;
  String? profileImage;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['nationalId'] = nationalId;
    map['gender'] = gender;
    map['profileImage'] = profileImage;
    map['token'] = token;
    return map;
  }

}