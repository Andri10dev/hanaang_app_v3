import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/customs/btn_default.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/features/orders/pre_order/detail/index.dart';
import 'package:hanaang_app/providers/orders/pre_order_provider.dart';
import 'package:hanaang_app/utilities/next_to.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerAgenStateNotifier extends StateNotifier<bool> {
  ScannerAgenStateNotifier() : super(false);
  void startScanning() {
    state = true;
  }

  void stopScanning() {
    state = false;
  }
}

final ScannerAgenStateProvider =
    StateNotifierProvider<ScannerAgenStateNotifier, bool>((ref) {
  return ScannerAgenStateNotifier();
});

class ScanerQrCodeAgen extends ConsumerStatefulWidget {
  const ScanerQrCodeAgen({super.key});

  @override
  ConsumerState<ScanerQrCodeAgen> createState() => _ScanerQrCodeAgenState();
}

class _ScanerQrCodeAgenState extends ConsumerState<ScanerQrCodeAgen> {
  late MobileScannerController _controller = MobileScannerController();
  bool _hasScanned = false;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onBarcodeDetect(BarcodeCapture barcodeCapture) async {
    if (_hasScanned) return; // ignore if already scanned

    final barcodes = barcodeCapture.barcodes;
    if (barcodes.isEmpty) return;

    final barcode = barcodes.first;
    if (barcode.rawValue == null || barcode.rawValue!.isEmpty) return;

    setState(() {
      _controller.pause();
      _hasScanned = true;
    });
    if (barcode.displayValue != null) {
      final showPreOrder =
          ref.watch(showPreOrderProvider(barcode.displayValue!));
      if (showPreOrder.hasValue) {
        Next.to(context, PreOrderDetail(poNumber: barcode.displayValue ?? ''));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: TextNormal(
              text: 'Data ditemukan..!',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: TextNormal(
                text: 'Qr Code tidak valid..!',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasScanned == true) {
      setState(() {
        _hasScanned = false;
        _controller.start();
      });
    }

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: CustomBgAppBar(),
        centerTitle: true,
        title: TextH2(
          text: "Scan Qr Code Pre Order",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                    minWidth: 300,
                    minHeight: 400,
                  ),
                  child: MobileScanner(
                      controller: _controller, onDetect: _onBarcodeDetect),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              BtnDefault(
                  name: "Ganti Kamera",
                  onTap: () {
                    _controller.switchCamera();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
