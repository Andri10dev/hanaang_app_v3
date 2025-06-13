class PreOrderModel {
  final String id;
  final String poNumber;
  final int quantity;
  final int price;
  final int bonus;
  final int cashback;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  PreOrderModel({
    required this.id,
    required this.poNumber,
    required this.quantity,
    required this.price,
    required this.bonus,
    required this.cashback,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PreOrderModel.fromJson(Map<String, dynamic> json) {
    return PreOrderModel(
      id: json['id'],
      poNumber: json['po_number'],
      quantity: json['quantity'],
      price: json['price'],
      bonus: json['bonus'],
      cashback: json['cashback'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
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
    };
  }
}
