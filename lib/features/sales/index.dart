import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hanaang_app/components/custom_header.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/texts/h1.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/features/sales/agen/index.dart';
import 'package:hanaang_app/features/sales/sale.dart';
import 'package:hanaang_app/features/sales/store/index.dart';
import 'package:hanaang_app/utilities/next_to.dart';
import 'package:mrx_charts/mrx_charts.dart';

class SalesMenu extends StatelessWidget {
  const SalesMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: CustomBgAppBar(),
        centerTitle: true,
        title: TextH1(
          text: "Menu Penjualan",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomHeader(),
            Container(
              height: 300,
              padding: const EdgeInsets.all(16),
              child: Chart(layers: [
                ChartAxisLayer(
                  settings: ChartAxisSettings(
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
                  settings: ChartLineSettings(
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
                  settings: ChartLineSettings(
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
                  settings: ChartLineSettings(
                    color: Colors.yellow,
                    thickness: 2,
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 300,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 2,
                ),
                padding: EdgeInsets.all(15),
                itemCount: 3,
                itemBuilder: (context, index) {
                  final List<Map<String, dynamic>> stats = [
                    {
                      'color': Colors.blue[100]!,
                      'value': '100 Cup',
                      'label': 'Penjualan',
                    },
                    {
                      'color': Colors.green[100]!,
                      'value': '100',
                      'label': 'Warung',
                    },
                    {
                      'color': Colors.orange[100]!,
                      'value': '100',
                      'label': 'Agen',
                    },
                  ];

                  return _buildStatButton(
                    color: stats[index]['color'],
                    value: stats[index]['value'],
                    label: stats[index]['label'],
                    onTap: () {
                      switch (index) {
                        case 0:
                          Next.to(context, SalesPage());
                          break;
                        case 1:
                          Next.to(context, Store());
                          break;
                        case 2:
                          Next.to(context, Agen());
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
          SizedBox(height: 5),
          TextNormal(
            text: label,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
