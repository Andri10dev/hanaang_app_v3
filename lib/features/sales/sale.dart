import 'package:flutter/material.dart';
import 'package:hanaang_app/components/custom_header.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          CustomHeader(),
        ],
      ),
    ));
  }
}
