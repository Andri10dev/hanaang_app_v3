class UserModel {
  final String uniqueId;
  final String? image;
  final String name;
  final String? phoneNumber;
  final String email;
  final String role;
  final String status;

  UserModel({
    required this.uniqueId,
    this.image,
    required this.name,
    this.phoneNumber,
    required this.email,
    required this.role,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uniqueId: json['unique_id'].toString(),
      image: json['image'],
      name: json['name'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      role: json['role'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unique_id': uniqueId,
      'image': image,
      'name': name,
      'phone_number': phoneNumber,
      'email': email,
      'role': role,
      'status': status,
    };
  }
}
