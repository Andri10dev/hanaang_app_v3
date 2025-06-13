import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/features/authenticate/login.dart';
import 'package:hanaang_app/utilities/custom_color.dart';
import 'package:hanaang_app/utilities/next_to.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<Map<String, dynamic>>>(
        (ref) {
  final authService = ref.read(authServiceProvider);
  return AuthNotifier(authService);
});

class AuthNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(const AsyncData({}));

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    try {
      final success = await _authService.login(email, password);
      state = AsyncData(success);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> handleLogout(BuildContext context) async {
    try {
      // Tampilkan dialog konfirmasi
      bool? confirmLogout = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi Logout'),
            content: Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: myColors.yellow,
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );

      if (confirmLogout == true) {
        // Hapus semua data SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();

        // Tampilkan pesan sukses
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logout berhasil'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigasi ke halaman login dan hapus semua route sebelumnya
        Next.toAndRemoveUntil(context, Login());
      }
    } catch (e) {
      // Tampilkan pesan error jika terjadi kesalahan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan saat logout'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
