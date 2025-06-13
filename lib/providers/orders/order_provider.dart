import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/models/order_model.dart';
import 'package:hanaang_app/services/orders/order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final preOrderServiceProvider = Provider<OrderService>((ref) {
  return OrderService();
});

final getOrderProvider = FutureProvider<List<OrderModel>>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";

  final service = ref.watch(preOrderServiceProvider);
  return service.getOrder(token);
});
