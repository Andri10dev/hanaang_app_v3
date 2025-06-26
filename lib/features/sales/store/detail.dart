import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/h3.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:mrx_charts/mrx_charts.dart';

class StoreDetail extends StatelessWidget {
  const StoreDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const CustomBgAppBar(),
        title: const TextH2(
          text: 'Detail Warung',
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 30,
                height: 30,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.amber,
                    size: 20,
                  ),
                ),
              ),
              Container(
                width: 30,
                height: 30,
                margin: const EdgeInsets.only(left: 4, right: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const TextH2(
                            text: 'Konfirmasi Hapus',
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.center,
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/icons/ic_danger.png',
                                height: 100,
                                width: 100,
                              ),
                              const SizedBox(height: 16),
                              const TextNormal(
                                text:
                                    'Apakah Anda yakin ingin menghapus data warung ini?',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          actionsAlignment: MainAxisAlignment.spaceAround,
                          actions: [
                            Container(
                              width: 125,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 2, color: Colors.red),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Menutup dialog
                                },
                                child: const TextNormal(
                                  text: 'Batal',
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Container(
                              width: 125,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  // Tambahkan logika hapus data di sini
                                  Navigator.of(context).pop(); // Menutup dialog
                                },
                                child: const TextNormal(
                                  text: 'Hapus',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                width: double.infinity,
                color: Colors.yellow.shade200,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: TextH2(
                      text: "Nama Warung",
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: TextH3(
                        text: "Nama Pemilik",
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: TextH3(
                        text: "Id Warung",
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TextH2(
                      text: "Alamat",
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    height: 2,
                    color: Colors.black,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextNormal(text: "Provinsi"),
                      TextNormal(text: "Jawa Barat"),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextNormal(text: "Kabupaten / Kota"),
                      TextNormal(text: "Bandung"),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextNormal(text: "Kecamatan"),
                      TextNormal(text: "Bandung"),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextNormal(text: "Desa / Kelurahan"),
                      TextNormal(text: "Bandung"),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextH2(
                      text: "Detail Alamat", fontWeight: FontWeight.bold),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    height: 2,
                    color: Colors.black,
                  ),
                  const TextNormal(
                    text:
                        "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.",
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextH2(
                      text: "Grafik Penjualan / Tahun",
                      fontWeight: FontWeight.bold),
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
                          color: Colors.green,
                          thickness: 2,
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
