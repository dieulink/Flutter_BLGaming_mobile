import 'package:blgaming_app/home_screens/home.dart';
import 'package:blgaming_app/home_screens/home_page.dart';
import 'package:blgaming_app/login_screens/confirm_email_page.dart';
import 'package:blgaming_app/login_screens/login_page.dart';
import 'package:blgaming_app/login_screens/on_boarding_page.dart';
import 'package:blgaming_app/login_screens/register_page.dart';
import 'package:blgaming_app/login_screens/reset_password_page.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'blgaming app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: backgroudColor),
      routes: {'/': (context) => Home()},
    );
  }
}
