import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/features/orders/pre_order/index.dart';
import 'package:hanaang_app/providers/orders/pre_order_provider.dart';
import 'package:hanaang_app/utilities/next_to.dart';

void handlePostPreOrder(
    BuildContext context, WidgetRef ref, int quantity) async {
  final preOrderState = ref.read(postPreOrderProvider(quantity));
  preOrderState.when(data: (data) {
    Next.to(context, PreOrder());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Pesanan berhasil",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.green,
    ));
  }, loading: () {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Memproses pesanan"),
    ));
  }, error: (e, _) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Terjadi kesalahan"),
    ));
  });
}
