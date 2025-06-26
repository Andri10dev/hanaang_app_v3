import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/features/orders/pre_order/card.dart';
import 'package:hanaang_app/features/orders/pre_order/scan_qr_code.dart';
import 'package:hanaang_app/models/pre_order_param_model.dart';
import 'package:hanaang_app/providers/orders/pre_order/nav_pre_order_provider.dart';
import 'package:hanaang_app/providers/orders/pre_order/pre_order_provider.dart';
import 'package:hanaang_app/utilities/custom_color.dart';
import 'package:hanaang_app/utilities/next_to.dart';

class Antrian extends ConsumerWidget {
  const Antrian({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedIndex = ref.watch(navPreOrderProvider);
    String status = ref.watch(statusPoProvider);

    String keyword = "";
    int page = 1;
    final params = PreOrderParams(
      buyer: 'false',
      page: page,
      keyword: keyword,
      status: status,
    );

    final getData = ref.watch(getPreOrderProvider(params));
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const CustomBgAppBar(),
        centerTitle: true,
        title: const TextH2(
          text: "Antrian",
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
            ),
            onPressed: () {
              // Next.to(context, const ScanerQrCodePreOrder());
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              // Tambahkan aksi ketika tombol ditekan
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(getPreOrderProvider);
          await ref.read(getPreOrderProvider(params).future);
        },
        child: getData.when(
            data: (data) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) => Column(
                            children: [
                              PreOrderCard(
                                data: data[index],
                              ),
                              const SizedBox(
                                height: 15,
                              )
                            ],
                          )),
                ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => SingleChildScrollView(
                child: Center(child: Text('Error: $err')))),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: myColors.yellow,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[700],
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: (index) {
          String newStatus;
          switch (index) {
            case 0:
              newStatus = 'semua';
              break;
            case 1:
              newStatus = 'menunggu';
              break;
            case 2:
              newStatus = 'dalam proses';
              break;
            case 3:
              newStatus = 'selesai';
              break;
            case 4:
              newStatus = 'dibatalkan';
              break;
            default:
              newStatus = 'semua';
              break;
          }
          ref.read(navPreOrderProvider.notifier).setIndex(index);
          ref.read(statusPoProvider.notifier).state = newStatus;
          ref.invalidate(getPreOrderProvider);
        },
        items: [
          BottomNavigationBarItem(
            icon: _buildNavIcon(
                "assets/icons/ic_status_menunggu.png", selectedIndex, 0),
            label: 'Semua',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Menunggu',
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(
                "assets/icons/ic_status_dalam_proses.png", selectedIndex, 2),
            label: 'Dalam Proses',
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(
                "assets/icons/ic_status_selesai.png", selectedIndex, 3),
            label: 'Selesai',
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(
                "assets/icons/ic_status_dibatalkan.png", selectedIndex, 4),
            label: 'Dibatalkan',
          ),
        ],
      ),
    );
  }

  Widget _buildNavIcon(String asset, int selectedIndex, int index) {
    if (selectedIndex == index) {
      // selected: tampilkan normal
      return Image.asset(asset, height: 24);
    } else {
      // unselected: invers
      return ColorFiltered(
        colorFilter: const ColorFilter.matrix([
          -1,
          0,
          0,
          0,
          255,
          0,
          -1,
          0,
          0,
          255,
          0,
          0,
          -1,
          0,
          255,
          0,
          0,
          0,
          1,
          0,
        ]),
        child: Image.asset(asset, height: 24),
      );
    }
  }
}
