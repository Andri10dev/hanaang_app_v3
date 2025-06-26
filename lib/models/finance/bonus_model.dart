class BonusModel {
  final String id;
  final int minimumOrder;
  final int numberOfBonus;
  final RoleModel role;
  final DateTime createdAt;
  final DateTime updatedAt;

  BonusModel({
    required this.id,
    required this.minimumOrder,
    required this.numberOfBonus,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BonusModel.fromJson(Map<String, dynamic> json) {
    return BonusModel(
      id: json['id'],
      minimumOrder: json['minimum_order'],
      numberOfBonus: json['number_of_bonus'],
      role: RoleModel.fromJson(json['role']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'minimum_order': minimumOrder,
      'number_of_bonus': numberOfBonus,
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
