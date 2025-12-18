import 'package:flutter/material.dart';
import 'package:blgaming_app/ui_value.dart';

class AppBarSearchCate extends StatelessWidget implements PreferredSizeWidget {
  final ValueChanged<String> onChanged;
  final String text;

  const AppBarSearchCate({
    super.key,
    required this.onChanged,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroudColor,
      padding: EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 10),
      child: Row(
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
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: white,
              ),
              child: TextField(
                autocorrect: false,
                enableIMEPersonalizedLearning: false,
                onChanged: onChanged,
                style: TextStyle(
                  color: textColor2,
                  fontFamily: "LD",
                  fontSize: 15,
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
                  hintText: text,
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
