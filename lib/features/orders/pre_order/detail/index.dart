import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/customs/btn_default.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/h3.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/features/home/sections/open_pre_order/dialog_po/riverpod.dart';
import 'package:hanaang_app/features/orders/pre_order/detail/show_qr_code.dart';
import 'package:hanaang_app/features/orders/pre_order/detail/void_show_dialog.dart';
import 'package:hanaang_app/features/orders/pre_order/detail/void_update_form.dart';
import 'package:hanaang_app/models/pre_order_model.dart';
import 'package:hanaang_app/models/user_model.dart';
import 'package:hanaang_app/providers/auths/local_storage_provider.dart';
import 'package:hanaang_app/providers/orders/pre_order/pre_order_provider.dart';
import 'package:hanaang_app/utilities/custom_color.dart';
import 'package:hanaang_app/utilities/format_currency.dart';
import 'package:intl/intl.dart';

class PreOrderDetail extends ConsumerWidget {
  final String poNumber;
  const PreOrderDetail({super.key, required this.poNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getData = ref.watch(showPreOrderProvider(poNumber));
    final userRole = ref.watch(getUserRoleProvider).toString();
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const CustomBgAppBar(),
        centerTitle: true,
        title: TextH2(
          text: "Detail Pre Order",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.qr_code_scanner, color: Colors.white),
              onPressed: () {
                getData.when(
                    data: (data) {
                      ShowQRCodePreOrder(context, poNumber, data.user);
                    },
                    error: (error, stackTrace) {},
                    loading: () {});
              }),
        ],
      ),
      body: getData.when(
        data: (data) => ListView(
          children: [
            _InfoCard(
              title: "No Pre Order : ${data.poNumber}",
              child: _PreOrderInfo(data: data),
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
            const SizedBox(height: 20),
            Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(children: [
                  if (["distributor", "agen", "warga", "keluarga"]
                          .contains(userRole) &&
                      data.status == "menunggu") ...[
                    Expanded(
                      child: BtnDefault(
                          name: "Batalkan Pre Order",
                          color: Colors.red,
                          onTap: () {
                            showCancelPoConfirmation(
                                context, ref, data.poNumber);
                          }),
                    ),
                    if (["distributor", "agen", "warga", "keluarga"]
                            .contains(userRole) &&
                        data.status == "menunggu") ...[
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: BtnDefault(
                            name: "Ubah Pre Order",
                            color: myColors.yellow,
                            onTap: () {
                              ref.read(orderCountProvider.notifier).state =
                                  data.quantity;
                              showPreOrderUpdateDialog(context, ref, data);
                            }),
                      ),
                    ],
                    if (["super admin", "admin order"].contains(userRole)) ...[
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: BtnDefault(
                            name: "Jadikan Pesanan",
                            color: Colors.green,
                            onTap: () {}),
                      )
                    ]
                  ]
                ]))
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
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

class _PreOrderInfo extends StatelessWidget {
  final PreOrderModel data;
  const _PreOrderInfo({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRow("Tanggal Pre Order",
            "${DateFormat.EEEE('id_ID').format(data.createdAt)}, ${DateFormat("dd-MM-yyyy").format(data.createdAt)}"),
        _buildRow("Jam",
            "${DateFormat.Hm().format(DateTime.parse(data.createdAt.toString()))} Wib"),
        const SizedBox(height: 15),
        _cardStatus(status: data.status),
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
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: status == "dalam_proses"
                ? Colors.blue
                : status == "selesai"
                    ? Colors.green
                    : status == "dibatalkan"
                        ? Colors.red
                        : Colors.yellow.shade700,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
              child: Image.asset(
            status == "dalam_proses"
                ? "assets/icons/ic_status_dalam_proses.png"
                : status == "selesai"
                    ? "assets/icons/ic_status_selesai.png"
                    : status == "dibatalkan"
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
            color: status == "dalam_proses"
                ? Colors.blue.withOpacity(0.2)
                : status == "selesai"
                    ? Colors.green.withOpacity(0.2)
                    : status == "dibatalkan"
                        ? Colors.red.withOpacity(0.2)
                        : Colors.yellow.shade700.withOpacity(0.2),
            borderRadius: BorderRadius.circular(100),
          ),
          child: TextH2(
            text: status,
            color: status == "dalam_proses"
                ? Colors.blue
                : status == "selesai"
                    ? Colors.green
                    : status == "dibatalkan"
                        ? Colors.red
                        : Colors.yellow.shade700,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
        ),
      ],
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

class _ActionButtons extends StatelessWidget {
  final String userRole;
  const _ActionButtons({required this.userRole});

  @override
  Widget build(BuildContext context) {
    if (["distributor", "agen", "warga", "keluarga"].contains(userRole)) {
      return BtnDefault(
          color: Colors.red, name: "Batalkan Pesanan", onTap: () {});
    }
    if (["super admin", "admin order"].contains(userRole)) {
      return Row(
        children: [
          Expanded(
            child: BtnDefault(name: "Ubah Pesanan", onTap: () {}),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: BtnDefault(
                color: Colors.green, name: "Jadikan Pesanan", onTap: () {}),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
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
