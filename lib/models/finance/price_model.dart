class PriceModel {
  final String id;
  final int minimumOrder;
  final int nominal;
  final RoleModel role;
  final DateTime createdAt;
  final DateTime updatedAt;

  PriceModel({
    required this.id,
    required this.minimumOrder,
    required this.nominal,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      id: json['id'],
      minimumOrder: json['minimum_order'],
      nominal: json['nominal'],
      role: RoleModel.fromJson(json['role']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'minimum_order': minimumOrder,
      'nominal': nominal,
      'role': role.toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class RoleModel {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  RoleModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
