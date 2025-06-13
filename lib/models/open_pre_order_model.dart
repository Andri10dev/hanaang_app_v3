class OpenPreOrderModel {
  final DateTime startDate;
  final DateTime endDate;
  final int quantity;
  final int ordered;

  OpenPreOrderModel({
    required this.startDate,
    required this.endDate,
    required this.quantity,
    required this.ordered,
  });

  factory OpenPreOrderModel.fromJson(Map<String, dynamic> json) {
    return OpenPreOrderModel(
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      quantity: json['quantity'],
      ordered: json['ordered'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'quantity': quantity,
      'ordered': ordered,
    };
  }
}
