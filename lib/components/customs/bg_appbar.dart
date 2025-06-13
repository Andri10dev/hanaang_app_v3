import 'package:flutter/material.dart';
import 'package:hanaang_app/utilities/custom_color.dart';

class CustomBgAppBar extends StatelessWidget {
  const CustomBgAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            myColors.orange,
            myColors.yellow,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }
}
