import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/models/retur_transaction_model.dart';
import 'package:hanaang_app/services/orders/retur_transaction_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final returTransactionServiceProvider =
    Provider<ReturTransactionService>((ref) {
  return ReturTransactionService();
});

final getReturTransactionProvider =
    FutureProvider.family<List<ReturTransactionModel>, String>(
        (ref, returNumber) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";
  final service = ref.watch(returTransactionServiceProvider);
  return service.getReturTransaction(token, returNumber);
});

final postReturTransactionProvider =
    FutureProvider.family<ReturTransactionModel, int>((ref, quantity) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";
  final service = ref.watch(returTransactionServiceProvider);
  return service.createReturTransaction(token, quantity);
});
