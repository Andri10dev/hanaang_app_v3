class UserLoginModel {
  final User user;
  final String tokenType;
  final String accessToken;

  UserLoginModel({
    required this.user,
    required this.tokenType,
    required this.accessToken,
  });

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      user: User.fromJson(json['user']),
      tokenType: json['token_type'],
      accessToken: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token_type': tokenType,
      'access_token': accessToken,
    };
  }
}

class User {
  final String uniqueId;
  final String name;
  final String? phoneNumber;
  final String email;
  final String status;
  final String role;

  User({
    required this.uniqueId,
    required this.name,
    this.phoneNumber,
    required this.email,
    required this.status,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uniqueId: json['unique_id'],
      name: json['name'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      status: json['status'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unique_id': uniqueId,
      'name': name,
      'phone_number': phoneNumber,
      'email': email,
      'status': status,
      'role': role,
    };
  }
}
