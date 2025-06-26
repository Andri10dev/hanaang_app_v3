import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/models/finance/cashback_model.dart';
import 'package:hanaang_app/services/finance/cashback_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final CashbackServiceProvider = Provider<CashbackService>((ref) {
  return CashbackService();
});

final getCashback = FutureProvider<List<CashbackModel>>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";

  final service = ref.watch(CashbackServiceProvider);
  return service.getCashback(token);
});
