import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/custom_header.dart';
import 'package:hanaang_app/components/forms/input_default.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/features/authenticate/login.dart';
import 'package:hanaang_app/features/authenticate/verify_email.dart';
import 'package:hanaang_app/providers/form.dart';
import 'package:hanaang_app/utilities/custom_color.dart';
import 'package:hanaang_app/utilities/next_to.dart';

class Register extends ConsumerWidget {
  Register({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formProvider);
    final form = ref.read(formProvider.notifier);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          CustomHeader(
            title: "Register Hanaang App",
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  TextH2(
                    text: "Teh Tarik Hanaang",
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputDefault(
                    label: 'Nama Lengkap',
                    hintText: 'Masukkan nama lengkap',
                    controller: emailController,
                    errorText: formState.emailError,
                    keyboardType: TextInputType.text,
                    onChanged: form.updateEmail,
                  ),
                  InputDefault(
                    label: 'Email',
                    hintText: 'Masukkan email',
                    controller: emailController,
                    errorText: formState.emailError,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: form.updateEmail,
                  ),
                  InputDefault(
                    label: 'No Telp / WA',
                    hintText: 'Masukkan no telp / wa',
                    controller: emailController,
                    errorText: formState.emailError,
                    keyboardType: TextInputType.phone,
                    onChanged: form.updateEmail,
                  ),
                  InputDefault(
                    label: 'Password',
                    hintText: 'Masukkan password',
                    controller: passwordController,
                    errorText: formState.passwordError,
                    isPassword: true,
                    onChanged: form.updatePassword,
                  ),
                  InputDefault(
                    label: 'Konfirmasi Password',
                    hintText: 'Konfirmasi password',
                    controller: passwordController,
                    errorText: formState.passwordError,
                    isPassword: true,
                    onChanged: form.updatePassword,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: TextNormal(
                        text: "Setuju dengan syarat & ketentuan",
                        fontWeight: FontWeight.bold,
                        color: myColors.yellow,
                      ),
                      onPressed: () {
                        // kirim data ke backend atau proses login
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login berhasil")),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Next.to(context, VerifyEmail());
                      final isValid = form.validate();
                      if (isValid) {
                        // kirim data ke backend atau proses login
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login berhasil")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: myColors.yellow,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Daftar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextNormal(
                        text: "Sudah punya akun ?",
                      ),
                      TextButton(
                        onPressed: () {
                          Next.to(context, Login());
                        },
                        child: TextNormal(
                          text: "Masuk disini",
                          fontWeight: FontWeight.bold,
                          color: myColors.yellow,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "assets/images/form_image.png",
                  ),
                ],
              )),
        ],
      ),
    ));
  }
}
