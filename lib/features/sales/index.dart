import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class SalesMenu extends ConsumerStatefulWidget {
  const SalesMenu({super.key});

  @override
  ConsumerState<SalesMenu> createState() => _SalesMenuState();
}

class _SalesMenuState extends ConsumerState<SalesMenu> {
  String userRole = "";

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  _loadUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('user_role-hanaang_app') ?? "";
    });
  }

  bool _canAccessAgen() {
    return userRole == "super admin" ||
        userRole == "admin order" ||
        userRole == "distributor";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const CustomBgAppBar(),
        centerTitle: true,
        title: const TextH1(
          text: "Menu Penjualan",
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
                itemCount: _canAccessAgen() ? 3 : 2,
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
                    if (_canAccessAgen())
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
                          Next.to(context, const SalesPage());
                          break;
                        case 1:
                          Next.to(context, const Store());
                          break;
                        case 2:
                          if (_canAccessAgen()) {
                            Next.to(context, const Agen());
                          }
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
          TextNormal(
            text: label,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
