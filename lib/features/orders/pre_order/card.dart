import 'package:flutter/material.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/h3.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/features/orders/pre_order/detail/index.dart';
import 'package:hanaang_app/models/pre_order_model.dart';
import 'package:hanaang_app/utilities/custom_color.dart';
import 'package:hanaang_app/utilities/next_to.dart';

class PreOrderCard extends StatelessWidget {
  final PreOrderModel data;
  const PreOrderCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Column(
        children: [
          Material(
            color: Colors.white,
            child: InkWell(
              focusColor: Colors.red,
              hoverColor: Colors.blue,
              highlightColor: myColors.yellow.withOpacity(0.2),
              splashColor: myColors.yellow.withOpacity(0.2),
              onTap: () {
                Next.to(
                    context,
                    PreOrderDetail(
                      poNumber: data.poNumber,
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextH3(
                            text: data.poNumber,
                            fontWeight: FontWeight.bold,
                          ),
                          TextNormal(text: data.user.uniqueId),
                          TextNormal(text: data.user.name),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          TextH2(
                            text: "${data.quantity} Cup",
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            width: 130,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: data.status == "dalam_proses"
                                  ? Colors.blue.withOpacity(0.2)
                                  : data.status == "selesai"
                                      ? Colors.green.withOpacity(0.2)
                                      : data.status == "dibatalkan"
                                          ? Colors.red.withOpacity(0.2)
                                          : Colors.yellow.shade700
                                              .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 26,
                                  width: 26,
                                  decoration: BoxDecoration(
                                    color: data.status == "dalam_proses"
                                        ? Colors.blue
                                        : data.status == "selesai"
                                            ? Colors.green
                                            : data.status == "dibatalkan"
                                                ? Colors.red
                                                : Colors.yellow.shade700,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                      child: Image.asset(
                                    data.status == "dalam_proses"
                                        ? "assets/icons/ic_status_dalam_proses.png"
                                        : data.status == "selesai"
                                            ? "assets/icons/ic_status_selesai.png"
                                            : data.status == "dibatalkan"
                                                ? "assets/icons/ic_status_dibatalkan.png"
                                                : "assets/icons/ic_status_menunggu.png",
                                  )),
                                ),
                                Expanded(
                                  child: TextNormal(
                                    text: data.status,
                                    color: data.status == "dalam_proses"
                                        ? Colors.blue
                                        : data.status == "selesai"
                                            ? Colors.green
                                            : data.status == "dibatalkan"
                                                ? Colors.red
                                                : Colors.yellow.shade700,
                                    fontWeight: FontWeight.bold,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
