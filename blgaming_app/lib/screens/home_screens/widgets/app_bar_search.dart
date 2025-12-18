import 'package:flutter/material.dart';
import 'package:blgaming_app/ui_value.dart';

class AppBarSearch extends StatelessWidget implements PreferredSizeWidget {
  final ValueChanged<String> onChanged;

  const AppBarSearch({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainColor,
      padding: EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: backgroudColor,
              size: 30,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: backgroudColor,
              ),
              child: TextField(
                autocorrect: false,
                enableIMEPersonalizedLearning: false,
                onChanged: onChanged,
                style: TextStyle(color: white, fontFamily: "LD", fontSize: 15),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(color: textColor2, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: backgroudColor, width: 1.5),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  hintText: "Bạn muốn tìm gì ?",
                  hintStyle: TextStyle(color: textColor2, fontFamily: "LD"),
                  suffixIcon: InkWell(
                    child: Icon(Icons.search, color: mainColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
