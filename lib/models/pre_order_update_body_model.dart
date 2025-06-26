class PreOrderUpdateBody {
  final String poNumber;
  final int quantity;

  const PreOrderUpdateBody({
    required this.poNumber,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {'po_number': poNumber, 'quantity': quantity};
  }
}
