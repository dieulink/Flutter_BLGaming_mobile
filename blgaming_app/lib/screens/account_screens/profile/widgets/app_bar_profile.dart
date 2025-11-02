import 'package:flutter/material.dart';
import 'package:blgaming_app/ui_value.dart';

class AppBarProfile extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  const AppBarProfile({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            mainColor2,
            //const Color.fromARGB(120, 28, 56, 142),
            mainColor,
          ],
        ),
      ),
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
                    color: white,
                    size: 20,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  name,
                  style: TextStyle(
                    color: white,
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
