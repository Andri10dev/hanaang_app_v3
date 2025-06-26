import 'package:flutter/material.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/texts/h1.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/utilities/custom_color.dart';

class AgenDetail extends StatelessWidget {
  const AgenDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const CustomBgAppBar(),
        title: const TextH2(
          text: 'Detail Agen',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(1000),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        width: 100,
                        decoration: BoxDecoration(
                            color: myColors.yellow,
                            borderRadius: BorderRadius.circular(10)),
                        child: const TextNormal(
                          text: "Agen",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextH1(
                          text: "Andri Ardiansyah",
                          fontWeight: FontWeight.bold),
                      TextH2(text: "Id Agen", fontWeight: FontWeight.bold),
                      TextNormal(
                          text: "email@gmail.com", fontWeight: FontWeight.bold),
                      TextNormal(text: "0867", fontWeight: FontWeight.bold),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: _buildTitle("Alamat"),
              ),
              const Divider(thickness: 2),
              const SizedBox(height: 8),
              _buildRowInfo("Provinsi", "Jawa Barat"),
              _buildRowInfo("Kabupaten", "Kabupaten Bandung Barat"),
              _buildRowInfo("Kecamatan", "Cikalong Wetan"),
              _buildRowInfo("Kelurahan", "Cikalong"),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: _buildTitle("Detail Alamat"),
              ),
              const Divider(thickness: 2),
              const SizedBox(height: 8),
              const Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                "when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }

  Widget _buildRowInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
          Expanded(
              flex: 3,
              child: Text(
                value,
                textAlign: TextAlign.right,
              )),
        ],
      ),
    );
  }
}
