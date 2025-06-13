import 'package:flutter/material.dart';

Widget BuildRowOpenPreOrder(String title, String value, {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value,
            style:
                isBold ? const TextStyle(fontWeight: FontWeight.bold) : null),
      ],
    ),
  );
}
