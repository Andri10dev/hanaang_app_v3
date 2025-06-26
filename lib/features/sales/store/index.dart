import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/h3.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/features/sales/store/detail.dart';
import 'package:hanaang_app/utilities/next_to.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  bool _isSearchVisible = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const CustomBgAppBar(),
        title: _isSearchVisible
            ? TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Cari warung...',
                  hintStyle: const TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _isSearchVisible = false;
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              )
            : const TextH2(
                text: 'Warung',
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
          IconButton(
            icon: Icon(
              _isSearchVisible ? Icons.keyboard_return : Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isSearchVisible = !_isSearchVisible;
                if (!_isSearchVisible) {
                  _searchController.clear();
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: List.generate(20, (index) {
              // Generate data random
              final random = Random();
              final namaWarung = "Warung ${random.nextInt(1000)}";
              final namaPemilik = "Pemilik ${random.nextInt(1000)}";
              final idWarung = "ID-${random.nextInt(10000)}";

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {
                    Next.to(context, const StoreDetail());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          spreadRadius: 0.1,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.primaries[
                                  random.nextInt(Colors.primaries.length)],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextH3(
                                    text: namaWarung,
                                    fontWeight: FontWeight.w600),
                                TextNormal(
                                    text: namaPemilik,
                                    fontWeight: FontWeight.w500),
                                TextNormal(
                                    text: idWarung,
                                    fontWeight: FontWeight.w600),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            color: Colors.white,
                            icon: const Icon(Icons.more_vert,
                                color: Colors.black, size: 35),
                            onSelected: (String value) {
                              if (value == 'edit') {
                                // Tambahkan logika untuk edit
                                print('Edit warung: $namaWarung');
                              } else if (value == 'delete') {
                                // Tambahkan logika untuk hapus
                                print('Hapus warung: $namaWarung');
                              }
                            },
                            itemBuilder: (BuildContext context) => [
                              const PopupMenuItem<String>(
                                value: 'Tandai',
                                child: Row(
                                  children: [
                                    Icon(Icons.check, color: Colors.green),
                                    SizedBox(width: 8),
                                    Text('Tandai'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    Icon(Icons.edit, color: Colors.yellow),
                                    SizedBox(width: 8),
                                    Text('Edit'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem<String>(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: Colors.red),
                                    SizedBox(width: 8),
                                    Text('Hapus'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
