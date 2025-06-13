import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class BuildQrCode extends StatelessWidget {
  final String value;
  final double? width;
  const BuildQrCode({super.key, required this.value, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 250,
      height: width ?? 250,
      child: PrettyQrView.data(
          data: value,
          decoration: const PrettyQrDecoration(
            image: PrettyQrDecorationImage(
              image: AssetImage('assets/images/logo_hanaang.png'),
            ),
            quietZone: PrettyQrQuietZone.zero,
          ),
          errorCorrectLevel: QrErrorCorrectLevel.Q),
    );
  }
}
