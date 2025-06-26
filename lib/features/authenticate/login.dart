// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hanaang_app/components/custom_header.dart';
// import 'package:hanaang_app/components/customs/loading_indicator.dart';
// import 'package:hanaang_app/components/forms/input_default.dart';
// import 'package:hanaang_app/components/navigations/bottom_navigation.dart';
// import 'package:hanaang_app/components/texts/h2.dart';
// import 'package:hanaang_app/components/texts/normal.dart';
// import 'package:hanaang_app/features/authenticate/forgot_password.dart';
// import 'package:hanaang_app/features/authenticate/register.dart';
// import 'package:hanaang_app/models/user_login_model.dart';
// import 'package:hanaang_app/providers/auths/auth_provider.dart';
// import 'package:hanaang_app/providers/auths/local_storage_provider.dart';
// import 'package:hanaang_app/providers/form.dart';
// import 'package:hanaang_app/providers/general/banner_provider.dart';
// import 'package:hanaang_app/providers/orders/open_po_provider.dart';
// import 'package:hanaang_app/providers/orders/order_provider.dart';
// import 'package:hanaang_app/providers/orders/pre_order/pre_order_provider.dart';
// import 'package:hanaang_app/providers/orders/retur_order_provider.dart';
// import 'package:hanaang_app/utilities/custom_color.dart';
// import 'package:hanaang_app/utilities/next_to.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:hanaang_app/providers/auths/data_refresh_provider.dart';

// class Login extends ConsumerStatefulWidget {
//   const Login({super.key});

//   @override
//   ConsumerState<Login> createState() => _LoginState();
// }

// class _LoginState extends ConsumerState<Login> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   void saveUserData(UserLoginModel userData) async {
//     final prefs = await SharedPreferences.getInstance();

//     final uniqueId = userData.user.uniqueId;
//     final name = userData.user.name;
//     final email = userData.user.email;
//     final phone = userData.user.phoneNumber ?? "";
//     final userRole = userData.user.role;
//     final token = userData.accessToken;

//     await prefs.setString("unique_id-hanaang_app", uniqueId);
//     await prefs.setString("name-hanaang_app", name);
//     await prefs.setString("email-hanaang_app", email);
//     await prefs.setString("phone_number-hanaang_app", phone);
//     await prefs.setString("user_role-hanaang_app", userRole);
//     await prefs.setString("token-hanaang_app", token);
//   }

//   bool loading = false;

//   void handleLogin() async {
//     final email = emailController.text;
//     final password = passwordController.text;

//     setState(() {
//       loading = true;
//     });

//     await ref.read(authStateProvider.notifier).login(email, password);

//     final loginState = ref.read(authStateProvider);
//     loginState.when(data: (data) {
//       setState(() {
//         loading = false;
//       });
//       if (data.isNotEmpty) {
//         final newData = UserLoginModel.fromJson(data["data"]);
//         saveUserData(newData);

//         setState(() {
//           ref.read(dataRefreshProvider.notifier).refreshAllData();
//         });

//         ScaffoldMessenger.of(context)
//             .showSnackBar(const SnackBar(content: Text("Login berhasil!")));
//         Next.to(context, const BottomNavBar());
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Email atau password salah")));
//       }
//     }, loading: () {
//       setState(() {
//         loading = true;
//       });
//     }, error: (e, _) {
//       setState(() {
//         loading = false;
//       });
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text("Terjadi kesalahan")));
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     emailController.text = "distributor@gmail.com";
//     passwordController.text = "Hanaang123!@";
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ref = context as WidgetRef;
//     final formState = ref.watch(formProvider);
//     final form = ref.read(formProvider.notifier);

//     // final loginState = ref.watch(authStateProvider);

//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Column(
//         children: [
//           const CustomHeader(
//             title: "Login Hanaang App",
//           ),
//           Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//               child: Column(
//                 children: [
//                   const TextH2(
//                     text: "Teh Tarik Hanaang",
//                     fontWeight: FontWeight.bold,
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   InputDefault(
//                     label: 'Email',
//                     hintText: 'Masukkan email',
//                     controller: emailController,
//                     errorText: formState.emailError,
//                     keyboardType: TextInputType.emailAddress,
//                     onChanged: form.updateEmail,
//                   ),
//                   InputDefault(
//                     label: 'Password',
//                     hintText: 'Masukkan password',
//                     controller: passwordController,
//                     errorText: formState.passwordError,
//                     isPassword: true,
//                     onChanged: form.updatePassword,
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       child: const TextNormal(
//                         text: "Lupa password ?",
//                         fontWeight: FontWeight.bold,
//                         color: myColors.yellow,
//                       ),
//                       onPressed: () {
//                         Next.to(context, ForgotPassword());
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   ElevatedButton(
//                     onPressed: handleLogin,
//                     // onPressed: () {
//                     //   Next.to(context, BottomNavBar());
//                     //   final isValid = form.validate();
//                     //   if (isValid) {
//                     //     // kirim data ke backend atau proses login
//                     //     ScaffoldMessenger.of(context).showSnackBar(
//                     //       const SnackBar(content: Text("Login berhasil")),
//                     //     );
//                     //   }
//                     // },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: myColors.yellow,
//                       minimumSize: const Size(double.infinity, 50),
//                       maximumSize: const Size(double.infinity, 50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: loading
//                         ? CustomLoadingIndicator()
//                         : const Text(
//                             "Masuk",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const TextNormal(
//                         text: "Belum punya akun ?",
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Next.to(context, Register());
//                         },
//                         child: const TextNormal(
//                           text: "Daftar disini",
//                           fontWeight: FontWeight.bold,
//                           color: myColors.yellow,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Image.asset(
//                     "assets/images/form_image.png",
//                   ),
//                 ],
//               )),
//         ],
//       ),
//     ));
//   }

//   // Tambahkan method untuk refresh semua data
//   void _refreshAllData(WidgetRef ref) {
//     // Refresh banner data
//     ref.invalidate(getBanner);

//     // Refresh open pre order data
//     ref.invalidate(getOpenPreOrderProvider);

//     // Refresh order data
//     ref.invalidate(getOrderProvider);

//     // Refresh pre order data (untuk berbagai role)
//     ref.invalidate(getPreOrderProvider); // untuk semua role

//     // Refresh retur order data
//     ref.invalidate(getReturOrderProvider);
//     ref.invalidate(sharedPreferencesProvider);
//     ref.invalidate(getImageProvider);
//     ref.invalidate(getNameProvider);
//     ref.invalidate(getEmailProvider);
//     ref.invalidate(getPhoneNumberProvider);
//     ref.invalidate(getUserRoleProvider);
//     ref.invalidate(getUniqueIdProvider);
//     ref.invalidate(getTokenProvider);

//     // Refresh order transaction data (jika ada)
//     // ref.invalidate(getOrderTransactionProvider);

//     // Refresh retur transaction data (jika ada)
//     // ref.invalidate(getReturTransactionProvider);
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/custom_header.dart';
import 'package:hanaang_app/components/customs/loading_indicator.dart';
import 'package:hanaang_app/components/forms/input_default.dart';
import 'package:hanaang_app/components/navigations/bottom_navigation.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/features/authenticate/forgot_password.dart';
import 'package:hanaang_app/features/authenticate/register.dart';
import 'package:hanaang_app/models/user_login_model.dart';
import 'package:hanaang_app/models/user_model.dart';
import 'package:hanaang_app/providers/auths/auth_provider.dart';
import 'package:hanaang_app/providers/auths/data_refresh_provider.dart';
import 'package:hanaang_app/providers/auths/local_storage_provider.dart';
import 'package:hanaang_app/providers/general/banner_provider.dart';
import 'package:hanaang_app/providers/orders/open_po_provider.dart';
import 'package:hanaang_app/utilities/custom_color.dart';
import 'package:hanaang_app/utilities/next_to.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends ConsumerWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    bool loading = false;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const CustomHeader(
            title: "Login Hanaang App",
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  const TextH2(
                    text: "Teh Tarik Hanaang",
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputDefault(
                    label: 'Email',
                    hintText: 'Masukkan email',
                    controller: emailController,
                    // errorText: formState.emailError,
                    keyboardType: TextInputType.emailAddress,
                    // onChanged: form.updateEmail,
                    onChanged: (vales) {},
                  ),
                  InputDefault(
                    label: 'Password',
                    hintText: 'Masukkan password',
                    controller: passwordController,
                    // errorText: formState.passwordError,
                    isPassword: true,
                    // onChanged: form.updatePassword,
                    onChanged: (vales) {},
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: const TextNormal(
                        text: "Lupa password ?",
                        fontWeight: FontWeight.bold,
                        color: myColors.yellow,
                      ),
                      onPressed: () {
                        Next.to(context, ForgotPassword());
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _handleLogin(context, ref, emailController.text,
                          passwordController.text);
                    },
                    // onPressed: () {
                    //   Next.to(context, BottomNavBar());
                    //   final isValid = form.validate();
                    //   if (isValid) {
                    //     // kirim data ke backend atau proses login
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(content: Text("Login berhasil")),
                    //     );
                    //   }
                    // },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: myColors.yellow,
                      minimumSize: const Size(double.infinity, 50),
                      maximumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: loading
                        ? CustomLoadingIndicator()
                        : const Text(
                            "Masuk",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextNormal(
                        text: "Belum punya akun ?",
                      ),
                      TextButton(
                        onPressed: () {
                          Next.to(context, Register());
                        },
                        child: const TextNormal(
                          text: "Daftar disini",
                          fontWeight: FontWeight.bold,
                          color: myColors.yellow,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
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

void saveUserData(UserLoginModel userData) async {
  final prefs = await SharedPreferences.getInstance();

  final uniqueId = userData.user.uniqueId;
  final name = userData.user.name;
  final email = userData.user.email;
  final phone = userData.user.phoneNumber ?? "";
  final userRole = userData.user.role;
  final token = userData.accessToken;

  await prefs.setString("unique_id-hanaang_app", uniqueId);
  await prefs.setString("name-hanaang_app", name);
  await prefs.setString("email-hanaang_app", email);
  await prefs.setString("phone_number-hanaang_app", phone);
  await prefs.setString("user_role-hanaang_app", userRole);
  await prefs.setString("token-hanaang_app", token);
}

void _handleLogin(
    BuildContext context, WidgetRef ref, String email, String password) async {
  final body = LoginParams(email: email, password: password);
  try {
    final response = await ref.read(loginProvider(body).future);

    print(response);
    if (response["status"] == "success") {
      final data = UserLoginModel.fromJson(response["data"]);
      saveUserData(data);
      Next.to(context, const BottomNavBar());

      // ref.invalidate(getBanner);
      // ref.invalidate(getOpenPreOrderProvider);
      // ref.invalidate(getImageProvider);
      // ref.invalidate(getEmailProvider);
      // ref.invalidate(getNameProvider);
      // ref.invalidate(getPhoneNumberProvider);
      // ref.invalidate(getUserRoleProvider);
      // ref.invalidate(getUniqueIdProvider);
      // ref.invalidate(getTokenProvider);

      Future.delayed(const Duration(milliseconds: 200), () {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Login Berhasil..!"),
            backgroundColor: Colors.green,
          ));
        }
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login gagal..!")));
    }
  } catch (e) {
    print(e);
  }
}
