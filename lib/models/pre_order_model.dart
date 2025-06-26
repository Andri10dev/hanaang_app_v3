import 'package:hanaang_app/models/user_model.dart';

class PreOrderModel {
  final String id;
  final String groupPoId;
  final String poNumber;
  final int quantity;
  final int price;
  final int bonus;
  final int cashback;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel user;
  final UserModel? admin;

  PreOrderModel({
    required this.id,
    required this.groupPoId,
    required this.poNumber,
    required this.quantity,
    required this.price,
    required this.bonus,
    required this.cashback,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    this.admin,
  });

  factory PreOrderModel.fromJson(Map<String, dynamic> json) {
    return PreOrderModel(
      id: json['id'],
      groupPoId: json['group_po_id'],
      poNumber: json['po_number'],
      quantity: json['quantity'],
      price: json['price'],
      bonus: json['bonus'],
      cashback: json['cashback'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: UserModel.fromJson(json['user']),
      admin: json['admin'] != null ? UserModel.fromJson(json['admin']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_po_id': groupPoId,
      'po_number': poNumber,
      'quantity': quantity,
      'price': price,
      'bonus': bonus,
      'cashback': cashback,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'user': user.toJson(),
      'admin': admin?.toJson(),
    };
  }
}
