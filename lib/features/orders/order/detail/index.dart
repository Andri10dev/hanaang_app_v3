import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/customs/btn_default.dart';
import 'package:hanaang_app/components/texts/h1.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/h3.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/features/orders/order/detail/show_qr_code.dart';
import 'package:hanaang_app/features/orders/order/detail/transaction/index.dart';
import 'package:hanaang_app/features/orders/retur_order/form/index.dart';
import 'package:hanaang_app/models/order_model.dart';
import 'package:hanaang_app/models/user_model.dart';
import 'package:hanaang_app/providers/orders/order_provider.dart';
import 'package:hanaang_app/utilities/custom_color.dart';
import 'package:hanaang_app/utilities/format_currency.dart';
import 'package:hanaang_app/utilities/next_to.dart';
import 'package:intl/intl.dart';

class OrderDetail extends ConsumerWidget {
  final String orderNumber;
  const OrderDetail({super.key, required this.orderNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getData = ref.watch(showOrderProvider(orderNumber));
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: const CustomBgAppBar(),
          centerTitle: true,
          title: const TextH2(
            text: "Detail Pesanan",
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
                getData.when(
                  data: (data) =>
                      ShowQRCodeOrder(context, orderNumber, data.user),
                  loading: () => null,
                  error: (err, _) => null,
                );
              },
            ),
          ]),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(showOrderProvider(orderNumber));
          await ref.read(showOrderProvider(orderNumber).future);
        },
        child: getData.when(
          data: (data) => ListView(
            children: [
              _InfoCard(
                title: "No Pre Order : ${data.orderNumber}",
                child: _OrderInfo(data: data),
              ),
              _InfoCard(
                title: "Data Pembeli",
                child: _BuyerInfo(user: data.user),
              ),
              if (data.admin != null)
                _InfoCard(
                  title: "Data Admin",
                  child: _AdminInfo(admin: data.admin!),
                ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: BtnDefault(
                    name: "Riwayat Transaksi",
                    onTap: () {
                      Next.to(
                          context,
                          OrderTransactionHistory(
                              orderNumber: data.orderNumber));
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: BtnDefault(
                    name: "Ajukan Retur",
                    color: Colors.green,
                    onTap: () {
                      Next.to(
                          context,
                          ReturFormAdd(
                            data: data,
                          ));
                    }),
              ),
              SizedBox(height: 20),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Center(child: Text('Error: $err')),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 80,
              child: TextH3(
                text: title,
                fontWeight: bold == true ? FontWeight.bold : FontWeight.w400,
              )),
          SizedBox(
            width: 10,
            child: TextH3(
              text: ":",
              fontWeight: bold == true ? FontWeight.bold : FontWeight.w400,
            ),
          ),
          Expanded(
            child: TextH3(
              text: value,
              fontWeight: bold == true ? FontWeight.bold : FontWeight.w400,
              textOverflow: TextOverflow.visible,
              maxLine: null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowStatus(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextH3(
            text: title,
            fontWeight: FontWeight.w400,
          ),
          Container(
            width: 150,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextH3(
              text: value,
              fontWeight: FontWeight.w600,
              textOverflow: TextOverflow.visible,
              color: Colors.white,
              maxLine: null,
              textAlign: TextAlign.center,
            ),
          ),
        ],
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

  Widget _buildAccordion({
    required String title,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.blue.shade50,
      title: TextH3(
        text: title,
        fontWeight: FontWeight.bold,
      ),
      initiallyExpanded: false, // Set false jika ingin tertutup di awal
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _InfoCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              spreadRadius: 1,
              offset: const Offset(0, 1),
            )
          ]),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 35,
            color: myColors.yellow,
            child: Center(
              child: TextH2(
                text: title,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _OrderInfo extends StatelessWidget {
  final OrderModel data;
  const _OrderInfo({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRow("Tanggal Pre Order",
            "${DateFormat.EEEE('id_ID').format(data.createdAt)}, ${DateFormat("dd-MM-yyyy").format(data.createdAt)}"),
        _buildRow("Jam",
            "${DateFormat.Hm().format(DateTime.parse(data.createdAt.toString()))} Wib"),
        const SizedBox(height: 15),
        Row(
          children: [
            _cardStatus(status: data.paymentStatus),
            SizedBox(
              width: 10,
            ),
            _cardStatusV2(status: data.orderTakingStatus),
          ],
        ),
        const SizedBox(height: 15),
        _buildRow("Jumlah Pesanan", "${data.quantity} Cup"),
        _buildRow("Harga", formatCurrency(data.price)),
        const Divider(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextH2(
                text: "Total Pemabayaran", fontWeight: FontWeight.bold),
            TextH3(
                text: formatCurrency((data.quantity * data.price)),
                fontWeight: FontWeight.bold),
          ],
        ),
        _buildRow("Bonus", "${data.bonus} Cup"),
        _buildRow("Cashback", formatCurrency(data.cashback)),
      ],
    );
  }
}

class _cardStatus extends StatelessWidget {
  final String status;
  const _cardStatus({required this.status});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: status == "lunas"
                  ? Colors.green
                  : status == "belum dibayar"
                      ? Colors.red
                      : Colors.yellow.shade700,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
                child: Image.asset(
              status == "lunas"
                  ? "assets/icons/ic_status_selesai.png"
                  : status == "belum dibayar"
                      ? "assets/icons/ic_status_dibatalkan.png"
                      : "assets/icons/ic_status_menunggu.png",
            )),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: status == "lunas"
                  ? Colors.green.withOpacity(0.2)
                  : status == "belum dibayar"
                      ? Colors.red.withOpacity(0.2)
                      : Colors.yellow.shade700.withOpacity(0.2),
              borderRadius: BorderRadius.circular(100),
            ),
            child: TextH3(
              text: status,
              color: status == "lunas"
                  ? Colors.green
                  : status == "belum dibayar"
                      ? Colors.red
                      : Colors.yellow.shade700,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _cardStatusV2 extends StatelessWidget {
  final String status;
  const _cardStatusV2({required this.status});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: status == "diambil semua"
                  ? Colors.green
                  : status == "belum diambil"
                      ? Colors.red
                      : Colors.yellow.shade700,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
                child: Image.asset(status == "diambil semua"
                    ? "assets/icons/ic_status_selesai.png"
                    : status == "belum diambil"
                        ? "assets/icons/ic_status_menunggu.png"
                        : "assets/icons/ic_status_dalam_proses.png")),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: status == "diambil semua"
                  ? Colors.green.withOpacity(0.2)
                  : status == "belum diambil"
                      ? Colors.red.withOpacity(0.2)
                      : Colors.yellow.shade700.withOpacity(0.2),
              borderRadius: BorderRadius.circular(100),
            ),
            child: TextH3(
              text: status,
              color: status == "diambil semua"
                  ? Colors.green
                  : status == "belum diambil"
                      ? Colors.red
                      : Colors.yellow.shade700,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _BuyerInfo extends StatelessWidget {
  final UserModel user;
  const _BuyerInfo({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRowV2("ID", user.uniqueId),
        _buildRowV2("Nama", user.name),
        _buildRowV2("Email", user.email),
        _buildRowV2("No. Hp", user.phoneNumber ?? "-"),
        _buildRowV2("Role", user.role),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextNormal(text: "Status", fontWeight: FontWeight.w400),
            Container(
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                color: user.status == "aktif"
                    ? Colors.green
                    : user.status == "suspend"
                        ? Colors.yellow
                        : Colors.red,
                borderRadius: BorderRadius.circular(3),
              ),
              child: TextNormal(
                text: user.status,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AdminInfo extends StatelessWidget {
  final UserModel admin;
  const _AdminInfo({required this.admin});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRowV2("Nama", admin.name),
        _buildRowV2("Email", admin.email),
      ],
    );
  }
}

Widget _buildRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextNormal(text: title, fontWeight: FontWeight.w400),
        TextNormal(text: value, fontWeight: FontWeight.bold),
      ],
    ),
  );
}

Widget _buildRowV2(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
            width: 80,
            child: TextNormal(text: title, fontWeight: FontWeight.w400)),
        Expanded(
            child: TextNormal(text: ": $value", fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
