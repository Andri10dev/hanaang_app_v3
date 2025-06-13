import 'package:hanaang_app/models/user_model.dart';

class OrderModel {
  final String orderNumber;
  final String paymentStatus;
  final String orderTakingStatus;
  final int quantity;
  final int price;
  final int bonus;
  final int cashback;
  final int total;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel admin;
  final UserModel user;

  OrderModel({
    required this.orderNumber,
    required this.paymentStatus,
    required this.orderTakingStatus,
    required this.quantity,
    required this.price,
    required this.bonus,
    required this.cashback,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.admin,
    required this.user,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderNumber: json['order_number'],
      paymentStatus: json['payment_status'],
      orderTakingStatus: json['order_taking_status'],
      quantity: json['quantity'],
      price: json['price'],
      bonus: json['bonus'],
      cashback: json['cashback'],
      total: json['total'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      admin: UserModel.fromJson(json['admin']),
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_number': orderNumber,
      'payment_status': paymentStatus,
      'order_taking_status': orderTakingStatus,
      'quantity': quantity,
      'price': price,
      'bonus': bonus,
      'cashback': cashback,
      'total': total,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'admin': admin.toJson(),
      'user': user.toJson(),
    };
  }
}
