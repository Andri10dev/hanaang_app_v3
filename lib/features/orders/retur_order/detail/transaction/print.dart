import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/models/retur_transaction_model.dart';
import 'package:intl/intl.dart';

class PrintReturTransaction extends StatefulWidget {
  final ReturTransactionModel data;
  const PrintReturTransaction({super.key, required this.data});

  @override
  State<PrintReturTransaction> createState() => _PrintReturTransactionState();
}

class _PrintReturTransactionState extends State<PrintReturTransaction> {
  final _printer = FlutterThermalPrinter.instance;
  List<Printer> printers = [];
  StreamSubscription<List<Printer>>? _devicesStreamSubscription;
  bool _isScanning = false;
  Timer? _scanTimer;
  Set<String> _connectingPrinters = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => startScan());
  }

  @override
  void dispose() {
    _devicesStreamSubscription?.cancel();
    _scanTimer?.cancel();
    super.dispose();
  }

  void startScan() async {
    if (_isScanning) return;

    setState(() {
      _isScanning = true;
    });

    _devicesStreamSubscription?.cancel();
    _scanTimer?.cancel();

    await _printer.getPrinters(connectionTypes: [ConnectionType.BLE]);
    _devicesStreamSubscription = _printer.devicesStream.listen((event) {
      setState(() {
        printers = event.where((e) => e.name?.isNotEmpty == true).toList();
      });
    });

    // Set timer untuk 30 detik
    _scanTimer = Timer(const Duration(seconds: 30), () {
      stopScan();
    });
  }

  void stopScan() {
    _printer.stopScan();
    _devicesStreamSubscription?.cancel();
    _scanTimer?.cancel();
    setState(() {
      _isScanning = false;
    });
  }

  Future<void> toggleConnection(Printer printer) async {
    final printerId = printer.name ?? 'unknown';

    if (printer.isConnected == true) {
      await _printer.disconnect(printer);
      printer.isConnected = false;
    } else {
      setState(() {
        _connectingPrinters.add(printerId);
      });

      try {
        printer.isConnected = await _printer.connect(printer);
      } finally {
        setState(() {
          _connectingPrinters.remove(printerId);
        });
      }
    }
    setState(() {});
  }

  Future<void> printReceipt(Printer printer) async {
    await _printer.printWidget(
      context,
      paperSize: PaperSize.mm58,
      printer: printer,
      printOnBle: true,
      widget: _buildPrintUi(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const CustomBgAppBar(),
        centerTitle: true,
        title: const TextH2(
          text: "Detail Transaksi Retur",
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Bluetooth', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isScanning ? null : startScan,
                    child: _isScanning
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                              SizedBox(width: 8),
                              Text('Scanning...'),
                            ],
                          )
                        : const Text('Get Printers'),
                  ),
                ),
                const SizedBox(width: 22),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isScanning ? stopScan : null,
                    child: const Text('Stop Scan'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: printers.length,
                itemBuilder: (context, index) {
                  final printer = printers[index];
                  final printerId = printer.name ?? 'unknown';
                  final isConnecting = _connectingPrinters.contains(printerId);

                  return ListTile(
                    onTap:
                        isConnecting ? null : () => toggleConnection(printer),
                    title: Text(printer.name ?? 'No Name'),
                    subtitle: isConnecting
                        ? const Row(
                            children: [
                              SizedBox(
                                width: 12,
                                height: 12,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                              SizedBox(width: 8),
                              Text('Menghubungkan...'),
                            ],
                          )
                        : Text("Connected: ${printer.isConnected}"),
                    trailing: IconButton(
                      icon: Icon(Icons.connect_without_contact,
                          color: printer.isConnected == true
                              ? Colors.green
                              : Colors.red),
                      onPressed: printer.isConnected == true
                          ? () => printReceipt(printer)
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // final width = 185;
  final double width = 145;

  Widget _buildPrintUi() {
    final data = widget.data;
    final dateFormat = DateFormat("dd-MM-yyyy");
    final timeFormat = DateFormat("HH:mm");
    final dayFormat = DateFormat.EEEE('id_ID');
    final double sHeight = 8;
    return SizedBox(
      width: width,
      child: Material(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLogo(),
            _buildHeader("Teh Tarik Hanaang", alignment: Alignment.center),
            _buildRow("Tanggal",
                "${dayFormat.format(data.createdAt)}, ${dateFormat.format(data.createdAt)}"),
            _buildRow("Jam", "${timeFormat.format(data.createdAt)} WIB"),
            SizedBox(height: sHeight),
            _buildHeader("Transaksi Retur :", alignment: Alignment.centerLeft),
            _buildRow("No Retur", data.returOrder.returNumber),
            _buildRow("Kode Transaksi", data.code),
            _buildRow("Nama Admin", data.admin.name),
            SizedBox(height: sHeight),
            _buildHeader("Pengambilan Produk :"),
            _buildRow("Belum Diambil", "${data.notTakenYet} Cup"),
            _buildRow("Jumlah Pengambilan", "${data.quantity} Cup"),
            _buildDivider(),
            _buildRow("Sisa Pengambilan", "${data.remainingTake} Cup"),
            SizedBox(height: sHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() => Center(
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            image: const DecorationImage(
              image: AssetImage("assets/images/logo_hanaang.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  Widget _buildHeader(String text, {Alignment? alignment}) => Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 3),
        width: width,
        color: Colors.black,
        child: Align(
          alignment: alignment ?? Alignment.centerLeft,
          child: _buildTextRow(text,
              color: Colors.white, textAlign: TextAlign.center),
        ),
      );

  Widget _buildDivider() => Container(
        height: 1,
        width: width,
        color: Colors.black,
      );

  Widget _buildRow(String name, String value) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTextRow(name),
          _buildTextRow(value, textAlign: TextAlign.right),
        ],
      );

  Widget _buildTextRow(
    String value, {
    // double fontSize = 8,
    double fontSize = 6,
    TextAlign textAlign = TextAlign.left,
    Color color = Colors.black,
  }) =>
      Text(
        value,
        style: TextStyle(
            fontSize: fontSize, fontWeight: FontWeight.bold, color: color),
        textAlign: textAlign,
      );
}
