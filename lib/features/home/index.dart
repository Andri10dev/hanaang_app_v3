import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/custom_header.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/texts/h1.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/features/home/banks/index.dart';
import 'package:hanaang_app/features/home/sections/banners/index.dart';
import 'package:hanaang_app/features/home/sections/open_pre_order/index.dart';
import 'package:hanaang_app/providers/auths/local_storage_provider.dart';
import 'package:hanaang_app/providers/finance/bonus_provider.dart';
import 'package:hanaang_app/providers/finance/cashback_provider.dart';
import 'package:hanaang_app/providers/finance/price_provider.dart';
import 'package:hanaang_app/providers/general/banner_provider.dart';
import 'package:hanaang_app/providers/orders/open_po_provider.dart';
import 'package:hanaang_app/utilities/next_to.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  String? userRole;
  bool loading = false;

  Future<void> _loadStorage() async {
    setState(() {
      loading = true;
    });

    final getUserRole = ref.read(getUserRoleProvider);

    setState(() {
      loading = false;
    });
  }

  bool refresh = false;

  Future<void> _onRefresh() async {
    setState(() {
      refresh = true;
    });

    await _loadStorage();

    // Refresh data banner dan pre-order
    ref.invalidate(getBanner);
    ref.invalidate(getOpenPreOrderProvider);
    ref.invalidate(getPrice);
    ref.invalidate(getBonus);
    ref.invalidate(getCashback);

    // Tunggu sampai data baru selesai dimuat
    await Future.wait([
      ref.read(getBanner.future),
      ref.read(getOpenPreOrderProvider.future),
      ref.read(getPrice.future),
      ref.read(getBonus.future),
      ref.read(getCashback.future),
    ]);

    setState(() {
      refresh = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const CustomBgAppBar(),
        centerTitle: true,
        title: const TextH1(
          text: "Hanaang App",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView(
          children: [
            const CustomHeader(),
            const SizedBox(
              height: 15,
            ),
            if (loading)
              Container(
                padding: const EdgeInsets.all(20),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else ...[
              if (refresh)
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              BannerSection(
                userRole: userRole.toString(),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    ["super admin", "admin"].contains(userRole ?? "")
                        ? Container(
                            width: double.infinity,
                            height: 125,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildFinanceButton(
                                    label: "Pengeluaran",
                                    amount: "Rp. 2000.000.000",
                                    onTap: () {
                                      Next.to(context, const BankMenu());
                                    },
                                  ),
                                ),
                                Container(
                                  width: 2,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                Expanded(
                                  child: _buildFinanceButton(
                                    label: "Pemasukan",
                                    amount: "Rp. 2000.000.000",
                                    onTap: () {
                                      Next.to(context, const BankMenu());
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    if (refresh)
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    OpenPreOrderSection(
                      userRole: userRole.toString(),
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
            ],
          ],
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

  Widget _buildFinanceButton({
    required String label,
    required String amount,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextNormal(
              text: label,
              fontWeight: FontWeight.w500,
            ),
            TextH2(
              text: amount,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
