class UpdateProfileResponse {
  UpdateProfileResponse({
      this.status,
      this.message,
      this.user,});

  UpdateProfileResponse.fromJson(dynamic json) {
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
      this.id,
      this.name,
      this.email,
      this.phone,
      this.gender,
      this.password,});

  User.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    password = json['password'];
  }
  String? id;
  String? name;
  String? email;
  String? phone;
  String? gender;
  String? password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['gender'] = gender;
    map['password'] = password;
    return map;
  }

}