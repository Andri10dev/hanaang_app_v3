import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/models/order_transaction_model.dart';
import 'package:hanaang_app/services/orders/order_transaction_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final OrderTransactionServiceProvider =
    Provider<OrderTransactionService>((ref) {
  return OrderTransactionService();
});

final getOrderTransactionProvider =
    FutureProvider.family<List<OrderTransactionModel>, String>(
        (ref, orderNumber) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";

  final service = ref.watch(OrderTransactionServiceProvider);
  return service.getOrderTransaction(token, orderNumber);
});
