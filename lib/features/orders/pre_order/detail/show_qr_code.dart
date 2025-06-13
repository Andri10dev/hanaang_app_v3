import 'package:flutter/material.dart';
import 'package:hanaang_app/components/customs/build_qr_code.dart';
import 'package:hanaang_app/components/customs/footer_dialog.dart';
import 'package:hanaang_app/components/customs/header_dialog.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/models/user_model.dart';

void ShowQRCodePreOrder(
  BuildContext context,
  String poNumber,
  UserModel user,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const HeaderDialog(title: 'QR Code Pre Order'),
              Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                child: BuildQrCode(value: poNumber),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextH2(
                  text: '${user.name}',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const FooterDialog()
            ],
          ),
        ),
      );
    },
  );
}
