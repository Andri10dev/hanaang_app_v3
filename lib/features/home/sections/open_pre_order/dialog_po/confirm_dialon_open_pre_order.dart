import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/features/home/sections/open_pre_order/dialog_po/handle_functions/handle_post_pre_order.dart';
import 'package:hanaang_app/features/home/sections/open_pre_order/dialog_po/widget/build_btn_open_pre_order.dart';
import 'package:hanaang_app/features/orders/pre_order/index.dart';
import 'package:hanaang_app/providers/orders/pre_order/pre_order_provider.dart';
import 'package:hanaang_app/utilities/custom_color.dart';
import 'package:hanaang_app/utilities/next_to.dart';

void showConfirmation(BuildContext context, WidgetRef ref, int quantity) {
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
            'Apakah Anda yakin ingin melakukan pemesanan ini?',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        BuildBtnOpenPreOrder(
          text: 'Batal',
          textColor: myColors.yellow,
          backgroundColor: Colors.white,
          borderColor: myColors.yellow,
          onPressed: () => Navigator.of(context).pop(),
        ),
        BuildBtnOpenPreOrder(
          text: 'Pesan',
          textColor: Colors.white,
          backgroundColor: myColors.yellow,
          onPressed: () {
            _handlePostPreOrder(context, ref, quantity);
          },
        ),
      ],
    ),
  );
}

void _handlePostPreOrder(
    BuildContext context, WidgetRef ref, int quantity) async {
  Navigator.of(context).pop();

  try {
    final preOrderState = await ref.read(postPreOrderProvider(quantity).future);

    // Jika berhasil sampai sini, berarti tidak ada error
    Next.to(context, PreOrder());

    // Gunakan Future.delayed untuk memastikan navigasi selesai sebelum menampilkan snackbar
    Future.delayed(const Duration(milliseconds: 100), () {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Pesanan berhasil",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
        ));
      }
    });
  } catch (e) {
    // print('Error creating pre-order: $e');
    String errorMessage = 'Terjadi kesalahan';
    if (e is Exception) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    } else {
      errorMessage = e.toString();
    }

    // Gunakan Future.delayed untuk memastikan dialog sudah tertutup sebelum menampilkan snackbar
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
