import 'package:flutter/material.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/components/texts/sm.dart';
import 'package:hanaang_app/features/orders/order/detail/index.dart';
import 'package:hanaang_app/models/order_model.dart';
import 'package:hanaang_app/utilities/custom_color.dart';
import 'package:hanaang_app/utilities/next_to.dart';

class OrderCard extends StatelessWidget {
  final OrderModel data;
  const OrderCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Next.to(context, OrderDetail(orderNumber: data.orderNumber));
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextH2(
                          text: data.orderNumber, fontWeight: FontWeight.bold),
                      SizedBox(
                        height: 5,
                      ),
                      TextNormal(
                          text: data.user.uniqueId,
                          fontWeight: FontWeight.w500),
                      SizedBox(
                        height: 5,
                      ),
                      TextNormal(
                          text: data.user.name, fontWeight: FontWeight.w500),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextH2(
                        text: "${data.quantity} Cup",
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 5,
                    ),
                    _buildStatus(
                      data.paymentStatus,
                      data.paymentStatus == "lunas"
                          ? Colors.green
                          : data.paymentStatus == "belum dibayar"
                              ? Colors.red
                              : myColors.yellow,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    _buildStatus(
                        data.orderTakingStatus,
                        data.orderTakingStatus == "sudah diambil"
                            ? Colors.green
                            : data.orderTakingStatus == "belum diambil"
                                ? Colors.red
                                : myColors.yellow)
                  ],
                ))
              ],
            ),
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
      child: TextSm(
        text: value,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        textAlign: TextAlign.center,
      ),
    );
  }
}
