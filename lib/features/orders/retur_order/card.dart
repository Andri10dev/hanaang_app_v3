import 'package:flutter/material.dart';
import 'package:hanaang_app/components/texts/h1.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/h3.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/features/orders/retur_order/detail/index.dart';
import 'package:hanaang_app/models/retur_order_model.dart';
import 'package:hanaang_app/utilities/custom_color.dart';
import 'package:hanaang_app/utilities/next_to.dart';

class ReturOrderCard extends StatelessWidget {
  final ReturOrderModel data;
  const ReturOrderCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Next.to(context, ReturOrderDetail(returNumber: data.returNumber));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextH2(text: data.returNumber, fontWeight: FontWeight.bold),
                  SizedBox(
                    height: 5,
                  ),
                  TextNormal(
                      text: data.user.uniqueId, fontWeight: FontWeight.w500),
                  SizedBox(
                    height: 5,
                  ),
                  TextNormal(text: data.user.name, fontWeight: FontWeight.w500),
                ],
              ),
            ),
            Column(
              children: [
                TextH2(
                    text: "${data.quantity} Cup", fontWeight: FontWeight.bold),
                SizedBox(
                  height: 5,
                ),
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
                SizedBox(
                  height: 5,
                ),
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
        ),
      ),
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

  Widget _buildRow(String title, String value,
      {bool? widget = false, Color? color = Colors.red, int textType = 0}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textType == 0
              ? TextNormal(text: title, fontWeight: FontWeight.bold)
              : TextH1(text: title, fontWeight: FontWeight.bold),
          widget != true
              ? TextNormal(text: value, fontWeight: FontWeight.bold)
              : _buildStatus(value, color!),
        ],
      ),
    );
  }
}
