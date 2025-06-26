import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/features/account/index.dart';
import 'package:hanaang_app/features/home/index.dart';
import 'package:hanaang_app/features/orders/index.dart';
import 'package:hanaang_app/features/sales/index.dart';
import 'package:hanaang_app/utilities/custom_color.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);
    final screenPages = [
      const Home(),
      const OrderMenu(),
      const SalesMenu(),
      const Account(),
    ];

    return Scaffold(
      body: screenPages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: myColors.yellow,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[800],
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: (index) => ref.read(navigationProvider.notifier).setIndex(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: 'Penjualan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}

final navigationProvider =
    StateNotifierProvider<NavigationController, int>((ref) {
  return NavigationController();
});

class NavigationController extends StateNotifier<int> {
  NavigationController() : super(0);

  void setIndex(int index) {
    state = index;
  }
}
