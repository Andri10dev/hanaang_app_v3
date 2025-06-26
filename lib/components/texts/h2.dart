import 'package:flutter/material.dart';

class TextH2 extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  const TextH2(
      {super.key,
      required this.text,
      this.color = Colors.black,
      this.fontWeight = FontWeight.normal,
      this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double getResponsiveFontSize(double screenWidth) {
      if (screenWidth >= 412) return 20; // tablet
      if (screenWidth >= 390) return 18; // tablet
      if (screenWidth >= 360) return 16; // besar
      if (screenWidth >= 320) return 14; // sedang
      return 10; // kecil
    }

    return Text(text,
        style: TextStyle(
            fontSize: getResponsiveFontSize(screenWidth),
            color: color,
            fontWeight: fontWeight),
        textAlign: textAlign);
  }
}
