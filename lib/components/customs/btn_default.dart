import 'package:flutter/material.dart';
import 'package:hanaang_app/components/customs/loading_indicator.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/utilities/custom_color.dart';

class BtnDefault extends StatelessWidget {
  final String name;
  final bool? loading;
  final VoidCallback onTap;
  final Color? color;
  const BtnDefault(
      {super.key,
      required this.name,
      this.loading = false,
      this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? myColors.yellow,
        minimumSize: const Size(double.infinity, 40),
        maximumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: loading == true
          ? CustomLoadingIndicator()
          : TextNormal(
              text: name,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
    );
  }
}
