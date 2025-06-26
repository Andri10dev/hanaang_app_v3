import 'package:hanaang_app/models/retur_order_model.dart';
import 'package:hanaang_app/models/user_model.dart';

class ReturTransactionModel {
  final String id;
  final String code;
  final int notTakenYet;
  final int quantity;
  final int remainingTake;
  final UserModel admin;
  final ReturOrderModel returOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReturTransactionModel({
    required this.id,
    required this.code,
    required this.notTakenYet,
    required this.quantity,
    required this.remainingTake,
    required this.admin,
    required this.returOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReturTransactionModel.fromJson(Map<String, dynamic> json) {
    return ReturTransactionModel(
      id: json['id'],
      code: json['code'],
      notTakenYet: json['not_taken_yet'],
      quantity: json['quantity'],
      remainingTake: json['remaining_take'],
      admin: UserModel.fromJson(json['admin']),
      returOrder: ReturOrderModel.fromJson(json['retur_order']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
