import 'package:flutter/material.dart';
import 'package:blgaming_app/screens/home_screens/category_page.dart';
import 'package:blgaming_app/ui_value.dart';

class AppBarCate extends StatelessWidget implements PreferredSizeWidget {
  final String hintText;
  final int cateId;
  final String cateName;

  const AppBarCate({
    super.key,
    required this.hintText,
    required this.cateId,
    required this.cateName,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: mainColor2,
      automaticallyImplyLeading: false,
      title: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: mainColor,
                size: 30,
              ),
            ),
            SizedBox(width: 10),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) =>
            //             CategoryPage(id: cateId, name: cateName),
            //       ),
            //     );
            //   },

            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(7),
            //       color: white,
            //       border: Border.all(color: mainColor, width: 1),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         SizedBox(width: 10),
            //         Text(
            //           hintText,
            //           style: TextStyle(
            //             color: textColor2,
            //             fontFamily: "LD",
            //             fontSize: 13,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, "cartPage");
              },
              child: Image.asset(
                "assets/icons/system_icon/24px/Cart.png",
                height: 50,
                color: mainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@override
Size get preferredSize => const Size.fromHeight(kToolbarHeight);
