import 'package:flutter/material.dart';
import 'package:hanaang_app/components/customs/loading_indicator.dart';
import 'package:hanaang_app/components/texts/h3.dart';
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
        minimumSize: Size(double.infinity, 50),
        maximumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: loading == true
          ? CustomLoadingIndicator()
          : TextH3(
              text: name,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
    );
  }
}
