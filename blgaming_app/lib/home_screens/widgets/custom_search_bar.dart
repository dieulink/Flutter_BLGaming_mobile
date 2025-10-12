import 'package:blgaming_app/ui_value.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;

  const CustomSearchBar({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(7),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: white,
          border: Border.all(color: mainColor, width: 1),
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/icons/system_icon/24px/Search.png",
              color: mainColor,
              width: 24,
              height: 24,
            ),
            SizedBox(width: 10),
            Text(
              hintText,
              style: TextStyle(color: black, fontFamily: "LD", fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
