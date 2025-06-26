import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/features/orders/order/card.dart';
import 'package:hanaang_app/features/orders/order/scan.dart';
import 'package:hanaang_app/providers/orders/order_provider.dart';
import 'package:hanaang_app/utilities/next_to.dart';

class Order extends ConsumerWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getData = ref.watch(getOrderProvider);
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: const CustomBgAppBar(),
          centerTitle: true,
          title: const TextH2(
            text: "Data Pesanan",
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
              ),
              onPressed: () {
                Next.to(context, const OrderScaner());
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                // Tambahkan aksi ketika tombol ditekan
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(getOrderProvider);
            await ref.read(getOrderProvider.future);
          },
          child: getData.when(
              data: (data) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) => Column(
                              children: [
                                OrderCard(
                                  data: data[index],
                                ),
                                const SizedBox(
                                  height: 15,
                                )
                              ],
                            )),
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => SingleChildScrollView(
                  child: Center(
                      child:
                          Text('Silahkan Periksa koneksi internet Anda..!')))),
        ));
  }
}
