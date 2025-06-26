import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/features/home/sections/open_pre_order/dialog_po/riverpod.dart';
import 'package:hanaang_app/providers/orders/open_po_provider.dart';
import 'package:hanaang_app/providers/orders/pre_order/pre_order_provider.dart';
import 'package:hanaang_app/utilities/next_to.dart';

void handleCancelPreOrder(
    BuildContext context, WidgetRef ref, String poNumber) async {
  // Set loading state
  ref.read(isLoadingProvider.notifier).state = true;

  try {
    final response = await ref.read(cancelPreOrderProvider(poNumber).future);

    Next.back(context);
    if (response['status'] == "success") {
      ref.read(isLoadingProvider.notifier).state = false;

      ref.invalidate(getPreOrderProvider);
      ref.invalidate(getOpenPreOrderProvider);

      Next.back(context);

      Future.delayed(const Duration(milliseconds: 100), () {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              response["message_v2"] ?? "Pre Order berhasil dibatalkan..!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.green,
          ));
        }
      });
    } else {
      ref.read(isLoadingProvider.notifier).state = false;
      Future.delayed(const Duration(milliseconds: 100), () {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              response["message_v2"] ?? "Pre Order gagal dibatalkan..!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.green,
          ));
        }
      });
    }
  } catch (e) {
    // Reset loading state
    ref.read(isLoadingProvider.notifier).state = false;

    String errorMessage = 'Terjadi kesalahan';
    if (e is Exception) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    } else {
      errorMessage = e.toString();
    }

    Future.delayed(const Duration(milliseconds: 200), () {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ));
      }
    });
  }
}
