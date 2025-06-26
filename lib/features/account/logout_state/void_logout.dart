import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/features/authenticate/login.dart';
import 'package:hanaang_app/features/home/sections/open_pre_order/dialog_po/riverpod.dart';
import 'package:hanaang_app/providers/auths/local_storage_provider.dart';
import 'package:hanaang_app/utilities/next_to.dart';

void handleLogout(BuildContext context, WidgetRef ref) async {
  // try {
  //   ref.read(isLoadingProvider.notifier).state = true;
  //   final response = await ref.read(logoutProvider.future);

  // if (response["status"] == "success") {
  ref.read(isLoadingProvider.notifier).state = false;
  final prefs = ref.watch(sharedPreferencesProvider);
  await prefs.remove('unique_id-hanaang_app');
  await prefs.remove('image-hanaang_app');
  await prefs.remove('name-hanaang_app');
  await prefs.remove('email-hanaang_app');
  await prefs.remove('phone_number-hanaang_app');
  await prefs.remove('user_role-hanaang_app');
  await prefs.remove('token-hanaang_app');

  Next.to(context, Login());
  Future.delayed(const Duration(milliseconds: 200), () {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Logout Berhasil..!"),
        backgroundColor: Colors.green,
      ));
    }
  });
  // }
  // } catch (e) {
  //   Next.back(context);
  //   Future.delayed(const Duration(milliseconds: 200), () {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text("Logout gagal"),
  //         backgroundColor: Colors.red,
  //       ));
  //     }
  //   });
  // }
  // ref.read(isLoadingProvider.notifier).state = false;
}
