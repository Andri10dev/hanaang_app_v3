import 'package:flutter/material.dart';
import 'package:hanaang_app/utilities/min_width.dart';

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
    return Text(text,
        style: TextStyle(
            fontSize: screenWidth >= MinWidth.xs
                ? 16
                : screenWidth >= MinWidth.sm
                    ? 18
                    : screenWidth >= MinWidth.md
                        ? 20
                        : 14,
            color: color,
            fontWeight: fontWeight),
        textAlign: textAlign);
  }
}
