import 'package:flutter/material.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/features/orders/order/detail.dart';
import 'package:hanaang_app/features/sales/agen/invite_agen.dart';
import 'package:hanaang_app/utilities/next_to.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class OrderScaner extends StatefulWidget {
  const OrderScaner({super.key});

  @override
  State<OrderScaner> createState() => _OrderScanerState();
}

class _OrderScanerState extends State<OrderScaner> {
  final MobileScannerController _controller = MobileScannerController();
  bool hasScanned = false;
  Barcode? _barcode;
  Barcode? _barcodeRaw;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.start();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hasScanned == true) {
      _barcode = null;
      _controller.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: CustomBgAppBar(),
        centerTitle: true,
        title: TextH2(
          text: "Cari Order",
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
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: MobileScanner(
              controller: _controller,
              onDetect: (barcode) {
                // if (!hasScanned && barcode.raw != null) {
                _barcodeRaw = barcode.barcodes.firstOrNull;
                if (!hasScanned && _barcodeRaw != null) {
                  _barcode = barcode.barcodes.firstOrNull;

                  hasScanned = true;
                  // ⛔ hentikan scanner
                  // _controller.pause();

                  Next.to(context,
                      OrderDetail(orderNumber: _barcode?.displayValue ?? ""));

                  // lakukan sesuatu dengan hasil scan
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Scan berhasil:${_barcode!.displayValue}')),
                  );

                  //   // contoh: kembali ke halaman sebelumnya
                  //   Future.delayed(Duration(milliseconds: 500), () {
                  //     Navigator.pop(context, code);
                  //   });
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Arahkan kamera ke QR Code',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Raw Value: ${_barcodeRaw?.displayValue}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      hasScanned = false;
                      _barcode = null;
                    });
                    _controller.start();
                  },
                  icon: Icon(Icons.refresh),
                  label: Text('Scan Ulang'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
