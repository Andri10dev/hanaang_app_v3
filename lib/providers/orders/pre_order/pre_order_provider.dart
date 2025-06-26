import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/models/pre_order_detail_model.dart';
import 'package:hanaang_app/models/pre_order_model.dart';
import 'package:hanaang_app/models/pre_order_param_model.dart';
import 'package:hanaang_app/models/pre_order_update_body_model.dart';
import 'package:hanaang_app/services/orders/pre_order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final preOrderServiceProvider = Provider<PreOrderService>((ref) {
  return PreOrderService();
});

final getPreOrderProvider =
    FutureProvider.family<List<PreOrderModel>, PreOrderParams?>(
        (ref, params) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";

  final service = ref.watch(preOrderServiceProvider);
  return service.getPreOrder(token, params?.toMap());
});

final showPreOrderProvider =
    FutureProvider.family<PreOrderModel, String>((ref, poNumber) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";

  final service = ref.watch(preOrderServiceProvider);
  return service.showPreOrder(token, poNumber);
});

final postPreOrderProvider =
    FutureProvider.family<Map<String, dynamic>, int>((ref, quantity) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";

  final service = ref.watch(preOrderServiceProvider);
  return service.createPreOrder(token, quantity);
});

final cancelPreOrderProvider =
    FutureProvider.family<Map<String, dynamic>, String>((ref, poNumber) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";

  final service = ref.watch(preOrderServiceProvider);
  return service.cancelPreOrder(token, poNumber);
});

final updatePreOrderProvider =
    FutureProvider.family<Map<String, dynamic>, PreOrderUpdateBody>(
        (ref, body) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";

  final service = ref.watch(preOrderServiceProvider);
  return service.updatePreOrder(token, body);
});
