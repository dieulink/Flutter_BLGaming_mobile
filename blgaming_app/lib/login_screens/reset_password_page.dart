import 'package:blgaming_app/login_screens/widgets/custom_form_login.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/imgs/logo_blue.png", width: 170, height: 170),
              Text(
                "Mã OTP đã gửi về Email của bạn",
                style: TextStyle(
                  fontFamily: "LD",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textColor2,
                ),
              ),
              SizedBox(height: 30),
              CustomFormLogin(
                hint: "Nhập mã OTP",
                pathIcon: "assets/icons/system_icon/24px/Message.png",
                obscureText: false,
              ),
              SizedBox(height: 20),
              Text(
                "Đặt lại mật khẩu",
                style: TextStyle(
                  fontFamily: "LD",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textColor2,
                ),
              ),
              SizedBox(height: 30),
              CustomFormLogin(
                hint: "Nhập mật khẩu mới ...",
                pathIcon: "assets/icons/system_icon/24px/Password.png",
                obscureText: false,
              ),
              SizedBox(height: 20),
              CustomFormLogin(
                hint: "Nhập lại mật khẩu mới ...",
                pathIcon: "assets/icons/system_icon/24px/Password.png",
                obscureText: false,
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Đổi mật khẩu",
                    style: TextStyle(
                      fontFamily: "LD",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
