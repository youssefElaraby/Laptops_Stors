class UserProfileResponse {
  final String? name;
  final String? email;
  final String? phone;
  final String? nationalId;
  final String? gender;
  final String? profileImage;
  final String? token;

  UserProfileResponse({
    this.name,
    this.email,
    this.phone,
    this.nationalId,
    this.gender,
    this.profileImage,
    this.token,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    return UserProfileResponse(
      name: user['name'],
      email: user['email'],
      phone: user['phone'],
      nationalId: user['nationalId'],
      gender: user['gender'],
      profileImage: user['profileImage'],
      token: user['token'],
    );
  }
}
