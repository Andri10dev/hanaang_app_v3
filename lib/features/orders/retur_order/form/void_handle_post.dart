import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/features/home/sections/open_pre_order/dialog_po/riverpod.dart';
import 'package:hanaang_app/models/retur_body_model.dart';
import 'package:hanaang_app/providers/orders/retur_order_provider.dart';
import 'package:hanaang_app/utilities/next_to.dart';

void handlePostReturOrder(BuildContext context, WidgetRef ref,
    ReturOrderBodyRequestModel body) async {
  ref.read(isLoadingProvider.notifier).state = true;
  try {
    final response = await ref.read(postReturOrderProvider(body).future);

    print("=================Ini Adalah Response=================");
    print(response);
    if (response["status"] == "success") {
      ref.read(isLoadingProvider.notifier).state = false;
      ref.invalidate(getReturOrderProvider);
      ref.invalidate(showReturOrderProvider);
      Next.back(context);

      Future.delayed(const Duration(milliseconds: 100), () {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Pengajuan retur berhasil dibuat..!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.green,
          ));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Retur gagal dibuat..!",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
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

    print("=================Ini Adalah Error=================");
    print(e);

    Future.delayed(const Duration(milliseconds: 200), () {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Hahahaaaaaa ${errorMessage}"),
          backgroundColor: Colors.red,
        ));
      }
    });
  }
}
