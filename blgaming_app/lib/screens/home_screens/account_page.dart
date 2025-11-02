import 'package:flutter/material.dart';
import 'package:blgaming_app/screens/account_screens/profile/widgets/app_bar_account.dart';
import 'package:blgaming_app/screens/account_screens/profile/widgets/tag_account.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> _showLogoutConfirmation(BuildContext context) async {
      final shouldLogout = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: white,
          title: Text(
            'Xác nhận đăng xuất',
            style: TextStyle(
              color: textColor1,
              fontFamily: "LD",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Bạn có chắc muốn đăng xuất không?',
            style: TextStyle(
              color: textColor3,
              fontFamily: "LD",
              fontSize: 15,
              //fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Hủy',
                    style: TextStyle(
                      color: textColor1,
                      fontFamily: "LD",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    'Đăng xuất',
                    style: TextStyle(
                      color: textColor1,
                      fontFamily: "LD",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

      if (shouldLogout == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        Navigator.pushReplacementNamed(context, 'loginPage');
      }
    }

    return Scaffold(
      //appBar: AppBarAccount(),
      body: Stack(
        children: [
          // Container(
          //   width: getWidth(context),
          //   child: ClipRRect(
          //     child: Image.asset(
          //       "assets/imgs/background3.jpg",
          //       fit: BoxFit.fitWidth,
          //     ),
          //   ),
          // ),
          Container(
            width: getWidth(context),
            color: const Color.fromARGB(163, 0, 0, 0),
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
                  // gradient: LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: [
                  //     mainColor,
                  //     //const Color.fromARGB(120, 28, 56, 142),
                  //     const Color.fromARGB(161, 28, 56, 142),
                  //   ],
                  // ),
                ),
                padding: EdgeInsets.only(top: 100, bottom: 50),
                child: Row(
                  children: [
                    SizedBox(width: 30),
                    Text(
                      "Quản lý tài khoản",
                      style: TextStyle(
                        color: white,
                        fontFamily: "LD",
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      mainColor2,
                      //const Color.fromARGB(120, 28, 56, 142),
                      mainColor,
                    ],
                  ),
                  border: Border.all(color: borderColor),
                ),
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TagAccount(
                      imgPath: "assets/icons/system_icon/24px/User.png",
                      name: "Thông tin cá nhân",
                      ontap: "profilePage",
                    ),
                    TagAccount(
                      imgPath: "assets/icons/system_icon/24px/bag.png",
                      name: "Quản lý đơn hàng",
                      ontap: "listOrderPage",
                    ),
                    TagAccount(
                      imgPath: "assets/icons/system_icon/24px/Right.png",
                      name: "Đăng xuất",
                      ontap: () => _showLogoutConfirmation(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
