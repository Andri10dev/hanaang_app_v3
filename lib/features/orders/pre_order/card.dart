import 'package:flutter/material.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/h3.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/features/orders/pre_order/detail/index.dart';
import 'package:hanaang_app/models/pre_order_model.dart';
import 'package:hanaang_app/utilities/next_to.dart';
import 'package:intl/intl.dart';

class PreOrderCard extends StatelessWidget {
  final PreOrderModel data;
  const PreOrderCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () {
              Next.to(context, PreOrderDetail(poNumber: data.poNumber));
            },
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kolom informasi user dan pesanan
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nama dan Email
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextH2(
                                text: "${data.poNumber}",
                                fontWeight: FontWeight.bold),
                            TextNormal(
                                text: DateFormat.EEEE('id_ID')
                                        .format(data.createdAt) +
                                    ", " +
                                    DateFormat("dd-MM-yyyy")
                                        .format(data.createdAt),
                                fontWeight: FontWeight.w500)
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Harga dan Total Harga
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextNormal(
                                text: 'Jumlah Pesanan :',
                                fontWeight: FontWeight.w500),
                            TextNormal(
                                text: '${data.quantity} Cup',
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextNormal(
                                text: 'Harga / Cup :',
                                fontWeight: FontWeight.w500),
                            TextNormal(
                                text: 'RP ${data.price}',
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Divider(
                          height: 2,
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextH3(
                                text: 'Total harga :',
                                fontWeight: FontWeight.w500),
                            TextH3(
                                text: 'RP ${data.price}',
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
