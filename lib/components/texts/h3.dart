import 'package:flutter/material.dart';

class TextH3 extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int? maxLine;
  final TextOverflow? textOverflow;
  const TextH3({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.start,
    this.maxLine = null,
    this.textOverflow = TextOverflow.visible,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double getResponsiveFontSize(double screenWidth) {
      if (screenWidth >= 412) return 18; // tablet
      if (screenWidth >= 390) return 16; // tablet
      if (screenWidth >= 360) return 14; // besar
      if (screenWidth >= 320) return 12; // sedang
      return 10; // kecil
    }

    return Text(text,
        softWrap: true,
        overflow: textOverflow,
        maxLines: maxLine,
        style: TextStyle(
            fontSize: getResponsiveFontSize(screenWidth),
            color: color,
            fontWeight: fontWeight),
        textAlign: textAlign);
  }
}
