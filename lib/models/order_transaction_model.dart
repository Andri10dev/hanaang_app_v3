import 'package:hanaang_app/models/user_model.dart';

class OrderTransactionModel {
  final String code;
  final String orderNumber;
  final String paymentMethod;
  final String? image;
  final int totalPayment;
  final int nominal;
  final int remainingPayment;
  final int notTakenYet;
  final int totalTaken;
  final int remainingTake;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel admin;

  OrderTransactionModel({
    required this.code,
    required this.orderNumber,
    required this.paymentMethod,
    this.image,
    required this.totalPayment,
    required this.nominal,
    required this.remainingPayment,
    required this.notTakenYet,
    required this.totalTaken,
    required this.remainingTake,
    required this.createdAt,
    required this.updatedAt,
    required this.admin,
  });

  factory OrderTransactionModel.fromJson(Map<String, dynamic> json) {
    return OrderTransactionModel(
      code: json['code'],
      orderNumber: json['order_number'],
      paymentMethod: json['payment_method'],
      image: json['image'],
      totalPayment: json['total_payment'],
      nominal: json['nominal'],
      remainingPayment: json['remaining_payment'],
      notTakenYet: json['not_taken_yet'],
      totalTaken: json['total_taken'],
      remainingTake: json['remaining_take'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      admin: UserModel.fromJson(json['admin']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'order_number': orderNumber,
      'payment_method': paymentMethod,
      'image': image,
      'total_payment': totalPayment,
      'nominal': nominal,
      'remaining_payment': remainingPayment,
      'not_taken_yet': notTakenYet,
      'total_taken': totalTaken,
      'remaining_take': remainingTake,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'admin': admin.toJson(),
    };
  }
}
