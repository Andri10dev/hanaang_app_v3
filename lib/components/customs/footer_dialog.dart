import 'package:flutter/material.dart';
import 'package:hanaang_app/utilities/custom_color.dart';

class FooterDialog extends StatelessWidget {
  const FooterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: myColors.yellow,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: const Center(
        child: Text(
          'Hanaang App',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
