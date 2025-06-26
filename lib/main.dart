import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/components/navigations/btm_navbar.dart';
import 'package:hanaang_app/features/splash/index.dart';
import 'package:hanaang_app/providers/auths/local_storage_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await initializeDateFormatting(
    'id_ID',
    null,
  );
  runApp(ProviderScope(overrides: [
    sharedPreferencesProvider.overrideWithValue(prefs),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hanaang App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: SplashScreen());
    // home: BtmNavbar());
  }
}
