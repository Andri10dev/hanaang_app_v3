import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/features/home/dialog_po/handle_functions/handle_post_pre_order.dart';
import 'package:hanaang_app/features/home/dialog_po/widget/build_btn_open_pre_order.dart';
import 'package:hanaang_app/utilities/custom_color.dart';

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
            handlePostPreOrder(context, ref, quantity);
          },
        ),
      ],
    ),
  );
}
