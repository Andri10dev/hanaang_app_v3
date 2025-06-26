import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/texts/h1.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/h3.dart';
import 'package:hanaang_app/components/texts/normal.dart';
import 'package:hanaang_app/features/account/logout_state/void_show_dialog.dart';
import 'package:hanaang_app/features/account/show_qr_code.dart';
import 'package:hanaang_app/providers/auths/local_storage_provider.dart';
import 'package:hanaang_app/utilities/custom_color.dart';

class Account extends ConsumerWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.watch(getImageProvider).toString();
    final name = ref.watch(getNameProvider).toString();
    final email = ref.watch(getEmailProvider).toString();
    final phoneNumber = ref.watch(getPhoneNumberProvider).toString();
    final userRole = ref.watch(getUserRoleProvider).toString();
    final id = ref.watch(getUniqueIdProvider).toString();

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const CustomBgAppBar(),
        centerTitle: true,
        title: const TextH1(
          text: "Akun",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
            ),
            onPressed: () {
              ShowQRCodeAccount(context, id.toString(), name);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(getEmailProvider);
          ref.invalidate(getNameProvider);
          ref.invalidate(getPhoneNumberProvider);
          ref.invalidate(getUserRoleProvider);
          ref.invalidate(getUniqueIdProvider);
        },
        child: ListView(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Image.asset(
                    'assets/images/header.png',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          width: 135,
                          height: 135,
                          decoration: BoxDecoration(
                              color: myColors.yellow,
                              border: Border.all(
                                  width: 2,
                                  color: Colors.black.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(100)),
                          child: ClipOval(
                              child: image.isNotEmpty
                                  ? Image.asset(
                                      'assets/images/logo_hanaang.png',
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(Icons.person,
                                      color: Colors.white, size: 60)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  TextH1(
                    text: name,
                    fontWeight: FontWeight.bold,
                  ),
                  TextH3(
                    text: email,
                    fontWeight: FontWeight.w500,
                  ),
                  TextH3(
                    text: userRole,
                    fontWeight: FontWeight.w500,
                  ),
                  TextH3(text: "${phoneNumber ?? '-'}"),
                  TextH2(
                    text: id,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(double.infinity, 50),
                        maximumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextH3(
                            text: "Cashback",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          TextH2(
                            text: "Rp. 200.000",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _btnAccount(
                    "Pemberitahuan",
                    () {},
                  ),
                  _btnAccount(
                    "Atur Alamat",
                    () {},
                  ),
                  _btnAccount(
                    "Atur Password",
                    () {},
                  ),
                  _btnAccount(
                    "Pengaturan Akun",
                    () {},
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      showLogoutConfirmation(context, ref);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        TextH3(
                          text: "Logout",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _btnAccount(
    String name,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: myColors.yellow,
          minimumSize: const Size(double.infinity, 50),
          maximumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextNormal(
              text: name,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
