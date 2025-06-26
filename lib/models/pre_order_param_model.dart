class PreOrderParams {
  final String buyer;
  final int page;
  final String? keyword;
  final String? status;

  const PreOrderParams({
    required this.buyer,
    required this.page,
    this.keyword,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'buyer': buyer,
      'page': page,
      if (keyword != null && keyword!.isNotEmpty) 'keyword': keyword,
      if (status != null && status!.isNotEmpty) 'status': status,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreOrderParams &&
          runtimeType == other.runtimeType &&
          buyer == other.buyer &&
          page == other.page &&
          keyword == other.keyword &&
          status == other.status;

  @override
  int get hashCode =>
      buyer.hashCode ^ page.hashCode ^ keyword.hashCode ^ status.hashCode;
}
