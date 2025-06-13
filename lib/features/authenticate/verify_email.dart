import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/forms/input_default.dart';
import 'package:hanaang_app/components/texts/h1.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/providers/form.dart';
import 'package:hanaang_app/utilities/custom_color.dart';

class VerifyEmail extends ConsumerWidget {
  VerifyEmail({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formProvider);
    final form = ref.read(formProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: CustomBgAppBar(),
        centerTitle: true,
        title: TextH2(
          text: "Verify Email",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        leading: IconButton(
          icon: Icon(
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
                  "assets/icons/ic_email.png",
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: TextH1(
                  text: "Verifikasi Email",
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextNormal(
                text:
                    "Silahkan masukan kode verifikasi yang baru saja kami kirim ke alamat email Anda..!",
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 20,
              ),
              InputDefault(
                label: 'Nama Lengkap',
                showLabel: false,
                hintText: 'Masukkan nama lengkap',
                controller: emailController,
                errorText: formState.emailError,
                keyboardType: TextInputType.text,
                onChanged: form.updateEmail,
              ),
              SizedBox(
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
                  "Verifikasi",
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
              TextNormal(text: "Kode berlaku dalam 03.00"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextNormal(
                    text: "Tidak mendapatkan kode ?",
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: TextNormal(
                      text: "Kirim Ulang",
                      fontWeight: FontWeight.bold,
                      color: myColors.yellow,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
