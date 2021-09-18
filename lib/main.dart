import 'package:flutter/material.dart';
import 'package:inventory_management/screen/login/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Color(0xFF00875A),
        primaryColor: Color(0xFF00875A),
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
