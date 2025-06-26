import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/features/home/sections/open_pre_order/dialog_po/riverpod.dart';
import 'package:hanaang_app/models/pre_order_update_body_model.dart';
import 'package:hanaang_app/providers/orders/pre_order/pre_order_provider.dart';
import 'package:hanaang_app/utilities/next_to.dart';

void handlePostPreOrder(
    BuildContext context, WidgetRef ref, PreOrderUpdateBody body) async {
  ref.read(isLoadingProvider.notifier).state = true;
  try {
    final response = await ref.read(updatePreOrderProvider(body).future);
    if (response["status"] == "success") {
      ref.read(isLoadingProvider.notifier).state = false;
      ref.invalidate(getPreOrderProvider);
      ref.invalidate(showPreOrderProvider);
      Next.back(context);

      Future.delayed(const Duration(milliseconds: 100), () {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Pre Order berhasil diupdate..!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.green,
          ));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Pre Order gagal diupdate..!",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ));
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
