import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/forms/input_default.dart';
import 'package:hanaang_app/components/texts/h1.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/providers/form.dart';
import 'package:hanaang_app/utilities/custom_color.dart';

class NewPassword extends ConsumerWidget {
  NewPassword({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formProvider);
    final form = ref.read(formProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const CustomBgAppBar(),
        centerTitle: true,
        title: const TextH2(
          text: "Buat Password Baru",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 275,
                child: Image.asset(
                  "assets/icons/ic_new_password.png",
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: TextH1(
                  text: "Buat Password Baru",
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const TextNormal(
                text:
                    "Untuk keamanan maksimal, kata sandi baru Anda tidak boleh sama dengan yang pernah digunakan sebelumnya. Ciptakan kata sandi baru yang unik dan siap menjaga akun Anda! ",
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
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
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
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
                  "Simpan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
