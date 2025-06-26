import 'package:flutter/material.dart';

class BuildBtnOpenPreOrder extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final Widget? child;

  const BuildBtnOpenPreOrder({
    Key? key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    this.borderColor,
    this.onPressed,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: borderColor != null ? BorderSide(color: borderColor!) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: child ??
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
    );
  }
}
