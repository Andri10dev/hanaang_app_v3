import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/customs/btn_default.dart';
import 'package:hanaang_app/features/account/logout_state/void_logout.dart';
import 'package:hanaang_app/features/home/sections/open_pre_order/dialog_po/riverpod.dart';

void showLogoutConfirmation(BuildContext context, WidgetRef ref) {
  final isLoading = ref.watch(isLoadingProvider);
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Center(
          child: Text('Konfirmasi Pesanan',
              style: TextStyle(fontWeight: FontWeight.bold))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/icons/ic_danger.png', height: 100),
          const SizedBox(height: 16),
          const Text(
            'Apakah Anda yakin akan membatalkan pre order ini?',
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                  child: BtnDefault(
                      name: "Kembali",
                      onTap: () => Navigator.of(context).pop())),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: BtnDefault(
                    name: isLoading ? "Loading.." : "Logout",
                    color: Colors.red,
                    onTap: () {
                      handleLogout(context, ref);
                    }),
              ),
            ],
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
    ),
  );
}
