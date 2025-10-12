import 'package:blgaming_app/login_screens/widgets/custom_form_login.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                "Chào mừng đến với BLGaming !",
                style: TextStyle(
                  fontFamily: "LD",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Đăng nhập để tiếp tục",
                style: TextStyle(
                  fontFamily: "LD",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textColor2,
                ),
              ),
              SizedBox(height: 30),
              CustomFormLogin(
                hint: "Địa chỉ Email ...",
                pathIcon: "assets/icons/system_icon/24px/Message.png",
                obscureText: false,
              ),
              SizedBox(height: 30),
              CustomFormLogin(
                hint: "Mật khẩu ...",
                pathIcon: "assets/icons/system_icon/24px/Password.png",
                obscureText: true,
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
                    "Đăng nhập",
                    style: TextStyle(
                      fontFamily: "LD",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Quên mật khẩu?",
                style: TextStyle(
                  fontFamily: "LD",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textColor2,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bạn chưa có tài khoản? ",
                    style: TextStyle(
                      fontFamily: "LD",
                      fontSize: 14,
                      color: textColor2,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Đăng ký",
                      style: TextStyle(
                        fontFamily: "LD",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
