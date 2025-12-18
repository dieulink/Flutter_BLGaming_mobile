import 'package:flutter/material.dart';
import 'package:blgaming_app/ui_value.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, "loginPage");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset("assets/imgs/background7.jpg", fit: BoxFit.cover),
        ),
        Container(color: const Color.fromARGB(74, 0, 0, 0)),
        Container(
          // color: mainColor,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 400),
              child: Image.asset('assets/imgs/logo_blue.png', height: 200),
            ),
          ),
        ),
      ],
    );
  }
}
