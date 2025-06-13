import 'package:flutter/material.dart';

class Next {
  // Method untuk navigasi ke halaman baru
  static void to(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Method untuk navigasi dan mengganti halaman saat ini
  static void replace(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Method untuk kembali ke halaman sebelumnya
  static void back(BuildContext context) {
    Navigator.pop(context);
  }

  // Method untuk navigasi ke halaman baru dan menghapus semua route sebelumnya
  static void toAndRemoveUntil(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }
}
