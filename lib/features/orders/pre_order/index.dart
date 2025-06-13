import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/features/orders/pre_order/card.dart';
import 'package:hanaang_app/features/orders/pre_order/scan_qr_code.dart';
import 'package:hanaang_app/providers/orders/pre_order_provider.dart';
import 'package:hanaang_app/utilities/next_to.dart';

class PreOrder extends ConsumerWidget {
  const PreOrder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, dynamic> params = {
      "buyer": false,
    };
    final getData = ref.watch(getPreOrderProvider(params));
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: CustomBgAppBar(),
          centerTitle: true,
          title: TextH2(
            text: "Pre Order",
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          leading: IconButton(
            icon: Icon(
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
                Icons.qr_code_scanner,
                color: Colors.white,
              ),
              onPressed: () {
                Next.to(context, ScanerQrCodePreOrder());
              },
            ),
            IconButton(
              icon: Icon(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) => Column(
                              children: [
                                PreOrderCard(
                                  data: data[index],
                                ),
                                SizedBox(
                                  height: 15,
                                )
                              ],
                            )),
                  ),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err'))),
        ));
  }
}
