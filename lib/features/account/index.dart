import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:hanaang_app/components/customs/bg_appbar.dart';
import 'package:hanaang_app/components/texts/h1.dart';
import 'package:hanaang_app/components/texts/h2.dart';
import 'package:hanaang_app/components/texts/h3.dart';
import 'package:hanaang_app/features/account/show_qr_code.dart';
import 'package:hanaang_app/providers/auths/auth_provider.dart';
import 'package:hanaang_app/providers/auths/local_storage_provider.dart';
import 'package:hanaang_app/utilities/custom_color.dart';

class Account extends ConsumerStatefulWidget {
  const Account({super.key});

  @override
  ConsumerState<Account> createState() => _AccountState();
}

class _AccountState extends ConsumerState<Account> {
  String? image;
  String? name;
  String? email;
  String? phoneNumber;
  String? userRole;
  String? id;
  bool loading = false;

  Future<void> _loadStorage() async {
    final localStorage = ref.read(localStorageProvider);
    final getImage = await localStorage.getString('image-hanaang_app');
    final getName = await localStorage.getString('name-hanaang_app');
    final getEmail = await localStorage.getString('email-hanaang_app');
    final getPhoneNumber =
        await localStorage.getString('phone_number-hanaang_app');
    final getUserRole = await localStorage.getString('user_role-hanaang_app');
    final getId = await localStorage.getString('unique_id-hanaang_app');
    setState(() {
      image = getImage;
      name = getName;
      email = getEmail;
      phoneNumber = getPhoneNumber;
      userRole = getUserRole;
      id = getId;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: CustomBgAppBar(),
        centerTitle: true,
        title: TextH1(
          text: "Akun",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
            ),
            onPressed: () {
              ShowQRCodeAccount(context, id.toString(), name.toString());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
                  padding: EdgeInsets.only(top: 15),
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
                              child: image != null
                                  ? Image.asset(
                                      'assets/images/logo_hanaang.png',
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(Icons.person,
                                      color: Colors.white, size: 60)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  TextH1(
                    text: name.toString(),
                    fontWeight: FontWeight.bold,
                  ),
                  TextH3(
                    text: email.toString(),
                    fontWeight: FontWeight.w500,
                  ),
                  TextH3(text: "${phoneNumber ?? "-"}"),
                  TextH2(
                    text: id.toString(),
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: Size(double.infinity, 50),
                        maximumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
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
                  SizedBox(height: 30),

                  // Tombol Logout
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(authStateProvider.notifier)
                          .handleLogout(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
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
          minimumSize: Size(double.infinity, 50),
          maximumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextH3(
              text: name,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
