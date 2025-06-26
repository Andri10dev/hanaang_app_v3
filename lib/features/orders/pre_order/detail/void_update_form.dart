import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/customs/loading_indicator.dart';
import 'package:hanaang_app/features/home/sections/open_pre_order/dialog_po/riverpod.dart';
import 'package:hanaang_app/features/home/sections/open_pre_order/dialog_po/widget/build_btn_open_pre_order.dart';
import 'package:hanaang_app/features/home/sections/open_pre_order/dialog_po/widget/build_row_open_pre_order.dart';
import 'package:hanaang_app/features/orders/pre_order/detail/void_handle_update.dart';
import 'package:hanaang_app/models/finance/price_model.dart';
import 'package:hanaang_app/models/finance/bonus_model.dart';
import 'package:hanaang_app/models/finance/cashback_model.dart';
import 'package:hanaang_app/models/pre_order_model.dart';
import 'package:hanaang_app/models/pre_order_update_body_model.dart';
import 'package:hanaang_app/providers/finance/price_provider.dart';
import 'package:hanaang_app/providers/finance/bonus_provider.dart';
import 'package:hanaang_app/providers/finance/cashback_provider.dart';
import 'package:hanaang_app/utilities/custom_color.dart';

void showPreOrderUpdateDialog(
    BuildContext context, WidgetRef ref, PreOrderModel data) {
  int getPriceByOrderCount(List<PriceModel> prices, int quantity) {
    prices.sort((a, b) => a.minimumOrder.compareTo(b.minimumOrder));

    PriceModel? selectedPrice;
    for (PriceModel price in prices) {
      if (quantity >= price.minimumOrder) {
        selectedPrice = price;
      } else {
        break;
      }
    }

    return selectedPrice?.nominal ?? 5000;
  }

  int getBonusByOrderCount(List<BonusModel> bonuses, int quantity) {
    if (bonuses.isEmpty) return 0;
    bonuses.sort((a, b) => a.minimumOrder.compareTo(b.minimumOrder));

    BonusModel? selectedBonus;
    for (BonusModel bonus in bonuses) {
      if (quantity >= bonus.minimumOrder) {
        selectedBonus = bonus;
      } else {
        break;
      }
    }
    return selectedBonus?.numberOfBonus ?? 0;
  }

  int getCashbackByOrderCount(List<CashbackModel> cashbacks, int quantity) {
    if (cashbacks.isEmpty) return 0;
    cashbacks.sort((a, b) => a.minimumOrder.compareTo(b.minimumOrder));

    CashbackModel? selectedCashback;
    for (CashbackModel cashback in cashbacks) {
      if (quantity >= cashback.minimumOrder) {
        selectedCashback = cashback;
      } else {
        break;
      }
    }

    return selectedCashback?.nominal ?? 0;
  }

  showDialog(
    context: context,
    builder: (_) => Consumer(
      builder: (context, ref, child) {
        final quantity = ref.watch(orderCountProvider);
        final getDataPrice = ref.watch(getPrice);
        final getDataBonus = ref.watch(getBonus);
        final getDataCashback = ref.watch(getCashback);
        final isLoading = ref.watch(isLoadingProvider);

        // Default values
        int currentPrice = 5000;
        int currentBonus = 0;
        int currentCashback = 0;

        // Handle price data
        getDataPrice.when(
          data: (data) {
            if (data.isNotEmpty) {
              currentPrice = getPriceByOrderCount(data, quantity);
            }
          },
          loading: () {
            // Keep default price
          },
          error: (err, _) {
            // Keep default price
          },
        );

        // Handle bonus data
        getDataBonus.when(
          data: (data) {
            if (data.isNotEmpty) {
              currentBonus = getBonusByOrderCount(data, quantity);
            }
          },
          loading: () {
            // Keep default bonus
          },
          error: (err, _) {
            // Keep default bonus
          },
        );

        // Handle cashback data
        getDataCashback.when(
          data: (data) {
            if (data.isNotEmpty) {
              currentCashback = getCashbackByOrderCount(data, quantity);
            }
          },
          loading: () {
            // Keep default cashback
          },
          error: (err, _) {
            // Keep default cashback
          },
        );

        final totalPrice = quantity * currentPrice;

        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: myColors.yellow,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    'Update Pre Order ${data.poNumber}',
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
                        '${quantity.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')} Cup'),

                    BuildRowOpenPreOrder('Harga Satuan',
                        'Rp. ${currentPrice.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}'),
                    BuildRowOpenPreOrder('Bonus', '$currentBonus Cup'),
                    BuildRowOpenPreOrder('Cashback',
                        'Rp. ${currentCashback.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}'),
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
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (quantity > 100) {
                                    ref
                                        .read(orderCountProvider.notifier)
                                        .update((state) => state - 100);
                                  }
                                },
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8)),
                            child: TextH2(
                              text: '$quantity',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: isLoading
                              ? null
                              : () {
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
                          onPressed: isLoading
                              ? null
                              : () => Navigator.of(context).pop(),
                        ),
                        BuildBtnOpenPreOrder(
                          text: isLoading ? '' : 'Pesan',
                          textColor: Colors.white,
                          backgroundColor: myColors.yellow,
                          onPressed: isLoading
                              ? null
                              : () {
                                  final body = PreOrderUpdateBody(
                                    poNumber: data.poNumber,
                                    quantity: quantity,
                                  );
                                  handlePostPreOrder(context, ref, body);
                                },
                          child: isLoading
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CustomLoadingIndicator(
                                      color: Colors.white),
                                )
                              : null,
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
                decoration: const BoxDecoration(
                  color: myColors.yellow,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20)),
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
