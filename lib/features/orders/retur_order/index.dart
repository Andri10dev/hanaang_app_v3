import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/features/orders/retur_order/card.dart';
import 'package:hanaang_app/providers/orders/pre_order/pre_order_provider.dart';
import 'package:hanaang_app/providers/orders/retur_order_provider.dart';

class ReturOrder extends ConsumerWidget {
  const ReturOrder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getData = ref.watch(getReturOrderProvider);
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: const CustomBgAppBar(),
          centerTitle: true,
          title: const TextH2(
            text: "Data Retur Pesanan",
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
                // Next.to(context, AgenScaner());
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
            ref.invalidate(getReturOrderProvider);
            await ref.read(getReturOrderProvider.future);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: getData.when(
                data: (data) => data.isEmpty
                    ? const SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: 400, // Tinggi minimum agar bisa di-scroll
                          child: Center(
                            child: Text("Tidak ada data retur pesanan"),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            ReturOrderCard(
                              data: data[index],
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                error: (err, stack) {
                  return SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: 400, // Tinggi minimum agar bisa di-scroll
                      child: Center(
                        child: Text(
                            "Silahkan periksa koneksi internet Anda..!" +
                                "${err}"),
                      ),
                    ),
                  );
                },
                loading: () => const SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: 400, // Tinggi minimum agar bisa di-scroll
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    )),
          ),
        ));
  }
}
