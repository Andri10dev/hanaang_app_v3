import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/models/open_pre_order_model.dart';
import 'package:hanaang_app/services/orders/open_pre_order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final OpenPreOrderServiceProvider = Provider<OpenPreOrderService>((ref) {
  return OpenPreOrderService();
});

final getOpenPreOrderProvider = FutureProvider<OpenPreOrderModel>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";

  final service = ref.watch(OpenPreOrderServiceProvider);
  return service.getOpenPreOrder(token);
});

final updateOpenPreOrderProvider =
    FutureProvider.family<OpenPreOrderModel, Map<String, dynamic>>(
        (ref, body) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";

  final service = ref.watch(OpenPreOrderServiceProvider);
  return service.updateOpenPreOrder(token, body);
});
