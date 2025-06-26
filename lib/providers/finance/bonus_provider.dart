import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/models/finance/bonus_model.dart';
import 'package:hanaang_app/services/finance/bonus_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final BonusServiceProvider = Provider<BonusService>((ref) {
  return BonusService();
});

final getBonus = FutureProvider<List<BonusModel>>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";

  final service = ref.watch(BonusServiceProvider);
  return service.getBonus(token);
});
