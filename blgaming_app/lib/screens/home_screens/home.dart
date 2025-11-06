import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:blgaming_app/screens/home_screens/account_page.dart';
import 'package:blgaming_app/screens/home_screens/cart_page.dart';
import 'package:blgaming_app/screens/home_screens/home_page.dart';
import 'package:blgaming_app/screens/home_screens/search_page.dart';
import 'package:blgaming_app/screens/home_screens/chat_page.dart';
import 'package:blgaming_app/ui_value.dart';

class Home extends StatefulWidget {
  final int startIndex;
  const Home({super.key, this.startIndex = 0});

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  late int selectedIndex;

  final List<Widget> pages = [
    HomePage(),
    SearchPage(),
    CartPage(),
    ChatPage(),
    AccountPage(),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.startIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroudColor,
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: Container(
        color: backgroudColor,
        padding: EdgeInsets.only(bottom: 10, top: 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: GNav(
            tabBorderRadius: 15,
            backgroundColor: backgroudColor,
            color: textColor2,
            activeColor: mainColor,
            textStyle: TextStyle(
              fontFamily: "LD",
              color: mainColor,
              fontWeight: FontWeight.bold,
            ),
            //tabBackgroundColor: mainColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            tabs: [
              GButton(icon: Icons.home_sharp, text: ' Trang chủ'),
              GButton(icon: Icons.list_alt_sharp, text: ' Danh mục'),
              GButton(icon: Icons.shopping_bag_rounded, text: ' Giỏ hàng'),
              GButton(icon: Icons.support_agent_outlined, text: ' Hỗ trợ'),
              GButton(icon: Icons.account_circle_outlined, text: ' Tài khoản'),
            ],
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
