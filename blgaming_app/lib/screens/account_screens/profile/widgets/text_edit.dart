import 'package:flutter/material.dart';
import 'package:blgaming_app/ui_value.dart';

class TextEdit extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const TextEdit({super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: white,
          fontFamily: "LD",
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
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
        ),
      ),
    );
  }
}
