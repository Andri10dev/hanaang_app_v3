import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/h3.dart';
import 'package:hanaang_app/features/orders/retur_order/detail/transaction/detail.dart';
import 'package:hanaang_app/providers/orders/retur_transaction_provider.dart';
import 'package:hanaang_app/utilities/next_to.dart';

class ReturTransaction extends ConsumerWidget {
  final returNumber;
  const ReturTransaction({super.key, required this.returNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getData = ref.watch(getReturTransactionProvider(returNumber));
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const CustomBgAppBar(),
        centerTitle: true,
        title: const TextH2(
          text: "Data Transaksi Retur",
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
          ref.invalidate(getReturTransactionProvider(returNumber));
          await ref.read(getReturTransactionProvider(returNumber).future);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ListView(
            children: [
              _buildRowV2("Jumlah retur", "20 Cup"),
              _buildRowV2("Sudah Diambil", "5 Cup"),
              Divider(),
              _buildRowV2("Belum Diambil", "15 Cup", bold: true),
              Divider(),
              SizedBox(
                height: 20,
              ),
              getData.when(
                data: (data) => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(10),
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
                        child: InkWell(
                          onTap: () {
                            Next.to(context,
                                ReturTransactionDetail(data: data[index]));
                          },
                          child: Column(
                            children: [
                              _buildRowV2("Kode Transaksi", data[index].code,
                                  bold: true),
                              _buildRowV2("Jumlah Pengambilan",
                                  "${data[index].quantity} Cup",
                                  bold: true),
                              Divider(),
                              _buildRowV2("Admin", data[index].admin.name,
                                  bold: true),
                            ],
                          ),
                        ),
                      );
                    }),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => SingleChildScrollView(
                    child: Center(child: Text('Error: $err'))),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowV2(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextH3(
            text: title,
            fontWeight: bold == true ? FontWeight.bold : FontWeight.w400,
          ),
          TextH3(
            text: value,
            fontWeight: bold == true ? FontWeight.bold : FontWeight.w400,
            textOverflow: TextOverflow.visible,
            maxLine: null,
          ),
        ],
      ),
    );
  }
}
