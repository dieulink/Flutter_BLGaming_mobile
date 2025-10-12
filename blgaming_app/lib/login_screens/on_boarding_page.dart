import 'package:blgaming_app/ui_value.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Image.asset(
          "assets/imgs/logo_white.png",
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
