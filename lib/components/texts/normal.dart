import 'package:flutter/material.dart';
import 'package:hanaang_app/utilities/min_width.dart';

class TextNormal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  const TextNormal(
      {super.key,
      required this.text,
      this.color = Colors.black,
      this.fontWeight = FontWeight.normal,
      this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Text(
      text,
      style: TextStyle(
        fontSize: screenWidth >= MinWidth.xs
            ? 12
            : screenWidth >= MinWidth.sm
                ? 14
                : screenWidth >= MinWidth.md
                    ? 16
                    : 10,
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}
