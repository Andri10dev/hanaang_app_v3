import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/h3.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/features/orders/order/detail/transaction/detail.dart';
import 'package:hanaang_app/providers/orders/order_transaction_provider.dart';
import 'package:hanaang_app/utilities/format_currency.dart';
import 'package:hanaang_app/utilities/next_to.dart';
import 'package:intl/intl.dart';

class OrderTransactionHistory extends ConsumerWidget {
  final orderNumber;
  const OrderTransactionHistory({super.key, required this.orderNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getData = ref.watch(getOrderTransactionProvider(orderNumber));
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: const CustomBgAppBar(),
          centerTitle: true,
          title: const TextH2(
            text: "Riwayat Transaksi",
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
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ]),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(getOrderTransactionProvider(orderNumber));
          await ref.read(getOrderTransactionProvider(orderNumber).future);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: getData.when(
            data: (data) => ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Next.to(context, OrderTransactionDetail(data: data[index]));
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 2,
                        spreadRadius: 0.1,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 5, left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                          ),
                          child: _buildInfoRow(
                              "Kode Transaksi", data[index].code)),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(children: [
                          _buildInfoRow("Tanggal",
                              "${DateFormat.EEEE('id_ID').format(data[index].createdAt)}, ${DateFormat("dd-MM-yyyy").format(data[index].createdAt)}"),
                          SizedBox(
                            height: 5,
                          ),
                          _buildInfoRow("Jumlah Pembayaran",
                              formatCurrency(data[index].nominal)),
                          _buildInfoRow("Jumlah Pengambilan",
                              "${data[index].totalTaken} Cup"),
                        ]),
                      ),
                      const Divider(),
                      Container(
                          padding: const EdgeInsets.only(
                              bottom: 10, top: 5, left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                          ),
                          child:
                              _buildInfoRow("Admin", data[index].admin.name)),
                    ],
                  ),
                ),
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('Error: $err')),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isSpaced = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment:
            isSpaced ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
        children: [
          TextNormal(text: label, fontWeight: FontWeight.bold),
          TextH3(
            text: value,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
