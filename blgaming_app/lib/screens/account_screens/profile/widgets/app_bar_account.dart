import 'package:flutter/material.dart';
import 'package:blgaming_app/ui_value.dart';

class AppBarAccount extends StatelessWidget implements PreferredSizeWidget {
  const AppBarAccount({super.key});

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
                SizedBox(width: 10),
                Text(
                  "Quản lý tài khoản",
                  style: TextStyle(
                    color: textColor1,
                    fontFamily: "LD",
                    fontSize: 17,
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
