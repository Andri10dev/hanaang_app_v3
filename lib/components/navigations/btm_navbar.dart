import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/features/account/index.dart';
import 'package:hanaang_app/features/home/index.dart';
import 'package:hanaang_app/features/orders/index.dart';
import 'package:hanaang_app/features/sales/index.dart';
import 'package:hanaang_app/utilities/custom_color.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class BtmNavbar extends ConsumerStatefulWidget {
  const BtmNavbar({super.key});

  @override
  ConsumerState<BtmNavbar> createState() => _BtmNavbarState();
}

class _BtmNavbarState extends ConsumerState<BtmNavbar> {
  int selectedIndex = 0;

  final screenPages = [
    const Home(),
    const OrderMenu(),
    const SalesMenu(),
    const Account(),
  ];

  void changeTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  late PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: screenPages,
      ),
      bottomNavigationBar: WaterDropNavBar(
        waterDropColor: Colors.white,
        backgroundColor: myColors.yellow,
        bottomPadding: 10,
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
          pageController.animateToPage(selectedIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutQuad);
        },
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(
            filledIcon: Icons.home,
            outlinedIcon: Icons.home_outlined,
          ),
          BarItem(
              filledIcon: Icons.checklist_outlined,
              outlinedIcon: Icons.checklist_rtl),
          BarItem(filledIcon: Icons.sell, outlinedIcon: Icons.sell_outlined),
          BarItem(filledIcon: Icons.person, outlinedIcon: Icons.person_outline),
        ],
      ),
    );
  }
}
