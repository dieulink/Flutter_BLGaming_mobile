import 'package:flutter/material.dart';
import 'package:blgaming_app/ui_value.dart';

class TagProfile extends StatelessWidget {
  final String name;
  final String value;
  final String nextPage;
  final String iconPath;

  const TagProfile({
    super.key,
    required this.name,
    required this.value,
    required this.nextPage,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Navigator.pushNamed(context, nextPage);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(7),
          color: mainColor2,
        ),
        margin: EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(iconPath, color: mainColor3, height: 30),
                SizedBox(width: 15),
                Container(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: mainColor3,
                      fontFamily: "LD",
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  child: Text(
                    value,
                    style: TextStyle(
                      color: white,
                      fontFamily: "LD",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                //Icon(Icons.navigate_next_rounded, color: textColor2, size: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
