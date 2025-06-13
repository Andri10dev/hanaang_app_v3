// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hanaang_app/services/orders/pre_order_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// final PreOrderServiceProvider = Provider<PreOrderService>((ref) {
//   return PreOrderService();
// });

// class PreOrderNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
//   final PreOrderService _preOrderService;

//   PreOrderNotifier(this._preOrderService) : super(const AsyncData({}));

//   Future<void> getPreOrder() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token-hanaang_app') ?? "";
//     state = const AsyncLoading();
//     try {
//       final success = await _preOrderService.getPreOrder(token);
//       state = AsyncData(success);
//     } catch (e) {
//       state = AsyncError(e, StackTrace.current);
//     }
//   }

//   Future<void> createPreOrder(int quantity) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token-hanaang_app') ?? "";
//     state = const AsyncLoading();
//     try {
//       final success = await _preOrderService.createPreOrder(token, quantity);
//       state = AsyncData(success);
//     } catch (e) {
//       state = AsyncError(e, StackTrace.current);
//     }
//   }
// }

// final PreOrderStateProvider =
//     StateNotifierProvider<PreOrderNotifier, AsyncValue<Map<String, dynamic>>>(
//         (ref) {
//   final service = ref.watch(PreOrderServiceProvider);
//   return PreOrderNotifier(service);
// });

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/models/pre_order_detail_model.dart';
import 'package:hanaang_app/models/pre_order_model.dart';
import 'package:hanaang_app/services/orders/pre_order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final preOrderServiceProvider = Provider<PreOrderService>((ref) {
  return PreOrderService();
});

final getPreOrderProvider =
    FutureProvider.family<List<PreOrderModel>, Map<String, dynamic>>(
        (ref, params) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";

  final service = ref.watch(preOrderServiceProvider);
  return service.getPreOrder(token, params);
});

final showPreOrderProvider =
    FutureProvider.family<PreOrderDetailModel, String>((ref, poNumber) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";

  final service = ref.watch(preOrderServiceProvider);
  return service.showPreOrder(token, poNumber);
});

final postPreOrderProvider =
    FutureProvider.family<PreOrderModel, int>((ref, quantity) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";

  final service = ref.watch(preOrderServiceProvider);
  return service.createPreOrder(token, quantity);
});
