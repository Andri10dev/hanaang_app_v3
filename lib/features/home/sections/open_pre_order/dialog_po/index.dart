import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/customs/loading_indicator.dart';
import 'package:hanaang_app/features/home/sections/open_pre_order/dialog_po/riverpod.dart';
import 'package:hanaang_app/features/home/sections/open_pre_order/dialog_po/widget/build_btn_open_pre_order.dart';
import 'package:hanaang_app/features/home/sections/open_pre_order/dialog_po/widget/build_row_open_pre_order.dart';
import 'package:hanaang_app/features/orders/pre_order/index.dart';
import 'package:hanaang_app/models/finance/price_model.dart';
import 'package:hanaang_app/models/finance/bonus_model.dart';
import 'package:hanaang_app/models/finance/cashback_model.dart';
import 'package:hanaang_app/providers/finance/price_provider.dart';
import 'package:hanaang_app/providers/finance/bonus_provider.dart';
import 'package:hanaang_app/providers/finance/cashback_provider.dart';
import 'package:hanaang_app/providers/orders/pre_order/nav_pre_order_provider.dart';
import 'package:hanaang_app/providers/orders/pre_order/pre_order_provider.dart';
import 'package:hanaang_app/utilities/custom_color.dart';
import 'package:hanaang_app/utilities/next_to.dart';

void showPreOrderDialog(BuildContext context, WidgetRef ref) {
  // Fungsi untuk mendapatkan harga berdasarkan jumlah pesanan
  int getPriceByOrderCount(List<PriceModel> prices, int orderCount) {
    // Urutkan berdasarkan minimum_order dari terkecil ke terbesar
    prices.sort((a, b) => a.minimumOrder.compareTo(b.minimumOrder));

    // Cari harga yang sesuai dengan minimum_order
    PriceModel? selectedPrice;
    for (PriceModel price in prices) {
      if (orderCount >= price.minimumOrder) {
        selectedPrice = price;
      } else {
        break; // Berhenti jika minimum_order sudah melebihi orderCount
      }
    }

    // Jika tidak ada yang cocok, gunakan harga pertama atau default 5000
    return selectedPrice?.nominal ?? 5000;
  }

  // Fungsi untuk mendapatkan bonus berdasarkan jumlah pesanan
  int getBonusByOrderCount(List<BonusModel> bonuses, int orderCount) {
    if (bonuses.isEmpty) return 0;

    // Urutkan berdasarkan minimum_order dari terkecil ke terbesar
    bonuses.sort((a, b) => a.minimumOrder.compareTo(b.minimumOrder));

    // Cari bonus yang sesuai dengan minimum_order
    BonusModel? selectedBonus;
    for (BonusModel bonus in bonuses) {
      if (orderCount >= bonus.minimumOrder) {
        selectedBonus = bonus;
      } else {
        break; // Berhenti jika minimum_order sudah melebihi orderCount
      }
    }
    // Jika tidak ada yang cocok, gunakan default 0
    return selectedBonus?.numberOfBonus ?? 0;
  }

  // Fungsi untuk mendapatkan cashback berdasarkan jumlah pesanan
  int getCashbackByOrderCount(List<CashbackModel> cashbacks, int orderCount) {
    if (cashbacks.isEmpty) return 0;

    // Urutkan berdasarkan minimum_order dari terkecil ke terbesar
    cashbacks.sort((a, b) => a.minimumOrder.compareTo(b.minimumOrder));

    // Cari cashback yang sesuai dengan minimum_order
    CashbackModel? selectedCashback;
    for (CashbackModel cashback in cashbacks) {
      if (orderCount >= cashback.minimumOrder) {
        selectedCashback = cashback;
      } else {
        break; // Berhenti jika minimum_order sudah melebihi orderCount
      }
    }

    // Jika tidak ada yang cocok, gunakan default 0
    return selectedCashback?.nominal ?? 0;
  }

  showDialog(
    context: context,
    builder: (_) => Consumer(
      builder: (context, ref, child) {
        final orderCount = ref.watch(orderCountProvider);
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
            if (data != null && data.isNotEmpty) {
              currentPrice = getPriceByOrderCount(data, orderCount);
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
            if (data != null && data.isNotEmpty) {
              currentBonus = getBonusByOrderCount(data, orderCount);
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
            if (data != null && data.isNotEmpty) {
              currentCashback = getCashbackByOrderCount(data, orderCount);
            }
          },
          loading: () {
            // Keep default cashback
          },
          error: (err, _) {
            // Keep default cashback
          },
        );

        final totalPrice = orderCount * currentPrice;

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
                            padding: const EdgeInsets.symmetric(vertical: 5),
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
                                  _handlePostPreOrder(context, ref, orderCount);
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

void _handlePostPreOrder(
    BuildContext context, WidgetRef ref, int quantity) async {
  // Set loading state
  ref.read(isLoadingProvider.notifier).state = true;

  try {
    final preOrderState = await ref.read(postPreOrderProvider(quantity).future);

    // Reset loading state
    ref.read(isLoadingProvider.notifier).state = false;
    ref.read(navPreOrderProvider.notifier).setIndex(0);
    ref.read(statusPoProvider.notifier).state = 'semua';
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
