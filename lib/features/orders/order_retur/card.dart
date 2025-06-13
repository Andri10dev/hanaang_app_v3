import 'package:flutter/material.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/h3.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/components/texts/sm.dart';
import 'package:hanaang_app/utilities/custom_color.dart';

class ReturOrderCard extends StatelessWidget {
  const ReturOrderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
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
                      text: "RO-2506005",
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        TextNormal(
                          text: "Jumlah Retur : ",
                          fontWeight: FontWeight.bold,
                        ),
                        TextNormal(
                          text: "100 Cup",
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ],
                ),
                TextNormal(
                  text: "date",
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
                    _buildStatusBadge("acc", color: myColors.yellow),
                    SizedBox(height: 5),
                    _buildStatusBadge(
                      "Belum Diambil",
                      color: Colors.red,
                    ),
                  ],
                ),
                TextH2(
                  text: "200 ",
                  fontWeight: FontWeight.w500,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String text, {Color? color}) {
    return Container(
      width: 125,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color ?? Colors.red,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: TextSm(
          text: text,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
