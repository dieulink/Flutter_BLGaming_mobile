import 'package:flutter/material.dart';
import 'package:blgaming_app/ui_value.dart';

class AppBarBrandCustom extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  const AppBarBrandCustom({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 30, left: 10, right: 25, bottom: 10),
      child: Row(
        children: [
          SizedBox(width: 10),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: mainColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  name,
                  style: TextStyle(
                    color: mainColor,
                    fontFamily: "LD",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
