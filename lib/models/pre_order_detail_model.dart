import 'package:hanaang_app/models/user_model.dart';

class PreOrderDetailModel {
  final String id;
  final String poNumber;
  final int quantity;
  final int price;
  final int bonus;
  final int cashback;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel user;

  PreOrderDetailModel({
    required this.id,
    required this.poNumber,
    required this.quantity,
    required this.price,
    required this.bonus,
    required this.cashback,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory PreOrderDetailModel.fromJson(Map<String, dynamic> json) {
    return PreOrderDetailModel(
      id: json['id'],
      poNumber: json['po_number'],
      quantity: json['quantity'],
      price: json['price'],
      bonus: json['bonus'],
      cashback: json['cashback'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'po_number': poNumber,
      'quantity': quantity,
      'price': price,
      'bonus': bonus,
      'cashback': cashback,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'user': user.toJson(),
    };
  }
}
