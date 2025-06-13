import 'package:flutter/material.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/h3.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/components/texts/sm.dart';
import 'package:hanaang_app/features/orders/order/detail.dart';
import 'package:hanaang_app/models/order_model.dart';
import 'package:hanaang_app/utilities/next_to.dart';
import 'package:intl/intl.dart';

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
        height: 125,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2,
              spreadRadius: 0.1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextH3(
                      text: data.orderNumber,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        TextNormal(
                          text: "Pesanan :",
                          fontWeight: FontWeight.bold,
                        ),
                        TextNormal(
                          text: "${data.quantity} Cup",
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ],
                ),
                TextNormal(
                  text: DateFormat.EEEE('id_ID').format(data.createdAt) +
                      ", " +
                      DateFormat("dd-MM-yyyy").format(data.createdAt),
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildStatusBadge(data.paymentStatus),
                    SizedBox(height: 5),
                    _buildStatusBadge(data.orderTakingStatus),
                  ],
                ),
                TextH2(
                  text: "${data.price}",
                  fontWeight: FontWeight.w500,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextSm(
        text: text,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
