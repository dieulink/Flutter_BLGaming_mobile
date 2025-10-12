import 'package:blgaming_app/ui_value.dart';
import 'package:flutter/material.dart';

class CustomFormLogin extends StatelessWidget {
  final String hint;
  final String pathIcon;
  final bool obscureText;
  const CustomFormLogin({
    super.key,
    required this.hint,
    required this.pathIcon,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: textColor2,
        fontFamily: "LD",
        // fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(color: textColor2, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: textColor, width: 1.5),
          borderRadius: BorderRadius.circular(7),
        ),
        hintText: hint,
        hintStyle: TextStyle(color: textColor2, fontFamily: "LD"),
        prefixIcon: Padding(
          padding: EdgeInsets.all(1),
          child: Image.asset(pathIcon, width: 20, height: 20),
        ),
      ),
    );
  }
}
