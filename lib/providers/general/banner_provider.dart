import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/models/banner_model.dart';
import 'package:hanaang_app/services/general/banner_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final BannerServiceProvider = Provider<BannerService>((ref) {
  return BannerService();
});

final getBanner = FutureProvider<List<BannerModel>>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token-hanaang_app') ?? "";

  final service = ref.watch(BannerServiceProvider);
  return service.getBanner(token);
});

final showBanner = FutureProvider.family<BannerModel, String>((ref, id) async {
  final service = ref.watch(BannerServiceProvider);
  return service.getBannerById(id);
});

final createBanner =
    FutureProvider.family<BannerModel, BannerModel>((ref, data) async {
  final service = ref.watch(BannerServiceProvider);
  return service.createBanner(data);
});
