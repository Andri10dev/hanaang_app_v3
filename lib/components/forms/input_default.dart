import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/providers/input.dart';
import 'package:hanaang_app/utilities/custom_color.dart';

class InputDefault extends ConsumerWidget {
  final String label;
  final String hintText;
  final String? errorText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool showLabel;
  final void Function(String) onChanged;

  const InputDefault({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isObscured =
        isPassword ? !ref.watch(passwordVisibilityProvider) : false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          obscureText: isObscured,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText,
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isObscured ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      ref.read(passwordVisibilityProvider.notifier).toggle();
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 2,
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 2,
                color: myColors.yellow,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
