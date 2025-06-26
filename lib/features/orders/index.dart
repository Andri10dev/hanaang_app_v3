import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hanaang_app/components/custom_header.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/texts/h1.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/h3.dart';
import 'package:hanaang_app/features/orders/antrian/index.dart';
import 'package:hanaang_app/features/orders/order/index.dart';
import 'package:hanaang_app/features/orders/pre_order/index.dart';
import 'package:hanaang_app/features/orders/retur_order/index.dart';
import 'package:hanaang_app/providers/orders/pre_order/nav_pre_order_provider.dart';
import 'package:hanaang_app/utilities/next_to.dart';
import 'package:mrx_charts/mrx_charts.dart';

class OrderMenu extends ConsumerWidget {
  const OrderMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const CustomBgAppBar(),
        centerTitle: true,
        title: const TextH1(
          text: "Menu Pesanan",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeader(),
            Container(
              height: 300,
              padding: const EdgeInsets.all(16),
              child: Chart(layers: [
                ChartAxisLayer(
                  settings: const ChartAxisSettings(
                    x: ChartAxisSettingsAxis(
                      frequency: 1.0,
                      max: 12,
                      min: 1,
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10.0,
                      ),
                    ),
                    y: ChartAxisSettingsAxis(
                      frequency: 100,
                      max: 500,
                      min: 0,
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  labelX: (value) => value.toInt().toString(),
                  labelY: (value) => value.toInt().toString(),
                ),
                ChartLineLayer(
                  items: List.generate(
                      12,
                      (index) => ChartLineDataItem(
                            value: Random().nextInt(500) + 20,
                            x: index.toDouble() + 1,
                          )),
                  settings: const ChartLineSettings(
                    color: Colors.blue,
                    thickness: 2,
                  ),
                ),
                ChartLineLayer(
                  items: List.generate(
                      12,
                      (index) => ChartLineDataItem(
                            value: Random().nextInt(500) + 20,
                            x: index.toDouble() + 1,
                          )),
                  settings: const ChartLineSettings(
                    color: Colors.green,
                    thickness: 2,
                  ),
                ),
                ChartLineLayer(
                  items: List.generate(
                      12,
                      (index) => ChartLineDataItem(
                            value: Random().nextInt(500) + 20,
                            x: index.toDouble() + 1,
                          )),
                  settings: const ChartLineSettings(
                    color: Colors.yellow,
                    thickness: 2,
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 300,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2,
                ),
                padding: const EdgeInsets.all(15),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final List<Map<String, dynamic>> stats = [
                    {
                      'color': Colors.blue[100]!,
                      'value': '100 Cup',
                      'label': 'Pre Order',
                    },
                    {
                      'color': Colors.red[100]!,
                      'value': '100',
                      'label': 'Antrian PO',
                    },
                    {
                      'color': Colors.green[100]!,
                      'value': '100',
                      'label': 'Pesanan',
                    },
                    {
                      'color': Colors.orange[100]!,
                      'value': '100',
                      'label': 'Retur',
                    },
                  ];

                  return _buildStatButton(
                    color: stats[index]['color'],
                    value: stats[index]['value'],
                    label: stats[index]['label'],
                    onTap: () {
                      switch (index) {
                        case 0:
                          ref.read(navPreOrderProvider.notifier).setIndex(0);
                          ref.read(statusPoProvider.notifier).state = 'semua';
                          Next.to(context, PreOrder());
                          break;
                        case 1:
                          Next.to(context, const Antrian());
                          break;
                        case 2:
                          Next.to(context, const Order());
                          break;
                        case 3:
                          Next.to(context, const ReturOrder());
                          break;
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatButton({
    required Color color,
    required String value,
    required String label,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextH2(
            text: value,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 5),
          TextH3(
            text: label,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
