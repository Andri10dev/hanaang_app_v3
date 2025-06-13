import 'package:flutter/material.dart';

Widget BuildBtnOpenPreOrder({
  required String text,
  required Color textColor,
  required Color backgroundColor,
  Color? borderColor,
  required VoidCallback onPressed,
}) {
  return Container(
    width: 125,
    decoration: BoxDecoration(
      color: backgroundColor,
      border: Border.all(color: borderColor ?? backgroundColor, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
