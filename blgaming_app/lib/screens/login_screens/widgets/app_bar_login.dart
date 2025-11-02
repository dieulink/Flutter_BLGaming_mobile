import 'package:flutter/material.dart';
import 'package:blgaming_app/ui_value.dart';

class AppBarLogin extends StatelessWidget implements PreferredSizeWidget {
  const AppBarLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
