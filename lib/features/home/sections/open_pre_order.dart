import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/customs/btn_default.dart';
import 'package:hanaang_app/components/texts/h1.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/h3.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/features/home/dialog_po/index.dart';
import 'package:hanaang_app/models/open_pre_order_model.dart';
import 'package:hanaang_app/providers/orders/open_po_provider.dart';
import 'package:hanaang_app/utilities/custom_color.dart';
import 'package:intl/intl.dart';

class OpenPreOrderSection extends ConsumerWidget {
  final String userRole;
  const OpenPreOrderSection({super.key, required this.userRole});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getData = ref.watch(getOpenPreOrderProvider);

    return RefreshIndicator(
      onRefresh: () async {
        // Invalidate provider untuk refresh data
        ref.invalidate(getOpenPreOrderProvider);
        // Tunggu sampai data baru selesai dimuat
        await ref.read(getOpenPreOrderProvider.future);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: TextH1(
                  text: "Pre Order",
                  fontWeight: FontWeight.bold,
                )),
            getData.when(
              data: (OpenPreOrderModel data) => AspectRatio(
                aspectRatio: 16 / 7,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg_po.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.srcATop),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextH2(
                            text:
                                "Produk tersedia :  ${data.quantity - data.ordered} / ${data.quantity} Cup",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextNormal(
                                  text: "Waktu Mulai:",
                                  color: myColors.yellow,
                                  fontWeight: FontWeight.bold,
                                ),
                                Row(
                                  children: [
                                    TextH3(
                                      text: DateFormat.EEEE('id_ID')
                                              .format(data.startDate) +
                                          ", " +
                                          DateFormat("dd-MM-yyyy")
                                              .format(data.startDate) +
                                          " " +
                                          " " +
                                          DateFormat.Hm().format(DateTime.parse(
                                              data.startDate.toString())) +
                                          " Wib",
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TextNormal(
                                  text: "Waktu Selesai:",
                                  color: myColors.yellow,
                                  fontWeight: FontWeight.bold,
                                ),
                                Row(
                                  children: [
                                    TextH3(
                                      text: DateFormat.EEEE('id_ID')
                                              .format(data.endDate) +
                                          ", " +
                                          DateFormat("dd-MM-yyyy")
                                              .format(data.endDate) +
                                          " " +
                                          " " +
                                          DateFormat.Hm().format(DateTime.parse(
                                              data.endDate.toString())) +
                                          " Wib",
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
            SizedBox(
              height: 20,
            ),
            ["super admin", "admin order"].contains(userRole)
                ? BtnDefault(
                    name: "Atur Pre Order",
                    onTap: () {
                      // showPreOrderDialog(context, ref);
                    },
                    color: myColors.yellow,
                  )
                : getData.when(
                    data: (OpenPreOrderModel data) {
                      final now = DateTime.now();
                      final isPreOrderActive =
                          (now.isAtSameMomentAs(data.startDate) ||
                                  now.isAfter(data.startDate)) &&
                              (now.isAtSameMomentAs(data.endDate) ||
                                  now.isBefore(data.endDate)) &&
                              data.ordered < data.quantity;
                      return BtnDefault(
                        name: isPreOrderActive
                            ? "Pesan Sekarang"
                            : "Pre Order Ditutup",
                        onTap: isPreOrderActive
                            ? () {
                                showPreOrderDialog(context, ref);
                              }
                            : () {},
                        color: isPreOrderActive ? myColors.yellow : Colors.red,
                      );
                    },
                    error: (err, _) => Center(child: Text('Error: $err')),
                    loading: () => Center(child: CircularProgressIndicator()),
                  ),
            // Tambahkan padding di bawah untuk memastikan refresh indicator bisa di-scroll
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
