import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // akan diisi nanti di main()
});

final getUniqueIdProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString('unique_id-hanaang_app') ?? '';
});

final getEmailProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString('email-hanaang_app') ?? '';
});

final getNameProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString('name-hanaang_app') ?? '';
});

final getImageProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString('image-hanaang_app') ?? '';
});

final getTokenProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString('token-hanaang_app') ?? '';
});

final getPhoneNumberProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString('phone_number-hanaang_app') ?? '';
});

final getUserRoleProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString('user_role-hanaang_app') ?? '';
});
