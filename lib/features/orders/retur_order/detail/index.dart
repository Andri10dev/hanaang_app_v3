import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/customs/btn_default.dart';
import 'package:hanaang_app/components/texts/h1.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/h3.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/features/orders/order/detail/index.dart';
import 'package:hanaang_app/features/orders/retur_order/detail/show_qr_code.dart';
import 'package:hanaang_app/features/orders/retur_order/detail/transaction/index.dart';
import 'package:hanaang_app/models/retur_order_model.dart';
import 'package:hanaang_app/models/user_model.dart';
import 'package:hanaang_app/providers/orders/retur_order_provider.dart';
import 'package:hanaang_app/utilities/base_url.dart';
import 'package:hanaang_app/utilities/custom_color.dart';
import 'package:hanaang_app/utilities/next_to.dart';
import 'package:intl/intl.dart';

class ReturOrderDetail extends ConsumerWidget {
  final String returNumber;
  const ReturOrderDetail({super.key, required this.returNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getData = ref.watch(showReturOrderProvider(returNumber));
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: const CustomBgAppBar(),
          centerTitle: true,
          title: const TextH2(
            text: "Detail Retur Pesanan",
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
                      ShowQRCodeReturOrder(context, returNumber, data.user),
                  loading: () => null,
                  error: (err, _) => null,
                );
              },
            ),
          ]),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(showReturOrderProvider(returNumber));
          await ref.read(showReturOrderProvider(returNumber).future);
        },
        child: getData.when(
          data: (data) => ListView(
            children: [
              _InfoCard(
                title: "No Retur Order : ${data.returNumber}",
                child: _ReturInfo(data: data),
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
                child: Row(
                  children: [
                    Expanded(
                      child: BtnDefault(
                          name: "Lihat Pesanan",
                          onTap: () {
                            Next.to(
                                context,
                                OrderDetail(
                                    orderNumber: data.order.orderNumber));
                          }),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: BtnDefault(
                          name: "Riwayat Transaksi",
                          onTap: () {
                            // Next.to(
                            //     context,
                            // OrderTransactionHistory(
                            //     orderNumber: data.orderNumber));
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              if (data.images.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      TextH3(
                        text: "Gambar Bukti Retur",
                        fontWeight: FontWeight.bold,
                      ),
                      Divider(),
                      SizedBox(height: 10),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.0,
                        ),
                        itemCount: data.images.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => Dialog(
                                  backgroundColor: Colors.black,
                                  insetPadding: EdgeInsets.zero,
                                  child: _FullScreenImageViewer(
                                    images: data.images,
                                    initialIndex: index,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  "${BaseUrl.baseUrl}/storage/${data.images[index].image}",
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey.shade200,
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.grey.shade400,
                                        size: 40,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
          loading: () => SingleChildScrollView(
              child: const Center(child: CircularProgressIndicator())),
          error: (err, _) {
            return SingleChildScrollView(
                child: Center(child: Text('Error: $err')));
          },
        ),
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

class _ReturInfo extends StatelessWidget {
  final ReturOrderModel data;
  const _ReturInfo({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextNormal(text: "Jumlah Retur", fontWeight: FontWeight.w500),
        TextH1(text: "${data.quantity} Cup", fontWeight: FontWeight.bold),
        Divider(),
        _buildRow("Tanggal",
            "${DateFormat.EEEE('id_ID').format(data.createdAt)}, ${DateFormat("dd-MM-yyyy").format(data.createdAt)}"),
        _buildRow("Jam",
            "${DateFormat.Hm().format(DateTime.parse(data.createdAt.toString()))} Wib"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextNormal(text: "Status", fontWeight: FontWeight.w400),
            _buildStatus(
              data.status,
              data.status == "dalam proses"
                  ? myColors.yellow
                  : data.status == "disetujui"
                      ? Colors.blue
                      : data.status == "selesai"
                          ? Colors.green
                          : Colors.red,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextNormal(text: "Status Pengambilan", fontWeight: FontWeight.w400),
            _buildStatus(
              data.takingStatus,
              data.takingStatus == "belum diambil"
                  ? myColors.yellow
                  : data.takingStatus == "diambil semua"
                      ? Colors.green
                      : Colors.red,
            )
          ],
        )
      ],
    );
  }

  Widget _buildStatus(String value, Color color) {
    return Container(
      width: 150,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextNormal(
        text: value,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        textAlign: TextAlign.center,
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

class _FullScreenImageViewer extends StatefulWidget {
  final List images;
  final int initialIndex;

  const _FullScreenImageViewer({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<_FullScreenImageViewer> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          itemCount: widget.images.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return InteractiveViewer(
              minScale: 1,
              maxScale: 5,
              child: Center(
                child: Image.network(
                  "${BaseUrl.baseUrl}/storage/${widget.images[index].image}",
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.error,
                        color: Colors.grey.shade400,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
        Positioned(
          top: 40,
          right: 20,
          child: IconButton(
            icon: Icon(Icons.close, color: Colors.white, size: 30),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        if (widget.images.length > 1)
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "${_currentIndex + 1} / ${widget.images.length}",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
      ],
    );
  }
}
