import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/navigations/bottom_navigation.dart';
import 'package:hanaang_app/features/authenticate/login.dart';
import 'package:hanaang_app/utilities/next_to.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(splashProvider, (previous, next) {
      if (next) {
        try {
          // Navigasi berdasarkan token
          final token = ref.read(splashProvider.notifier).token;
          if (token != null && token.isNotEmpty) {
            Next.to(context, BottomNavBar());
          } else {
            Next.to(context, Login());
          }
        } catch (e, stackTrace) {
          print('Stack trace: $stackTrace');
          try {
            Next.to(context, Login());
          } catch (fallbackError) {
            print('Error fallback: $fallbackError');
          }
        }
      }
    });

    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splash.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

final splashProvider = StateNotifierProvider<SplashNotifier, bool>((ref) {
  return SplashNotifier();
});

class SplashNotifier extends StateNotifier<bool> {
  String? token;

  SplashNotifier() : super(false) {
    _init();
  }

  void _init() async {
    await Future.delayed(const Duration(seconds: 3));
    await TokenCheck();
    state = true;
  }

  Future<void> TokenCheck() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      token = prefs.getString('token-hanaang_app');
      if (token != null && token!.isNotEmpty) {
        // print('Token ditemukan, akan navigasi ke home');
      } else {
        // print('Token tidak ditemukan, akan navigasi ke login');
      }
    } catch (e, stackTrace) {
      print('Stack trace: $stackTrace');
      token = null;
    }
  }
}
