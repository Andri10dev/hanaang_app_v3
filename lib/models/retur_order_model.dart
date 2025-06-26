import 'package:hanaang_app/models/order_model.dart';
import 'package:hanaang_app/models/user_model.dart';

class ReturOrderModel {
  final String id;
  final String returNumber;
  final int quantity;
  final String description;
  final List<ReturImageModel> images;
  final String status;
  final String takingStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel user;
  final UserModel? admin;
  final OrderModel order;

  ReturOrderModel(
      {required this.id,
      required this.returNumber,
      required this.quantity,
      required this.description,
      required this.images,
      required this.status,
      required this.takingStatus,
      required this.createdAt,
      required this.updatedAt,
      required this.user,
      required this.order,
      this.admin});

  factory ReturOrderModel.fromJson(Map<String, dynamic> json) {
    return ReturOrderModel(
      id: json['id'],
      returNumber: json['retur_number'],
      quantity: json['quantity'],
      description: json['description'],
      images: (json['images'] as List)
          .map((img) => ReturImageModel.fromJson(img))
          .toList(),
      status: json['status'],
      takingStatus: json['taking_status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: UserModel.fromJson(json['user']),
      admin: json["admin"] != null
          ? UserModel.fromJson(json['admin'])
          : null as UserModel?,
      order: OrderModel.fromJson(json['order']),
    );
  }
}

class ReturImageModel {
  final String id;
  final String returId;
  final String image;
  final String createdAt;
  final String updatedAt;

  ReturImageModel({
    required this.id,
    required this.returId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReturImageModel.fromJson(Map<String, dynamic> json) {
    return ReturImageModel(
      id: json['id'],
      returId: json['retur_id'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
