import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/h3.dart';
import 'package:hanaang_app/features/orders/retur_order/detail/transaction/print.dart';
import 'package:hanaang_app/models/retur_transaction_model.dart';
import 'package:hanaang_app/utilities/next_to.dart';
import 'package:intl/intl.dart';

class ReturTransactionDetail extends ConsumerWidget {
  final ReturTransactionModel data;
  const ReturTransactionDetail({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const CustomBgAppBar(),
        centerTitle: true,
        title: const TextH2(
          text: "Detail Transaksi Retur",
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
              Icons.print,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Next.to(
                  context,
                  PrintReturTransaction(
                    data: data,
                  ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  _buildRow("Tanggal",
                      "${DateFormat.EEEE('id_ID').format(data.createdAt)}, ${DateFormat("dd-MM-yyyy").format(data.createdAt)}"),
                  _buildRow("Jam",
                      "${DateFormat("HH:mm").format(data.createdAt)} WIB"),
                  SizedBox(
                    height: 15,
                  ),
                  _buildRow("No Retur", data.returOrder.returNumber),
                  _buildRow("Kode Transaksi", data.code),
                  _buildRow("Admin", data.admin.name),
                  SizedBox(
                    height: 15,
                  ),
                  _buildRow("Belum Diambil", "${data.notTakenYet} Cup"),
                  _buildRow("Jumlah Pengambilan", "${data.quantity} Cup"),
                  const Divider(),
                  _buildRow("Sisa Pengambilan", "${data.remainingTake} Cup",
                      bold: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value, {bool bold = false}) {
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
