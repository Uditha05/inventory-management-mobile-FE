import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inventory_management/config/language_config.dart';
import 'package:inventory_management/screen/login/login_screen.dart';
import 'package:inventory_management/screen/office_clerk/qr_scan.dart';

final storage = FlutterSecureStorage();
void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Inventory Management',
      translations: Language(),
      locale: Locale('en', "US"),
      theme: ThemeData(
        backgroundColor: Color(0xFF00875A),
        primaryColor: Color(0xFF00875A),
      ),
      home: LoginScreen(), //QRScannPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
