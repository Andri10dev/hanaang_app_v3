import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/features/home/dialog_po/confirm_dialon_open_pre_order.dart';
import 'package:hanaang_app/features/home/dialog_po/riverpod.dart';
import 'package:hanaang_app/features/home/dialog_po/widget/build_btn_open_pre_order.dart';
import 'package:hanaang_app/features/home/dialog_po/widget/build_row_open_pre_order.dart';
import 'package:hanaang_app/utilities/custom_color.dart';

void showPreOrderDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (_) => Consumer(
      builder: (context, ref, child) {
        final orderCount = ref.watch(orderCountProvider);
        final bonus = getBonus(orderCount);
        final cashback = getCashback(orderCount);
        final totalPrice = getTotalPrice(orderCount);

        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: myColors.yellow,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Center(
                  child: Text(
                    'Pre Order',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),

              // Rincian Pesanan
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Rincian Pesanan :',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const Divider(),

                    BuildRowOpenPreOrder('Jumlah Pesanan',
                        '${orderCount.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')} Cup'),

                    BuildRowOpenPreOrder('Harga Satuan', 'Rp. 5.000'),
                    BuildRowOpenPreOrder('Bonus', '$bonus Cup'),
                    BuildRowOpenPreOrder('Cashback',
                        'Rp. ${cashback.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}'),
                    const Divider(),
                    BuildRowOpenPreOrder('Total Harga',
                        'Rp. ${totalPrice.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}',
                        isBold: true),

                    const SizedBox(height: 16),

                    // Button +/-
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, color: Colors.white),
                          style:
                              IconButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: () {
                            if (orderCount > 100) {
                              ref
                                  .read(orderCountProvider.notifier)
                                  .update((state) => state - 100);
                            }
                          },
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8)),
                            child: TextH2(
                              text: '$orderCount',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () {
                            ref
                                .read(orderCountProvider.notifier)
                                .update((state) => state + 100);
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Tombol Aksi
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BuildBtnOpenPreOrder(
                          text: 'Kembali',
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
                            showConfirmation(context, ref, orderCount);
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Catatan
                    const Text(
                      'Bonus dan cashback hanya dapat diklaim jika\npembayaran lunas pada transaksi pertama.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: myColors.yellow,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(20)),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Center(
                  child: Text(
                    'Hanaang App',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
