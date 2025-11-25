import 'package:flutter/material.dart';
import 'package:blgaming_app/screens/home_screens/home.dart';
import 'package:blgaming_app/ui_value.dart';

class AppBarChatbot extends StatelessWidget implements PreferredSizeWidget {
  const AppBarChatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 22, 22, 22),
      padding: EdgeInsets.only(top: 20, left: 10, right: 25, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Image.asset("assets/imgs/chatbot2.gif"),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Text(
              "BL-Gaming Chatbot",
              style: TextStyle(
                color: mainColor,
                fontFamily: "LD",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Image.asset("assets/imgs/chatbot4.gif", height: 40),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Image.asset("assets/imgs/chatbot3.gif", height: 40),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
