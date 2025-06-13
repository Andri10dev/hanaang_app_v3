import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/customs/btn_default.dart';
import 'package:hanaang_app/components/texts/h1.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/h3.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/features/orders/pre_order/detail/show_qr_code.dart';
import 'package:hanaang_app/providers/auths/local_storage_provider.dart';
import 'package:hanaang_app/providers/orders/pre_order_provider.dart';
import 'package:intl/intl.dart';

class PreOrderDetail extends ConsumerStatefulWidget {
  final String poNumber;
  const PreOrderDetail({super.key, required this.poNumber});

  @override
  ConsumerState<PreOrderDetail> createState() => _PreOrderDetailState();
}

class _PreOrderDetailState extends ConsumerState<PreOrderDetail> {
  String? savedName;

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    final localStorage = ref.read(localStorageProvider);
    final getName = await localStorage.getString('user_role-hanaang_app');
    setState(() {
      print("===============Get Name==============");
      print(getName);
      savedName = getName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final showPreOrder = ref.watch(showPreOrderProvider(widget.poNumber));
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: CustomBgAppBar(),
        centerTitle: true,
        title: TextH2(
          text: "Detail Pre Order ${savedName}",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
            ),
            onPressed: () {
              showPreOrder.when(
                data: (data) =>
                    ShowQRCodePreOrder(context, widget.poNumber, data.user),
                loading: () => null,
                error: (err, _) => null,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(showPreOrderProvider(widget.poNumber));
              await ref.read(showPreOrderProvider(widget.poNumber).future);
            },
            child: showPreOrder.when(
                data: (data) => Column(
                      children: [
                        TextH1(
                            text: widget.poNumber, fontWeight: FontWeight.bold),
                        SizedBox(
                          height: 20,
                        ),
                        _buildRow(
                            "Tanggal Pesanan",
                            DateFormat.EEEE('id_ID').format(data.createdAt) +
                                ", " +
                                DateFormat("dd-MM-yyyy")
                                    .format(data.createdAt)),
                        _buildRow(
                            "Jam",
                            DateFormat.Hm().format(
                                    DateTime.parse(data.createdAt.toString())) +
                                " Wib"),
                        Divider(
                          height: 15,
                        ),
                        _buildRow("Jumlah Pesanan",
                            data.quantity.toString() + " Cup"),
                        _buildRow("Harga", data.price.toString()),
                        _buildRow("Bonus", data.bonus.toString() + " Cup"),
                        _buildRow("Cashback", data.cashback.toString()),
                        Divider(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextH3(
                                text: "Total Pemabayaran",
                                fontWeight: FontWeight.bold),
                            TextH3(
                                text: (data.quantity * data.price).toString(),
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextH2(
                            text: "Data Pembeli :",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          height: 2,
                        ),
                        _buildRow("ID", data.user.uniqueId),
                        _buildRow("Nama", data.user.name),
                        _buildRow("Email", data.user.email),
                        _buildRow("No. Hp", data.user.phoneNumber ?? "-"),
                        _buildRow("Role", data.user.role),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextNormal(
                                text: "Status", fontWeight: FontWeight.w400),
                            Container(
                              width: 100,
                              padding: EdgeInsets.symmetric(vertical: 3),
                              decoration: BoxDecoration(
                                color: data.user.status == "aktif"
                                    ? Colors.green
                                    : data.user.status == "suspend"
                                        ? Colors.yellow
                                        : Colors.red,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: TextNormal(
                                text: data.user.status,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              !["super admin", "admin order"]
                                      .contains(savedName)
                                  ? Expanded(
                                      child: BtnDefault(
                                          color: Colors.red,
                                          name: "Batalkan Pesanan",
                                          onTap: () {}),
                                    )
                                  : Container(),
                              !["super admin", "admin order"]
                                      .contains(savedName)
                                  ? SizedBox(
                                      width: 15,
                                    )
                                  : Container(),
                              Expanded(
                                child: BtnDefault(
                                    name: "Ubah Pesanan", onTap: () {}),
                              ),
                              ["super admin", "admin order"].contains(savedName)
                                  ? SizedBox(
                                      width: 15,
                                    )
                                  : Container(),
                              ["super admin", "admin order"].contains(savedName)
                                  ? Expanded(
                                      child: BtnDefault(
                                          color: Colors.green,
                                          name: "Jadikan Pesanan",
                                          onTap: () {}),
                                    )
                                  : Container()
                            ],
                          ),
                        )
                      ],
                    ),
                loading: () => Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text('Error: $err'))),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextNormal(text: title, fontWeight: FontWeight.w400),
          TextNormal(text: value, fontWeight: FontWeight.bold),
        ],
      ),
    );
  }
}
