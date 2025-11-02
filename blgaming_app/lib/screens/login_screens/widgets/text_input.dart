import 'package:flutter/material.dart';
import 'package:blgaming_app/ui_value.dart';

class TextInput extends StatelessWidget {
  final bool isObscureText;
  final String hintText;
  final String iconPath;
  final TextEditingController controller;

  const TextInput({
    super.key,
    required this.isObscureText,
    required this.hintText,
    required this.iconPath,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      style: TextStyle(
        color: textColor2,
        fontFamily: "LD",
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      obscureText: isObscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(color: textColor2, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor, width: 1.5),
          borderRadius: BorderRadius.circular(7),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: textColor2, fontFamily: "LD"),
        prefixIcon: Padding(
          padding: EdgeInsets.all(1),
          child: Image.asset(iconPath),
        ),
      ),
    );
  }
}
