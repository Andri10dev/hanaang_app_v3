import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/models/finance/price_model.dart';
import 'package:hanaang_app/services/finance/price_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final PriceServiceProvider = Provider<PriceService>((ref) {
  return PriceService();
});

final getPrice = FutureProvider<List<PriceModel>>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";

  final service = ref.watch(PriceServiceProvider);
  return service.getPrice(token);
});
