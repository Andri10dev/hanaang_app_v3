import 'dart:io';

class ReturOrderBodyRequestModel {
  final String orderNumber;
  final int quantity;
  final String description;
  final List<File> images;

  ReturOrderBodyRequestModel({
    required this.orderNumber,
    required this.quantity,
    required this.description,
    required this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'order_number': orderNumber,
      'quantity': quantity,
      'description': description,
      // images tidak bisa langsung dimasukkan di sini untuk multipart request
    };
  }
}
