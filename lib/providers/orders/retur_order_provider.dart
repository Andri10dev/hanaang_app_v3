import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/models/retur_body_model.dart';
import 'package:hanaang_app/models/retur_order_model.dart';
import 'package:hanaang_app/services/orders/retur_order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final returOrderServiceProvider = Provider<ReturOrderService>((ref) {
  return ReturOrderService();
});

final getReturOrderProvider =
    FutureProvider<List<ReturOrderModel>>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";

  final service = ref.watch(returOrderServiceProvider);
  return service.getReturOrder(token);
});

final showReturOrderProvider =
    FutureProvider.family<ReturOrderModel, String>((ref, poNumber) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";

  final service = ref.watch(returOrderServiceProvider);
  return service.showReturOrder(token, poNumber);
});

final postReturOrderProvider =
    FutureProvider.family<Map<String, dynamic>, ReturOrderBodyRequestModel>(
        (ref, body) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";

  final service = ref.watch(returOrderServiceProvider);
  return service.createReturOrder(token, body);
});
