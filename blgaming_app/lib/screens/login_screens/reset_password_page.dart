import 'package:flutter/material.dart';
import 'package:blgaming_app/screens/login_screens/widgets/app_bar_login.dart';
import 'package:blgaming_app/screens/login_screens/widgets/button_input_login.dart';
import 'package:blgaming_app/screens/login_screens/widgets/button_input_reset_password.dart';
import 'package:blgaming_app/screens/login_screens/widgets/text_input.dart';
import 'package:blgaming_app/ui_value.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final otpController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/imgs/background7.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(color: const Color.fromARGB(74, 0, 0, 0)),
          SingleChildScrollView(
            child: Container(
              height: getHeight(context),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(201, 0, 0, 14),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: mainColor,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      "assets/imgs/logo_blue.png",
                      height: 150,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor),
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(218, 0, 0, 0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Nhập mã OTP ",
                          style: TextStyle(
                            fontFamily: "LD",
                            fontSize: 15,
                            color: textColor2,
                          ),
                        ),
                        SizedBox(height: 30),
                        TextInput(
                          controller: otpController,
                          isObscureText: false,
                          hintText: "Mã OTP",
                          iconPath:
                              'assets/icons/system_icon/24px/Password.png',
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 1,
                          child: Container(color: textColor2),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Đặt lại mật khẩu",
                          style: TextStyle(
                            fontFamily: "LD",
                            fontSize: 15,
                            color: textColor2,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextInput(
                          controller: passwordController,
                          isObscureText: true,
                          hintText: "Mật khẩu",
                          iconPath:
                              'assets/icons/system_icon/24px/Password.png',
                        ),
                        SizedBox(height: 20),
                        TextInput(
                          controller: confirmPasswordController,
                          isObscureText: true,
                          hintText: "Xác nhận mật khẩu",
                          iconPath:
                              'assets/icons/system_icon/24px/Password.png',
                        ),
                        SizedBox(height: 30),
                        ButtonInputResetPassword(
                          text: "Đổi mật khẩu",
                          otpController: otpController,
                          passwordController: passwordController,
                          confirmPasswordController: confirmPasswordController,
                          email: email,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
