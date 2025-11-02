import 'package:flutter/material.dart';
import 'package:blgaming_app/ui_value.dart';

class TagAccount extends StatelessWidget {
  final String imgPath;
  final String name;
  final dynamic ontap;

  const TagAccount({
    super.key,
    required this.imgPath,
    required this.name,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (ontap is String) {
          Navigator.pushNamed(context, ontap);
        } else if (ontap is Function) {
          ontap();
        }
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 15),
        margin: EdgeInsets.symmetric(vertical: 10),
        width: getWidth(context),
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset(imgPath, color: white, width: 30),
                SizedBox(width: 15),
                Text(
                  name,
                  style: TextStyle(
                    color: white,
                    fontSize: 15,
                    fontFamily: "LD",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Container(height: 1, color: borderColor),
          ],
        ),
      ),
    );
  }
}
