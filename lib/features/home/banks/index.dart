import 'package:flutter/material.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/h3.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/utilities/custom_color.dart';

class BankMenu extends StatelessWidget {
  const BankMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.0), // Tinggi AppBar
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    myColors.orange,
                    myColors.yellow,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            centerTitle: true,
            title: TextH2(
              text: "Daftar Bank / Kas",
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      // Data dummy
                      final List<Map<String, dynamic>> dummyData = [
                        {
                          'name': 'Bank BNI',
                          'balance': 'Rp. 2.000.000.000',
                          'isPrimary': true,
                          'image': 'assets/icons/ic_bank.png'
                        },
                        {
                          'name': 'Bank Mandiri',
                          'balance': 'Rp. 1.500.000.000',
                          'isPrimary': false,
                          'image': 'assets/icons/ic_bank.png'
                        },
                        {
                          'name': 'Bank BCA',
                          'balance': 'Rp. 3.000.000.000',
                          'isPrimary': false,
                          'image': 'assets/icons/ic_bank.png'
                        },
                        {
                          'name': 'Bank BRI',
                          'balance': 'Rp. 1.800.000.000',
                          'isPrimary': false,
                          'image': 'assets/icons/ic_bank.png'
                        },
                        {
                          'name': 'Bank CIMB Niaga',
                          'balance': 'Rp. 2.500.000.000',
                          'isPrimary': false,
                          'image': 'assets/icons/ic_bank.png'
                        },
                      ];

                      return InkWell(
                        onTap: () {
                          // Tambahkan aksi ketika tombol ditekan
                          print('Bank ${dummyData[index]['name']} dipilih');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: dummyData[index]['isPrimary'] ? 2 : 0,
                                color: dummyData[index]['isPrimary']
                                    ? myColors.yellow
                                    : Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (dummyData[index]['isPrimary'])
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextNormal(
                                      text: "Primary",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              AspectRatio(
                                aspectRatio: 16 / 7,
                                child: Image.asset(
                                  dummyData[index]['image'],
                                  fit: BoxFit.contain,
                                ),
                              ),
                              TextH2(text: dummyData[index]['balance']),
                              TextH3(text: dummyData[index]['name'])
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )),
        ));
  }
}
